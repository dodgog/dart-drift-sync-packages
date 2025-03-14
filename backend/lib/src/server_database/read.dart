import 'package:backend/server_database.dart';
import 'package:backend/server_definitions.dart';

extension Read on ServerDatabase{
  Future<List<Bundle>> getBundlesSinceTimestamp(
      String userId, String timestamp) async {
    return await serverDrift.bundlesDrift
        .getUserBundlesSinceTimestamp(userId: userId, timestamp: timestamp)
        .get();
  }
}
