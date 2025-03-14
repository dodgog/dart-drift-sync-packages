import 'package:backend/client_database.dart';
import 'package:backend/client_definitions.dart';

import 'database.dart';

extension Config on ClientDatabase {
  Future<int> initializeClient() async {
    await clientDrift.usersDrift.initializeConfig();
    await clientDrift.usersDrift
        .setUserToken(newUserToken: initialConfig!.userToken);
    await clientDrift.usersDrift
        .setClientId(newClientId: initialConfig!.clientId);
    await clientDrift.usersDrift.setUserId(newUserId: initialConfig!.userId);

    return await clientDrift.sharedDrift.sharedUsersDrift.createClient(
        clientId: initialConfig!.clientId, userId: initialConfig!.userId);
  }

  Future<ConfigData> getVerifiedConfig() async {
    final config = await clientDrift.usersDrift.getConfig().getSingleOrNull() ??
        (throw InvalidConfigException(
            "Not exactly one row in the user config table"));

    if (config.userToken == null ||
        config.userId == null ||
        config.clientId == null) {
      throw InvalidConfigException("Config contains uninitialized values");
    }

    return config;
  }
}
