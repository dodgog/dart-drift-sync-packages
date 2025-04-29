import 'package:backend/server_library.dart';

abstract class ServerTestExecutor {
  ServerDatabase createDatabase({ServerDatabaseConfig? initialConfig});

  Future clearDatabaseAndClose(ServerDatabase db);
}
