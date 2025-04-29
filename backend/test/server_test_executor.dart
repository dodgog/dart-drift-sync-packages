import 'package:backend/client_definitions.dart';
import 'package:backend/server_database.dart';

abstract class ServerTestExecutor {
  ServerDatabase createDatabase({ServerDatabaseConfig? initialConfig});

  Future clearDatabaseAndClose(ServerDatabase db);
}
