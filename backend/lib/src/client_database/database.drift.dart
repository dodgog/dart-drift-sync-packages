// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i1;
import 'package:backend/src/shared_definitions/shared_bundles.drift.dart' as i2;
import 'package:backend/src/client_definitions/attributes.drift.dart' as i3;
import 'package:backend/src/client_definitions/events.drift.dart' as i4;
import 'package:backend/src/client_definitions/users.drift.dart' as i5;
import 'package:backend/client.drift.dart' as i6;
import 'package:drift/internal/modular.dart' as i7;

abstract class $ClientDatabase extends i0.GeneratedDatabase {
  $ClientDatabase(i0.QueryExecutor e) : super(e);
  $ClientDatabaseManager get managers => $ClientDatabaseManager(this);
  late final i1.Users users = i1.Users(this);
  late final i2.Bundles bundles = i2.Bundles(this);
  late final i1.Clients clients = i1.Clients(this);
  late final i3.Attributes attributes = i3.Attributes(this);
  late final i4.Events events = i4.Events(this);
  late final i5.Config config = i5.Config(this);
  i6.ClientDrift get clientDrift => i7.ReadDatabaseContainer(this)
      .accessor<i6.ClientDrift>(i6.ClientDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        bundles,
        clients,
        attributes,
        i3.attributesEntityIdAttribute,
        events,
        config,
        i4.eventClientIdIndex
      ];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $ClientDatabaseManager {
  final $ClientDatabase _db;
  $ClientDatabaseManager(this._db);
  i1.$UsersTableManager get users => i1.$UsersTableManager(_db, _db.users);
  i2.$BundlesTableManager get bundles =>
      i2.$BundlesTableManager(_db, _db.bundles);
  i1.$ClientsTableManager get clients =>
      i1.$ClientsTableManager(_db, _db.clients);
  i3.$AttributesTableManager get attributes =>
      i3.$AttributesTableManager(_db, _db.attributes);
  i4.$EventsTableManager get events => i4.$EventsTableManager(_db, _db.events);
  i5.$ConfigTableManager get config => i5.$ConfigTableManager(_db, _db.config);
}
