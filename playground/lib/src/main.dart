import 'package:backend/src/test.drift.dart';
import 'package:drift/drift.dart';

import 'database.dart';

void main() async {
  final db = AppDatabase();
  await db
      .into(db.users)
      .insert(UsersCompanion(id: Value(1), preferences: Value(null)));
  final decodedUsers = await db.select(db.users).get();
  print(decodedUsers);

  await db.testDrift.insertUser(id: 2, preferences: null);
  final users = await db.testDrift.selectUsers().get();
  print(users);
}
