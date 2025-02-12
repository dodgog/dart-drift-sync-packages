// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i1;
import 'package:backend/src/shared_definitions/shared_nodes.drift.dart' as i2;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i3;
import 'package:backend/src/server_definitions/users.drift.dart' as i4;
import 'package:backend/server.drift.dart' as i5;
import 'package:drift/internal/modular.dart' as i6;

abstract class $ServerDatabase extends i0.GeneratedDatabase {
  $ServerDatabase(i0.QueryExecutor e) : super(e);
  $ServerDatabaseManager get managers => $ServerDatabaseManager(this);
  late final i1.Users users = i1.Users(this);
  late final i2.Nodes nodes = i2.Nodes(this);
  late final i1.Clients clients = i1.Clients(this);
  late final i3.Events events = i3.Events(this);
  late final i4.Auths auths = i4.Auths(this);
  i5.ServerDrift get serverDrift => i6.ReadDatabaseContainer(this)
      .accessor<i5.ServerDrift>(i5.ServerDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities =>
      [users, nodes, clients, events, i3.eventClientIdIndex, auths];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $ServerDatabaseManager {
  final $ServerDatabase _db;
  $ServerDatabaseManager(this._db);
  i1.$UsersTableManager get users => i1.$UsersTableManager(_db, _db.users);
  i2.$NodesTableManager get nodes => i2.$NodesTableManager(_db, _db.nodes);
  i1.$ClientsTableManager get clients =>
      i1.$ClientsTableManager(_db, _db.clients);
  i3.$EventsTableManager get events => i3.$EventsTableManager(_db, _db.events);
  i4.$AuthsTableManager get auths => i4.$AuthsTableManager(_db, _db.auths);
}
