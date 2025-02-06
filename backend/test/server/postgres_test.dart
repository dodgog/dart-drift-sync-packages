import 'package:backend/server_database.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:postgres/postgres.dart' as pg;
import 'server_test_executor.dart';

class PostgresExecutor extends ServerTestExecutor {
  @override
  ServerDatabase createDatabase() {
    return ServerDatabase(
      executor: PgDatabase(
        endpoint: pg.Endpoint(
          host: 'localhost',
          database: 'postgres',
          username: 'postgres',
          password: 'postgres',
        ),
        settings: pg.ConnectionSettings(sslMode: pg.SslMode.disable),
      ),
    );
  }

  @override
  Future clearDatabaseAndClose(ServerDatabase db) async {
    await db.customStatement('DROP SCHEMA public CASCADE;');
    await db.customStatement('CREATE SCHEMA public;');
    await db.customStatement('GRANT ALL ON SCHEMA public TO postgres;');
    await db.customStatement('GRANT ALL ON SCHEMA public TO public;');
    await db.close();
  }
}

void main() {
  runAllServerTests(PostgresExecutor());
}
