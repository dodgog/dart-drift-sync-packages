import 'dart:io';

import 'package:backend/client_database.dart';
import 'package:backend/messaging.dart';
import 'package:backend/shared_database.dart';
import 'package:backend/src/client_database/interface.dart';
import 'package:backend/src/client_database/node_helper.dart';
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
    implements ClientDatabaseInterface {
  @visibleForTesting
  ClientDatabase({
    this.initialConfig,
    QueryExecutor? executor,
    File? file,
  }) : super(executor ?? _openConnection(file: file)) {
    // TODO ideally it should be initialized with the id value from config
  }

  static ClientDatabaseInterface createInterface({
    ClientDatabaseConfig? initialConfig,
    QueryExecutor? executor,
    File? file,
  }) {
    return ClientDatabase(
      initialConfig: initialConfig,
      executor: executor,
      file: file,
    );
  }

  final ClientDatabaseConfig? initialConfig;

  late JsonCommunicator? _sendJsonAndGetResponse;

  JsonCommunicator get communicator =>
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
  Future<void> initialize({JsonCommunicator? sendJsonAndGetResponse}) async {
    await _didExecutorOpen;

    _sendJsonAndGetResponse = sendJsonAndGetResponse;

    _nodeHelper = NodeHelper(this);
  }

  @override
  Future<void> sync() async {
    final outgoing = (await pushEvents()).toJson();
    final response = await communicator(outgoing);
    return await pullEvents(PostBundlesResponse.fromJson(response));
  }

  @override
  Future<int> verifyBundlesAndPullMissing() async {
    throw UnimplementedError();
  }

  @override
  NodeHelper getNodeHelper() => _nodeHelper;

// Private helper methods...
}
