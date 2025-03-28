import 'node_helper.dart';

typedef JsonCommunicator = Future<Map<String, dynamic>> Function(
    Map<String, dynamic> data);

abstract interface class ClientDatabaseInterface {
  Future<void> initialize({JsonCommunicator sendJsonAndGetResponse});

  // post new events and get updates
  // return the number of new events or null if sync failed
  Future<void> sync();

  // verify all bundles present and if not request and insert the missing
  // bundles
// requests all server ids, then compares which are present. requests the
// missing ones
  //
  // TODO also remove or negotiate extras
  Future<int> verifyBundlesAndPullMissing();

  // get nodehelper
  NodeHelper getNodeHelper();
}
