// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i1;
import 'package:backend/src/shared_definitions/shared_bundles.drift.dart' as i2;
import 'package:backend/src/server_definitions/users.drift.dart' as i3;
import 'package:backend/server.drift.dart' as i4;
import 'package:drift/internal/modular.dart' as i5;

abstract class $ServerDatabase extends i0.GeneratedDatabase {
  $ServerDatabase(i0.QueryExecutor e) : super(e);
  $ServerDatabaseManager get managers => $ServerDatabaseManager(this);
  late final i1.Users users = i1.Users(this);
  late final i2.Bundles bundles = i2.Bundles(this);
  late final i1.Clients clients = i1.Clients(this);
  late final i3.Auths auths = i3.Auths(this);
  i4.ServerDrift get serverDrift => i5.ReadDatabaseContainer(this)
      .accessor<i4.ServerDrift>(i4.ServerDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities =>
      [users, bundles, clients, auths];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $ServerDatabaseManager {
  final $ServerDatabase _db;
  $ServerDatabaseManager(this._db);
  i1.$UsersTableManager get users => i1.$UsersTableManager(_db, _db.users);
  i2.$BundlesTableManager get bundles =>
      i2.$BundlesTableManager(_db, _db.bundles);
  i1.$ClientsTableManager get clients =>
      i1.$ClientsTableManager(_db, _db.clients);
  i3.$AuthsTableManager get auths => i3.$AuthsTableManager(_db, _db.auths);
}
