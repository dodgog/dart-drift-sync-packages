import 'package:backend/server_database.dart';
import 'package:backend/server_definitions.dart';

extension Crud on ServerDatabase {
  Future<List<String>> insertBundles(List<Bundle> bundles) async {
    // TODO: verify owner user
    // THINK: what should be the logic of event and bundle ownership?
    final List<String> insertedIds = [];
    for (final bundle in bundles) {
      final status =
          await serverDrift.sharedDrift.sharedBundlesDrift.insertBundle(
        id: bundle.id,
        userId: bundle.userId,
        timestamp: bundle.timestamp,
        payload: bundle.payload,
      );
      if (status != 0) {
        insertedIds.add(bundle.id);
      }
    }
    return insertedIds;
  }
}
