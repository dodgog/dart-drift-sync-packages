import 'package:backend/messaging.dart';
import 'package:backend/server_database.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';

import 'auth.dart';
import 'crud.dart';
import 'read.dart';

extension Api on ServerDatabase {
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
}
