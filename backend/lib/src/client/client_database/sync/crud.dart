import 'dart:convert';

import 'package:backend/client_library.dart';

extension Crud on ClientDatabase {
  Future<int> interpretIssuedServerTimestamp(
      String lastIssuedServerTimestamp) async {
    return await clientDrift.usersDrift
        .setLastSyncTime(newLastSyncTime: lastIssuedServerTimestamp);
  }

  /// Inserts events not already present from bundles not already
  /// present
  Future<void> insertNewEventsFromNewBundles(List<Bundle> bundles) async {
    final List<String> bundleIdsToIgnore = [];
    for (final bundle in bundles) {
      final status =
          await clientDrift.sharedDrift.sharedBundlesDrift.insertBundle(
        id: bundle.id,
        userId: bundle.userId,
        timestamp: bundle.timestamp,
        // NOTE: we only store events once in the events table
        payload: null,
      );

      if (status == 0) bundleIdsToIgnore.add(bundle.id);
    }

    final newEvents = bundles.expand((e) {
      if (bundleIdsToIgnore.contains(e.id)) return [];
      if (e.payload == null) return [];
      return EventPayload.fromJson(jsonDecode(e.payload!)).events;
    });

    for (final event in newEvents) {
      await clientDrift.insertLocalEventWithClientId(event);
      await clientDrift.insertEventIntoAttributes(event);
    }
  }

  Future<void> registerBundlesPersistedToServerWithoutPayload(
      List<Bundle> bundlesPersistedToServer) async {
    for (final bundle in bundlesPersistedToServer) {
      await clientDrift.sharedDrift.sharedBundlesDrift.insertBundle(
        id: bundle.id,
        userId: bundle.userId,
        timestamp: bundle.timestamp,
        // THINK: maybe store events which the client thinks are in this bundle
        // THINK: maybe a table which would relate events to bundles
        payload: null,
      );
    }
  }
}
