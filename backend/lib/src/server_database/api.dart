import 'package:backend/messaging.dart';
import 'package:backend/server_database.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';

import 'auth.dart';
import 'internal/crud.dart';
import 'internal/read.dart';

extension Api on ServerDatabase {
  Future<PostBundlesResponse> interpretIncomingPostBundlesQueryAndRespond(
      PostBundlesQuery query) async {
    final isAuthorized = await verifyUser(query.userId, query.token);
    if (!isAuthorized) {
      throw UnauthorizedException('Invalid user credentials');
    }

    HLC().receivePacked(query.clientTimestamp);

    final insertedBundleIds = await insertBundles(
      query.bundles,
    );

    // Get new bundles but also should get the ones which were just inserted.
    // Could be used for confirmation of receipt.
    final newBundles = await getUserBundlesSinceOptionalTimestamp(
      query.userId,
      query.lastIssuedServerTimestamp,
    );

    return PostBundlesResponse(
      HLC().sendPacked(),
      insertedBundleIds,
      newBundles.where((e) => !insertedBundleIds.contains(e.id)).toList(),
    );
  }

  // TODO: test
  Future<GetBundleIdsResponse> interpretIncomingGetBundleIdsAndRespond(
      GetBundleIdsQuery query) async {
    final isAuthorized = await verifyUser(query.userId, query.token);
    if (!isAuthorized) {
      throw UnauthorizedException('Invalid user credentials');
    }

    final ids = await getUserBundleIdsSinceOptionalTimestamp(
        query.userId, query.sinceTimestamp);

    return GetBundleIdsResponse(ids);
  }

  // TODO: test
  Future<GetBundlesResponse> interpretIncomingGetBundlesAndRespond(
      GetBundleIdsQuery query) async {
    final isAuthorized = await verifyUser(query.userId, query.token);
    if (!isAuthorized) {
      throw UnauthorizedException('Invalid user credentials');
    }

    final bundles = await getUserBundlesSinceOptionalTimestamp(
        query.userId, query.sinceTimestamp);

    return GetBundlesResponse(bundles, HLC().sendPacked());
  }
}
