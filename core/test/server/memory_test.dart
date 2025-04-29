import 'package:backend/client_definitions.dart';
import 'package:backend/server_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import '../server_test_executor.dart';
import 'server_tests_run.dart';

/// SQLite in-memory
class MemoryExecutor extends ServerTestExecutor {
  @override
  ServerDatabase createDatabase({ServerDatabaseConfig? initialConfig}) {
    return ServerDatabase(
      initialConfig: initialConfig,
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
