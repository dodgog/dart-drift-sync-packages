// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared_definitions/shared_attributes.drift.dart'
    as i1;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i2;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i3;
import 'package:backend/src/client_definitions/users.drift.dart' as i4;
import 'package:backend/client.drift.dart' as i5;
import 'package:drift/internal/modular.dart' as i6;

abstract class $ClientDatabase extends i0.GeneratedDatabase {
  $ClientDatabase(i0.QueryExecutor e) : super(e);
  $ClientDatabaseManager get managers => $ClientDatabaseManager(this);
  late final i1.Attributes attributes = i1.Attributes(this);
  late final i2.Users users = i2.Users(this);
  late final i2.Clients clients = i2.Clients(this);
  late final i3.Events events = i3.Events(this);
  late final i4.Config config = i4.Config(this);
  i5.ClientDrift get clientDrift => i6.ReadDatabaseContainer(this)
      .accessor<i5.ClientDrift>(i5.ClientDrift.new);
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
        config
      ];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $ClientDatabaseManager {
  final $ClientDatabase _db;
  $ClientDatabaseManager(this._db);
  i1.$AttributesTableManager get attributes =>
      i1.$AttributesTableManager(_db, _db.attributes);
  i2.$UsersTableManager get users => i2.$UsersTableManager(_db, _db.users);
  i2.$ClientsTableManager get clients =>
      i2.$ClientsTableManager(_db, _db.clients);
  i3.$EventsTableManager get events => i3.$EventsTableManager(_db, _db.events);
  i4.$ConfigTableManager get config => i4.$ConfigTableManager(_db, _db.config);
}
