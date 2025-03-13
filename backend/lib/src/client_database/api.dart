import 'dart:convert';

import 'package:backend/client_definitions.dart';
import 'package:backend/messaging.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:uuidv7/uuidv7.dart';

import 'database.dart';

extension Api on ClientDatabase {
  Future<PostBundlesQuery> pushEvents() async {
    final events = await clientDrift.eventsDrift.getLocalEventsToPush().get();
    final config = await clientDrift.usersDrift.getConfig().getSingleOrNull() ??
        (throw InvalidConfigException("Not exactly one row in the user config table"));

    if (config.userToken == null || config.userId == null || config.clientId == null) {
      throw InvalidConfigException("Config contains uninitialized values");
    }

    final bundle = Bundle(
      // THINK: at which point should we create this id? maybe the server
      //  should assign it
      id: generateUuidV7String(),
      userId: config.userId!,
      timestamp: HLC().sendPacked(),
      payload: jsonEncode(EventPayload(events: events).toJson()),
    );

    await clientDrift.sharedDrift.sharedBundlesDrift.insertBundle(
      id: bundle.id,
      userId: bundle.userId,
      timestamp: bundle.timestamp,
      // THINK: maybe store events which the client thinks are in this bundle
      payload: null,
    );

    final query = PostBundlesQuery(
        config.userToken!, config.userId!, HLC().sendPacked(), config.lastServerIssuedTimestamp, [bundle]);
    return query;
  }

  Future<void> pullEvents(PostBundlesResponse response) async {
    await transaction(() async {
      await insertNewEventsFromNewBundles(response.newBundles);
      await clientDrift.usersDrift.setLastSyncTime(newLastSyncTime: response.lastIssuedServerTimestamp);
    });
  }

  /// Inserts events not already present from bundles not already
  /// present
  Future<void> insertNewEventsFromNewBundles(List<Bundle> bundles) async {
    final List<String> bundleIdsToIgnore = [];
    for (final bundle in bundles) {
      final status = await clientDrift.sharedDrift.sharedBundlesDrift.insertBundle(
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
      await clientDrift.insertLocalEventIntoAttributes(event);
    }
  }

  Future<GetBundleIdsQuery> requestAllServerBundleIds() async {
    final config = await clientDrift.usersDrift.getConfig().getSingleOrNull() ??
        (throw InvalidConfigException("Not exactly one row in the user config table"));

    if (config.userToken == null || config.userId == null) {
      throw InvalidConfigException("Config contains uninitialized values");
    }

    return GetBundleIdsQuery(
      config.userToken!,
      config.userId!,
      sinceTimestamp: null,
    );
  }

  // AIUSE: helped fill out the signatures

  Future<List<String>> getMissingBundleIds(GetBundleIdsResponse response) async {
    final localBundleIds = (await clientDrift.sharedDrift.sharedBundlesDrift
        .getAllBundlesIds().get()).toSet();

    final serverBundleIds = response.bundleIds.toSet();
    final missingBundleIds = serverBundleIds.difference(localBundleIds).toList();

    return missingBundleIds;
  }

  Future<GetBundlesQuery> requestBundles(List<String> bundleIds) async {
    final config = await clientDrift.usersDrift.getConfig().getSingleOrNull() ??
        (throw InvalidConfigException("Not exactly one row in the user config table"));

    if (config.userToken == null || config.userId == null) {
      throw InvalidConfigException("Config contains uninitialized values");
    }

    return GetBundlesQuery(
      config.userToken!,
      config.userId!,
      bundleIds,
    );
  }

  Future<void> interpretRequestedBundles(GetBundlesResponse response) async {
    await transaction(() async {
      await insertNewEventsFromNewBundles(response.bundles);
      // TODO: also update timestamp?
    });
  }
}
