import 'dart:io';

import 'package:backend/client_library.dart';
import 'package:drift/drift.dart';

typedef JsonServerMessenger = Future<Map<String, dynamic>> Function(
    Map<String, dynamic> data);

abstract interface class CoreDataInterface {
  static CoreDataInterface create({
    ClientDatabaseConfig? initialConfig,
    QueryExecutor? executor,
    File? file,
  }) {
    return ClientDatabase.createInterface(
      initialConfig: initialConfig,
      executor: executor,
      file: file,
    );
  }

  Future<void> initializeWebMessageChannel(
      {JsonServerMessenger sendJsonAndGetResponse});

  // post new events and get updates
  // return the number of new events or null if sync failed
  Future<void> sync();

  // verify all bundles present and if not request and insert the missing
  // bundles
  // requests all server ids, then compares which are present. requests the
  // missing ones
  // TODO also remove or negotiate extras
  Future<int> verifyBundlesAndPullMissing();

  NodeHelper getNodeHelper();
}
