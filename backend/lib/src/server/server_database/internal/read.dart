import 'package:backend/server_library.dart';

extension Read on ServerDatabase {
  Future<List<Bundle>> getUserBundlesSinceOptionalTimestamp(
      String userId, String? timestamp) async {
    if (timestamp == null) {
      return await serverDrift.bundlesDrift
          .getAllUserBundles(userId: userId)
          .get();
    } else {
      return await serverDrift.bundlesDrift
          .getUserBundlesSinceTimestamp(userId: userId, timestamp: timestamp)
          .get();
    }
  }

  Future<List<String>> getUserBundleIdsSinceOptionalTimestamp(
      String userId, String? timestamp) async {
    if (timestamp == null) {
      return await serverDrift.bundlesDrift
          .getAllBundleIdsForUser(userId: userId)
          .get();
    } else {
      return await serverDrift.bundlesDrift
          .getBundleIdsForUserSinceTimestamp(
              userId: userId, timestamp: timestamp)
          .get();
    }
  }

  Future<List<Bundle>> getBundlesWhereIdInList(List<String> ids) async {
    final bundles = <Bundle>[];
    for (final id in ids) {
      bundles.add(
          await serverDrift.bundlesDrift.getBundleById(id: id).getSingle());
    }

    return bundles.toList(growable: false);
  }
}
