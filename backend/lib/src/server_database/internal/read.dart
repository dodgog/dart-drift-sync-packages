import 'package:backend/server_database.dart';
import 'package:backend/server_definitions.dart';

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
}
