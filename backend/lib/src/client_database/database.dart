import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';

import 'package:backend/shared_database.dart';
import 'config.dart';
import 'database.drift.dart';
import 'setup.dart';

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
  }) : super(executor ?? _openConnection(file: file)) {
    // TODO ideally it should be initialized with the id value from config
  }

  Future<void> get isInitialized => executor.ensureOpen(this);

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
            initializeClient();
            throw InvalidDatabaseConfigException(
                "Upon initialization no initial Config provided");
          }
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
  Future<void> ensureInitialized() async {
    // final config = await clientDrift.usersDrift.getConfig().getSingleOrNull();
    // await clientDrift.usersDrift.getCurrentClient().get();
  }
}
