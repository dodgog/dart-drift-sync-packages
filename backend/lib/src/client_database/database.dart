import 'dart:convert';
import 'dart:io';

import 'package:backend/client_definitions.dart';
import 'package:backend/messaging.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:uuidv7/uuidv7.dart';

import 'database.drift.dart';

class InvalidConfigException implements Exception {
  final String message;

  InvalidConfigException(this.message);
}

@DriftDatabase(
  include: {'package:backend/client.drift'},
)
class ClientDatabase extends $ClientDatabase {
  ClientDatabase({
    this.initialConfig,
    QueryExecutor? executor,
    File? file,
  }) : super(executor ?? _openConnection(file: file))  {
    // TODO ideally it should be initialized with the id value from config
  }

  final ClientDatabaseConfig? initialConfig;

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
          if (initialConfig == null) {
            throw InvalidDatabaseConfigException(
                "Upon initialization no initial Config provided");
          }

          await clientDrift.usersDrift.initializeConfig();
          await clientDrift.usersDrift
              .setUserToken(newUserToken: initialConfig!.userToken);
          await clientDrift.usersDrift
              .setClientId(newClientId: initialConfig!.clientId);
          await clientDrift.usersDrift
              .setUserId(newUserId: initialConfig!.userId);

          await clientDrift.sharedDrift.sharedUsersDrift.createClient(
              clientId: initialConfig!.clientId, userId: initialConfig!.userId);
        }
        final currentClient =
            await clientDrift.usersDrift.getCurrentClient().getSingle();
        // TODO: also initialize previous locally issued time!
        // For now initialize to physical time
        // hoping that it will always be larger on the same device than the
        // previous issued logical timestamp, which may not always be the case
        // (i don't really understand what's worst case here)
        HLC.initialize(clientNode: ClientNode(currentClient.id));
      },
    );
  }

  /// THINK: silly filler function: unless you call some db.operation it won't
  /// THINK: run the migration, but using HLC is conditional on the db being
  /// THINK: initialized
  /// TODO: move to HLC not being a singleton but rather a database attribute
  Future<void> ensureInitialized()async{
    // final config = await clientDrift.usersDrift.getConfig().getSingleOrNull();
    await clientDrift.usersDrift.getCurrentClient().get();

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
    final query = PostQuery(config.userToken!, config.userId!,
        HLC().sendPacked(), config.lastServerIssuedTimestamp, [
      Bundle(
        // THINK: at which point should we create this id? maybe the server
        //  should assign it
        id: generateUuidV7String(),
        userId: config.userId!,
        timestamp: HLC().sendPacked(),
        payload: jsonEncode(EventPayload(events: events).toJson()),
      )
    ]);
    return query;
  }

  Future<void> pullEvents(PostResponse response) async {
    // THINK: Managing bundles on device here
    // perhaps reference the local bundles table and check if it already exists
    // local bundles can store empty payloads
    final events = response.newBundles.expand((e) {
      if (e.payload == null) return [];
      return EventPayload.fromJson(jsonDecode(e.payload!)).events;
    });

    await transaction(() async {
      for (final event in events) {
        // for (final event in response.events) {
        clientDrift.insertLocalEventWithClientId(event);
        clientDrift.insertLocalEventIntoAttributes(event);
      }
      await clientDrift.usersDrift
          .setLastSyncTime(newLastSyncTime: response.lastIssuedServerTimestamp);
    });
  }
}
