import 'package:backend/client_library.dart';

extension Read on ClientDatabase {
  Future<List<String>> getLocalBundleIds() async {
    return await clientDrift.sharedDrift.sharedBundlesDrift
        .getAllBundlesIds()
        .get();
  }

  Future<List<Event>> getLocalEvents() async {
    return await clientDrift.eventsDrift.getLocalEventsToPush().get();
  }
}
