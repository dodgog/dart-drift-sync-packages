import 'dart:convert';

import 'package:backend/messaging.dart';
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

  Future<PostResponse> interpretIncomingPostQueryAndRespond(
      PostQuery postQuery) async {
    final isAuthorized = await verifyUser(postQuery.userId, postQuery.token);
    if (!isAuthorized) {
      throw UnauthorizedException('Invalid user credentials');
    }

    final newEvents = await insertEventsForUserAndGetEventsSinceTimestamp(
      postQuery.events,
      postQuery.lastIssuedServerTimestamp,
      postQuery.userId,
    );

    final currentServerTimestamp =
        await getLatestServerTimestamp(postQuery.userId);

    return PostResponse(currentServerTimestamp, newEvents);
  }

  Future<String> getLatestServerTimestamp(String userId) async {
    final retrievedTimeStamp = await (serverDrift.eventsDrift
        .getLatestTimestampAffectingUser(userId: userId)
        .getSingle());
    return retrievedTimeStamp ?? DateTime.now().toIso8601String();
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
          // FIXME
          // FEEDBACK
          print("inserting an event already with server timestamp");
        }
        await serverDrift.eventsDrift.insertEvent(
          id: event.id,
          type: event.type,
          clientId: event.clientId,
          targetNodeId: event.targetNodeId,
          serverTimeStamp: DateTime.now().toIso8601String(),
          clientTimeStamp: event.clientTimeStamp,
          content: event.content,
        );
      }

      eventsSinceTimestamp = await serverDrift.eventsDrift
          .getUserEventsSinceTimestamp(timestamp: timestamp, userId: userId)
          .get();
    });
    return eventsSinceTimestamp;
  }
}
