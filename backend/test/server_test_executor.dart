import 'package:backend/server_xd.dart';

abstract class ServerTestExecutor {
  ServerDatabase createDatabase({ServerDatabaseConfig? initialConfig});

  Future clearDatabaseAndClose(ServerDatabase db);
}
