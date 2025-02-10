import 'dart:convert';

import 'package:backend/messaging.dart';
import 'package:drift/drift.dart';
import 'database.drift.dart';
import 'package:backend/client_definitions.dart';
import 'package:drift/native.dart';
import 'dart:io';

class InvalidConfigException implements Exception {
  final String message;
  InvalidConfigException(this.message);
}

@DriftDatabase(
  include: {'package:backend/client.drift'},
)
class ClientDatabase extends $ClientDatabase {
  ClientDatabase({QueryExecutor? executor, File? file})
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
        if (details.wasCreated) {
          await clientDrift.usersDrift.initializeConfig();
          // await clientDrift.usersDrift.setUserToken(newUserToken: newUserToken);
        }
      },
    );
  }

  void aa()async{
    events.select().get();
  }

  Future<PostQuery> pushEvents() async {
    final events = await clientDrift.eventsDrift.getLocalEventsToPush().get();
    final config = await clientDrift.usersDrift.getConfig().getSingleOrNull() ??
        (throw InvalidConfigException(
            "Not exactly one row in the user config table"));

    if (config.userToken == null ||
        config.userId == null ||
        config.clientId == null) {
      throw InvalidConfigException("Config contains uninitialized values");
    }
    final query = PostQuery(
        config.userToken!,
        config.userId!,
        config.lastIssuedTimestamp ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
        events);
    return query;
  }

  Future<void> pullEvents(PostResponse response) async {
    await transaction(() async {
      for (final event in response.events) {
        await clientDrift.eventsDrift.insertServerEvent(
            id: event.id,
            type: event.type,
            clientId: event.clientId,
            serverTimeStamp: event.serverTimeStamp,
            clientTimeStamp: event.clientTimeStamp,
            content: event.content);
      }
      await clientDrift.usersDrift
          .setLastSyncTime(newLastSyncTime: response.lastIssuedServerTimestamp);
    });
  }
}
