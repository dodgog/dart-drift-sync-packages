// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i1;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i2;
import 'package:backend/src/client_definitions/users.drift.dart' as i3;
import 'package:backend/client.drift.dart' as i4;
import 'package:drift/internal/modular.dart' as i5;

abstract class $ClientDatabase extends i0.GeneratedDatabase {
  $ClientDatabase(i0.QueryExecutor e) : super(e);
  $ClientDatabaseManager get managers => $ClientDatabaseManager(this);
  late final i1.Users users = i1.Users(this);
  late final i1.Clients clients = i1.Clients(this);
  late final i2.Events events = i2.Events(this);
  late final i3.Config config = i3.Config(this);
  i4.ClientDrift get clientDrift => i5.ReadDatabaseContainer(this)
      .accessor<i4.ClientDrift>(i4.ClientDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities =>
      [users, clients, events, i2.eventClientIdIndex, config];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $ClientDatabaseManager {
  final $ClientDatabase _db;
  $ClientDatabaseManager(this._db);
  i1.$UsersTableManager get users => i1.$UsersTableManager(_db, _db.users);
  i1.$ClientsTableManager get clients =>
      i1.$ClientsTableManager(_db, _db.clients);
  i2.$EventsTableManager get events => i2.$EventsTableManager(_db, _db.events);
  i3.$ConfigTableManager get config => i3.$ConfigTableManager(_db, _db.config);
}
