import 'package:backend/server.dart';
import 'package:drift/drift.dart';
import 'database.drift.dart';

@DriftDatabase(
  include: {'package:backend/server.drift'},
)

class ServerDatabase extends $ServerDatabase {
  ServerDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        if (details.wasCreated) {
          // await users.insertOne(UsersCompanion.insert(name: 'Demo user'));
          // await posts.insertOne(
          //     PostsCompanion.insert(author: 1, content: Value('Test post')));
        }
      },
    );
  }
}

