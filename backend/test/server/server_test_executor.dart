import 'package:backend/server_database.dart';

abstract class ServerTestExecutor {
  ServerDatabase createDatabase();

  Future clearDatabaseAndClose(ServerDatabase db);
}
