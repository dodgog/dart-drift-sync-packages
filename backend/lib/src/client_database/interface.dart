import 'node_helper.dart';

abstract interface class ClientDatabaseInterface {
  Future<void> initialize();

  // post new events and get updates
  // return the number of new events or null if sync failed
  Future<int?> sync();

  // verify all bundles present and if not request and insert the missing
  // bundles
// requests all server ids, then compares which are present. requests the
// missing ones
  //
  // TODO also remove or negotiate extras
  Future<int> verifyBundlesAndPullMissing();

  // get nodehelper
  NodeHelper nodeHelper();
}
