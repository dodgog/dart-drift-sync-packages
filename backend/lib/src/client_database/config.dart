import 'package:backend/client_database.dart';

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
}
