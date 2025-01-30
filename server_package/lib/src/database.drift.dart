// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared/users.drift.dart' as i1;
import 'package:backend/src/shared/events.drift.dart' as i2;
import 'package:backend/src/server/users.drift.dart' as i3;
import 'package:backend/server.drift.dart' as i4;
import 'package:drift/internal/modular.dart' as i5;

abstract class $ServerDatabase extends i0.GeneratedDatabase {
  $ServerDatabase(i0.QueryExecutor e) : super(e);
  $ServerDatabaseManager get managers => $ServerDatabaseManager(this);
  late final i1.Users users = i1.Users(this);
  late final i1.Clients clients = i1.Clients(this);
  late final i2.Events events = i2.Events(this);
  late final i3.Auth auth = i3.Auth(this);
  i4.ServerDrift get serverDrift => i5.ReadDatabaseContainer(this)
      .accessor<i4.ServerDrift>(i4.ServerDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities =>
      [users, clients, events, i2.eventClientIdIndex, auth];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $ServerDatabaseManager {
  final $ServerDatabase _db;
  $ServerDatabaseManager(this._db);
  i1.$UsersTableManager get users => i1.$UsersTableManager(_db, _db.users);
  i1.$ClientsTableManager get clients =>
      i1.$ClientsTableManager(_db, _db.clients);
  i2.$EventsTableManager get events => i2.$EventsTableManager(_db, _db.events);
  i3.$AuthTableManager get auth => i3.$AuthTableManager(_db, _db.auth);
}
