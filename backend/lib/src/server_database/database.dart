import 'dart:io';

import 'package:backend/messaging.dart';
import 'package:backend/server_definitions.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';

import 'database.drift.dart';
import 'auth.dart';

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}

@DriftDatabase(
  include: {'package:backend/server.drift'},
)
class ServerDatabase extends $ServerDatabase {
  ServerDatabase({
    this.initialConfig,
    QueryExecutor? executor,
    File? file,
  }) : super(executor ?? _openConnection(file: file));

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

  Future<PostBundlesResponse> interpretIncomingPostBundlesQueryAndRespond(
      PostBundlesQuery postQuery) async {
    final isAuthorized = await verifyUser(postQuery.userId, postQuery.token);
    if (!isAuthorized) {
      throw UnauthorizedException('Invalid user credentials');
    }

    HLC().receivePacked(postQuery.clientTimestamp);

    final insertedBundleIds = await insertBundles(
      postQuery.bundles,
    );

    // Get new bundles but also should get the ones which were just inserted.
    // Could be used for confirmation of receipt.
    final newBundles = await getBundlesSinceTimestamp(
      postQuery.userId,
      postQuery.lastIssuedServerTimestamp,
    );

    return PostBundlesResponse(
      HLC().sendPacked(),
      insertedBundleIds,
      newBundles.where((e) => !insertedBundleIds.contains(e.id)).toList(),
    );
  }


  Future<List<String>> insertBundles(List<Bundle> bundles) async {
    // TODO: verify owner user
    // THINK: what should be the logic of event and bundle ownership?
    final List<String> insertedIds = [];
    for (final bundle in bundles) {
      final status =
          await serverDrift.sharedDrift.sharedBundlesDrift.insertBundle(
        id: bundle.id,
        userId: bundle.userId,
        timestamp: bundle.timestamp,
        payload: bundle.payload,
      );
      if (status != 0) {
        insertedIds.add(bundle.id);
      }
    }
    return insertedIds;
  }

  Future<List<Bundle>> getBundlesSinceTimestamp(
      String userId, String timestamp) async {
    return await serverDrift.bundlesDrift
        .getUserBundlesSinceTimestamp(userId: userId, timestamp: timestamp)
        .get();
  }
}
