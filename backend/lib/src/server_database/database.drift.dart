// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared_definitions/shared_attributes.drift.dart'
    as i1;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i2;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i3;
import 'package:backend/src/server_definitions/users.drift.dart' as i4;
import 'package:backend/server.drift.dart' as i5;
import 'package:drift/internal/modular.dart' as i6;

abstract class $ServerDatabase extends i0.GeneratedDatabase {
  $ServerDatabase(i0.QueryExecutor e) : super(e);
  $ServerDatabaseManager get managers => $ServerDatabaseManager(this);
  late final i1.Attributes attributes = i1.Attributes(this);
  late final i2.Users users = i2.Users(this);
  late final i2.Clients clients = i2.Clients(this);
  late final i3.Events events = i3.Events(this);
  late final i4.Auths auths = i4.Auths(this);
  i5.ServerDrift get serverDrift => i6.ReadDatabaseContainer(this)
      .accessor<i5.ServerDrift>(i5.ServerDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
        attributes,
        i1.attributesEntityIdAttribute,
        users,
        clients,
        events,
        i3.eventClientIdIndex,
        auths
      ];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $ServerDatabaseManager {
  final $ServerDatabase _db;
  $ServerDatabaseManager(this._db);
  i1.$AttributesTableManager get attributes =>
      i1.$AttributesTableManager(_db, _db.attributes);
  i2.$UsersTableManager get users => i2.$UsersTableManager(_db, _db.users);
  i2.$ClientsTableManager get clients =>
      i2.$ClientsTableManager(_db, _db.clients);
  i3.$EventsTableManager get events => i3.$EventsTableManager(_db, _db.events);
  i4.$AuthsTableManager get auths => i4.$AuthsTableManager(_db, _db.auths);
}
