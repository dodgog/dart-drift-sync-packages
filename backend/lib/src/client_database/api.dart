import 'dart:convert';

import 'package:backend/client_definitions.dart';
import 'package:backend/messaging.dart';
import 'package:backend/src/client_database/crud.dart';
import 'package:backend/src/client_database/read.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:uuidv7/uuidv7.dart';

import 'database.dart';
import 'setup.dart';

// TODO handle missing bundles

// TODO handle bundles which are only present locally

/// Handles formation of queries and interprets responses
///
/// Does not write anything directly, for that relies on the CRUD extension
extension Api on ClientDatabase {
  Future<PostBundlesQuery> pushEvents() async {
    final config = await getVerifiedConfig();
    final events = await getLocalEventsA();

    final bundle = Bundle(
      // THINK: at which point should we create this id? maybe the server
      //  should assign it
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

    await transaction(() async {
      if (bundlesPersistedToServer != null) {
        registerBundlesPersistedToServerWithoutPayload(
            bundlesPersistedToServer.toList());
      }

      await insertNewEventsFromNewBundles(response.newBundles);
      await interpretIssuedServerTimestamp(response.lastIssuedServerTimestamp);
    });
  }

  Future<GetBundleIdsQuery> requestAllServerBundleIds() async {
    final config = await getVerifiedConfig();

    return GetBundleIdsQuery(
      config.userToken!,
      config.userId!,
      sinceTimestamp: null,
    );
  }

  // AIUSE: helped fill out the signatures

  Future<(List<String>, List<String>)> getDifferenceBundleIds(
      GetBundleIdsResponse response) async {
    final localBundleIds = (await getLocalBundleIds()).toSet();
    final serverBundleIds = response.bundleIds.toSet();

    final locallyMissingBundleIds =
        serverBundleIds.difference(localBundleIds).toList(growable: false);
    final remotelyMissingBundleIds =
        localBundleIds.difference(serverBundleIds).toList(growable: false);

    return (locallyMissingBundleIds, remotelyMissingBundleIds);
  }


  Future<GetBundlesQuery> requestBundles(List<String> bundleIds) async {
    final config = await getVerifiedConfig();

    return GetBundlesQuery(
      config.userToken!,
      config.userId!,
      bundleIds,
    );
  }

  Future<void> interpretRequestedBundles(GetBundlesResponse response) async {
    await transaction(() async {
      await insertNewEventsFromNewBundles(response.bundles);
    });
  }
}
