import 'package:backend/server_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import '../server_test_executor.dart';
import 'server_tests_run.dart';

/// SQLite in-memory
class MemoryExecutor extends ServerTestExecutor {
  @override
  ServerDatabase createDatabase() {
    return ServerDatabase(
      executor: DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
  }

  @override
  Future clearDatabaseAndClose(ServerDatabase db) async {
    await db.close();
  }
}

void main() {
  runAllServerTests(MemoryExecutor());
}
