import 'dart:io';

import 'package:backend/messaging.dart';
import 'package:backend/shared_database.dart';
import 'package:backend/src/server_database/auth.dart';
import 'package:backend/src/server_database/interface.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:meta/meta.dart';

import 'api.dart';
import 'database.drift.dart';
import 'internal/config.dart';

@DriftDatabase(
  include: {'package:backend/server.drift'},
)
class ServerDatabase extends $ServerDatabase
    implements ServerDatabaseInterface {
  /// Internal database constructor with access to all the database methods.
  ///
  /// For apps, use the ServerDatabase.create factory
  @visibleForTesting
  ServerDatabase({
    this.initialConfig,
    QueryExecutor? executor,
    File? file,
  }) : super(executor ?? _openConnection(file: file));

  // TODO: make this constructor the only thing available to the consumer
  static ServerDatabaseInterface createInterface({
    ServerDatabaseConfig? initialConfig,
    QueryExecutor? executor,
    File? file,
  }) {
    return ServerDatabase(
      initialConfig: initialConfig,
      executor: executor,
      file: file,
    );
  }

  final ServerDatabaseConfig? initialConfig;

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
        // TODO get the last issued timestamp to ensure continuous issuance
        HLC.initialize(clientNode: ClientNode("server"));
        if (details.wasCreated) {
          if (initialConfig == null) {
            throw InvalidDatabaseConfigException(
                "Upon initialization no initial Config provided");
          }
        }
      },
    );
  }

  @override
  Future<void> initialize() async {
    if (await executor.ensureOpen(this) != true) {
      throw DatabaseInitException("Executor couldn't open");
    }
  }

  @override
  Future<Map<String, dynamic>> interpretQueryAndRespond(
      Map<String, dynamic> parsedJsonMap) async {
    final baseQuery = BaseQuery.fromJson(parsedJsonMap);
    final isAuthorized = await verifyUser(baseQuery.userId, baseQuery.token);
    if (!isAuthorized) {
      throw UnauthorizedException('Invalid user credentials');
    }

    switch (baseQuery.type) {
      case "post_bundles_query":
        return (await interpretIncomingAuthedPostBundlesQueryAndRespond(
                baseQuery as PostBundlesQuery))
            .toJson();
      case "get_bundle_ids_query":
        return (await interpretIncomingAuthedGetBundleIdsAndRespond(
                baseQuery as GetBundleIdsQuery))
            .toJson();
      case "get_bundles_query":
        return (await interpretIncomingAuthedGetBundlesAndRespond(
                baseQuery as GetBundlesQuery))
            .toJson();
      default:
        throw UnrecognizedQueryException(
            'Unrecognized query type: ${baseQuery.type} or invalid implementation '
            'type');
    }
  }

  @override
  Future<void> createAuthedUserAndClient(
      String userId, String userName, String clientId, String token) async {
    await createUserClientAndAuth(userId, userName, clientId, token);
  }
}
