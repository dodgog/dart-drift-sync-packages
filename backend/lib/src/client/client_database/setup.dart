import 'package:backend/client_database.dart';
import 'package:backend/client_definitions.dart';
import 'package:backend/shared_database.dart';

import 'database.dart';

extension Setup on ClientDatabase {
  Future<int> initializeClientWithInitialConfig() async {
    await clientDrift.usersDrift.initializeConfig();
    await clientDrift.usersDrift
        .setUserToken(newUserToken: initialConfig!.userToken);
    await clientDrift.usersDrift
        .setClientId(newClientId: initialConfig!.clientId);
    await clientDrift.usersDrift.setUserId(newUserId: initialConfig!.userId);

    final result = await clientDrift.sharedDrift.sharedUsersDrift.createClient(
        clientId: initialConfig!.clientId, userId: initialConfig!.userId);
    return result;
  }

  Future<ConfigData> getVerifiedConfig() async {
    final config = await clientDrift.usersDrift.getConfig().getSingleOrNull() ??
        (throw InvalidDatabaseConfigException(
            "Not exactly one row in the user config table"));

    if (config.userToken == null ||
        config.userId == null ||
        config.clientId == null) {
      throw InvalidDatabaseConfigException(
          "Config contains uninitialized values");
    }

    return config;
  }
}
