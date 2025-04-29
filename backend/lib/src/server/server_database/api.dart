import 'package:backend/shared_xd.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';

import 'database.dart';
import 'internal/crud.dart';
import 'internal/read.dart';

class UnrecognizedQueryException implements Exception {
  final String message;

  UnrecognizedQueryException(this.message);
}

extension Api on ServerDatabase {
  Future<PostBundlesResponse> interpretIncomingAuthedPostBundlesQueryAndRespond(
      PostBundlesQuery query) async {
    // NOTE: auth is done before this

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
  Future<GetBundleIdsResponse> interpretIncomingAuthedGetBundleIdsAndRespond(
      GetBundleIdsQuery query) async {
    // NOTE: auth is done before this

    final ids = await getUserBundleIdsSinceOptionalTimestamp(
        query.userId, query.sinceTimestamp);

    return GetBundleIdsResponse(ids);
  }

  // TODO: test
  Future<GetBundlesResponse> interpretIncomingAuthedGetBundlesAndRespond(
      GetBundlesQuery query) async {
    // NOTE: auth is done before this

    final bundles = await getBundlesWhereIdInList(query.bundleIds);

    return GetBundlesResponse(bundles);
  }
}
