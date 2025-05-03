import 'dart:io';

import 'package:backend/client_library.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:meta/meta.dart';

import 'database.drift.dart';
import 'setup.dart';

@DriftDatabase(
  include: {'package:backend/client.drift'},
)
class ClientDatabase extends $ClientDatabase
    implements CoreDataInterface {
  @visibleForTesting
  ClientDatabase({
    this.initialConfig,
    QueryExecutor? executor,
    File? file,
  }) : super(executor ?? _openConnection(file: file)) {
    // Initialize SyncService
    _syncService = SyncService(this);
  }

  static CoreDataInterface createInterface({
    CoreDataClientConfig? initialConfig,
    QueryExecutor? executor,
    File? file,
  }) {
    return ClientDatabase(
      initialConfig: initialConfig,
      executor: executor,
      file: file,
    );
  }

  final CoreDataClientConfig? initialConfig;
  late final SyncService _syncService;

  late JsonServerMessenger? _sendJsonAndGetResponse;

  JsonServerMessenger get communicator =>
      _sendJsonAndGetResponse ??
      (throw DatabaseInitException("Json communicator not initialized"));
  late NodeHelper _nodeHelper;

  Future<bool> get _didExecutorOpen => executor.ensureOpen(this);

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
          await initializeClientWithInitialConfig();
          if (initialConfig == null) {
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

  @visibleForTesting
  static void cleanSlateForTesting() {
    HLC.reset();
  }

  @override
  Future<void> initializeWebMessageChannel({JsonServerMessenger? sendJsonAndGetResponse}) async {
    await _didExecutorOpen;

    _sendJsonAndGetResponse = sendJsonAndGetResponse;

    _nodeHelper = NodeHelper(this);
  }

  /// NOTE: also could be triggerable automatically, but here delegated to the
  /// client app
  @override
  Future<void> sync() async {
    return await _syncService.sync();
  }

  /// NOTE: also could be triggerable automatically, but here delegated to the
  /// client app
  @override
  Future<int> verifyBundlesAndPullMissing() async {
    return await _syncService.verifyBundlesAndPullMissing();
  }

  @override
  NodeHelper getNodeHelper() => _nodeHelper;

// Private helper methods...
}

// Extension that adds a method to access the SyncService
extension ClientDatabaseTestExtension on ClientDatabase {
  SyncService createSyncService() {
    return SyncService(this);
  }
}
