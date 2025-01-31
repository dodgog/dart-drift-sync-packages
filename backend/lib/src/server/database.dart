import 'dart:convert';

import 'package:drift/drift.dart';
import 'database.drift.dart';
import 'package:backend/server_definitions.dart';
import 'package:drift/native.dart';
import 'dart:io';

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}

@DriftDatabase(
  include: {'package:backend/server.drift'},
)
class ServerDatabase extends $ServerDatabase {
  ServerDatabase({QueryExecutor? executor, File? file})
      : super(executor ?? _openConnection(file: file));

  static QueryExecutor _openConnection({File? file}) {
    if (file != null) {
      return NativeDatabase.createInBackground(file);
    } else {
      return NativeDatabase.memory();
    }
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        // if (details.wasCreated) {
        //   await serverDrift.usersDrift
        //       .authUser(userId: "user1", token: "user1token");
        // }
      },
    );
  }

  Future<String> interpretIncomingJsonAndRespond(String incoming) async {
    final (token, userId, lastIssuedServerTimestamp, events) =
        decodeJsonPost(incoming);

    final isAuthorized = await verifyUser(userId, token);
    if (!isAuthorized) {
      throw UnauthorizedException('Invalid user credentials');
    }

    final newEvents = await insertEventsForUserAndGetEventsSinceTimestamp(
      events,
      lastIssuedServerTimestamp,
      userId,
    );

    final currentServerTimestamp = await getLatestServerTimestamp(userId);

    return encodeResponse(currentServerTimestamp, newEvents);
  }

  Future<String> getLatestServerTimestamp(String userId) async {
    final retrievedTimeStamp = await (serverDrift.eventsDrift
        .getLatestTimestampAffectingUser(userId: userId)
        .getSingle());
    return retrievedTimeStamp ?? DateTime.now().toIso8601String();
  }

  /// assume json
  /// {
  /// "token": "user1token",
  /// "userId": "user1",
  /// "lastIssuedServerTimestamp": "iso8601timestamp",
  /// "events": [{encoded Event as json},...]
  /// }
  (
    String token,
    String user,
    String lastIssuedServerTimestamp,
    List<Event> events
  ) decodeJsonPost(String json) {
    // todo: make a class for post query and response
    try {
      // Decode JSON string to Map
      final Map<String, dynamic> decoded = jsonDecode(json);

      // Extract and validate required fields
      final token = decoded['token'] as String? ??
          (throw FormatException('Missing or invalid token'));

      final userId = decoded['user_id'] as String? ??
          (throw FormatException('Missing or invalid user'));

      final lastIssuedServerTimestamp =
          decoded['last_issued_server_timestamp'] as String? ??
              (throw FormatException('Missing or invalid timestamp'));

      final List<dynamic> eventsJson = decoded['events'] as List<dynamic>? ??
          (throw FormatException('Missing events'));

      final List<Event> events = eventsJson
          .map((eventJson) => Event.fromJson(eventJson as Map<String, dynamic>))
          .toList();

      return (token, userId, lastIssuedServerTimestamp, events);
    } on FormatException catch (e) {
      throw FormatException('JSON format error: ${e.message}');
    } on TypeError catch (e) {
      throw FormatException('Type mismatch in JSON structure: $e');
    } catch (e) {
      throw FormatException('Error processing JSON: $e');
    }
  }

  /// assume json
  /// {
  ///   "latestServerTimestamp": "iso8601timestamp",
  ///   "events": [
  ///   {encoded Event as json},...
  ///   ]
  /// }
  String encodeResponse(String latestServerTimestamp, List<Event> events) {
    try {
      final Map<String, dynamic> response = {
        'latestServerTimestamp': latestServerTimestamp,
        'events': events.map((event) => event.toJson()).toList(),
      };

      return jsonEncode(response);
    } catch (e) {
      throw FormatException('Error encoding response: $e');
    }
  }

  Future<bool> verifyUser(String userId, String token) async {
    return await serverDrift.usersDrift
        .userExistsAndAuthed(
          userId: userId,
          token: token,
        )
        .getSingle();
  }

  Future<List<Event>> insertEventsForUserAndGetEventsSinceTimestamp(
      List<Event> events, String timestamp, String userId) async {
    late final List<Event> eventsSinceTimestamp;
    await transaction(() async {
      for (final event in events) {
        if (event.serverTimeStamp != null) {
          // todo
          print("inserting an event already with server timestamp");
        }
        await serverDrift.eventsDrift.insertEvent(
          id: event.id,
          type: event.type,
          clientId: event.clientId,
          serverTimeStamp: DateTime.now().toIso8601String(),
          clientTimeStamp: event.clientTimeStamp,
          content: event.content,
        );
      }

      eventsSinceTimestamp =
          await serverDrift.eventsDrift.getUserEventsSinceTimestamp
            (timestamp: timestamp, userId: userId).get();
    });
    return eventsSinceTimestamp;
  }
}
