import 'dart:convert';

import 'package:backend/client_library.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:uuidv7/uuidv7.dart';

import '../read.dart';
import '../setup.dart';

class SyncService {
  final ClientDatabase _database;

  SyncService(this._database);

  Future<PostBundlesQuery> pushEvents() async {
    final config = await _database.getVerifiedConfig();
    final events = await _database.getLocalEvents();

    final bundle = Bundle(
      id: generateUuidV7String(),
      userId: config.userId!,
      timestamp: HLC().sendPacked(),
      payload: jsonEncode(EventPayload(events: events).toJson()),
    );

    final query = PostBundlesQuery(
      config.userId!,
      config.userToken!,
      HLC().sendPacked(),
      config.lastServerIssuedTimestamp,
      [bundle],
    );
    return query;
  }

  Future<void> pullEvents(PostBundlesResponse response,
      {List<Bundle>? postedBundles}) async {
    final insertedBundleIds = response.insertedBundleIds.toSet();
    final bundlesPersistedToServer =
        postedBundles?.where((e) => insertedBundleIds.contains(e));

    await _database.transaction(() async {
      if (bundlesPersistedToServer != null) {
        await registerBundlesPersistedToServerWithoutPayload(
            bundlesPersistedToServer.toList());
      }

      await insertNewEventsFromNewBundles(response.newBundles);
      await interpretIssuedServerTimestamp(response.lastIssuedServerTimestamp);
    });
  }

  Future<GetBundleIdsQuery> requestAllServerBundleIds() async {
    final config = await _database.getVerifiedConfig();

    return GetBundleIdsQuery(
      config.userToken!,
      config.userId!,
      sinceTimestamp: null,
    );
  }

  Future<(List<String>, List<String>)> getDifferenceBundleIds(
      GetBundleIdsResponse response) async {
    final localBundleIds = (await _database.getLocalBundleIds()).toSet();
    final serverBundleIds = response.bundleIds.toSet();

    final locallyMissingBundleIds =
        serverBundleIds.difference(localBundleIds).toList(growable: false);
    final remotelyMissingBundleIds =
        localBundleIds.difference(serverBundleIds).toList(growable: false);

    return (locallyMissingBundleIds, remotelyMissingBundleIds);
  }

  Future<GetBundlesQuery> requestBundles(List<String> bundleIds) async {
    final config = await _database.getVerifiedConfig();

    return GetBundlesQuery(
      config.userToken!,
      config.userId!,
      bundleIds,
    );
  }

  Future<void> interpretRequestedBundles(GetBundlesResponse response) async {
    await _database.transaction(() async {
      await insertNewEventsFromNewBundles(response.bundles);
    });
  }

  Future<int> interpretIssuedServerTimestamp(
      String lastIssuedServerTimestamp) async {
    return await _database.clientDrift.usersDrift
        .setLastSyncTime(newLastSyncTime: lastIssuedServerTimestamp);
  }

  Future<void> insertNewEventsFromNewBundles(List<Bundle> bundles) async {
    final List<String> bundleIdsToIgnore = [];
    for (final bundle in bundles) {
      final status =
          await _database.clientDrift.sharedDrift.sharedBundlesDrift.insertBundle(
        id: bundle.id,
        userId: bundle.userId,
        timestamp: bundle.timestamp,
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
      await _database.clientDrift.insertLocalEventWithClientId(event);
      await _database.clientDrift.insertEventIntoAttributes(event);
    }
  }

  Future<void> registerBundlesPersistedToServerWithoutPayload(
      List<Bundle> bundlesPersistedToServer) async {
    for (final bundle in bundlesPersistedToServer) {
      await _database.clientDrift.sharedDrift.sharedBundlesDrift.insertBundle(
        id: bundle.id,
        userId: bundle.userId,
        timestamp: bundle.timestamp,
        payload: null,
      );
    }
  }
  
  Future<void> sync() async {
    final query = await pushEvents();
    final response = await _database.communicator(query.toJson());
    return await pullEvents(
      PostBundlesResponse.fromJson(response),
      postedBundles: query.bundles,
    );
  }

  Future<int> verifyBundlesAndPullMissing() async {
    final query = await requestAllServerBundleIds();
    final response = await _database.communicator(query.toJson());
    final bundleIdsResponse = GetBundleIdsResponse.fromJson(response);
    
    final (locallyMissingIds, _) = await getDifferenceBundleIds(bundleIdsResponse);
    
    if (locallyMissingIds.isEmpty) {
      return 0;
    }
    
    final bundlesQuery = await requestBundles(locallyMissingIds);
    final bundlesResponse = await _database.communicator(bundlesQuery.toJson());
    await interpretRequestedBundles(GetBundlesResponse.fromJson(bundlesResponse));
    
    return locallyMissingIds.length;
  }
} 