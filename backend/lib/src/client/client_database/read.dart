import 'package:backend/client_database.dart';
import 'package:backend/client_definitions.dart';
import 'package:backend/client.dart';

extension Read on ClientDatabase {
  Future<List<String>> getLocalBundleIds() async {
    return await clientDrift.sharedDrift.sharedBundlesDrift
        .getAllBundlesIds()
        .get();
  }

  Future<List<Event>> getLocalEventsA() async {
    return await clientDrift.eventsDrift.getLocalEventsToPush().get();
  }
}
