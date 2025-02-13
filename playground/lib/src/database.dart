import 'package:backend/src/test.drift.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'database.drift.dart';

@DriftDatabase(include: {'test.drift'})
class AppDatabase extends $AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return NativeDatabase.memory();
  }


}
