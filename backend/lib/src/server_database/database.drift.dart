// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i1;
import 'package:backend/src/shared_definitions/shared_bundles.drift.dart' as i2;
import 'package:backend/src/shared_definitions/shared_attributes.drift.dart'
    as i3;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i4;
import 'package:backend/src/server_definitions/users.drift.dart' as i5;
import 'package:backend/server.drift.dart' as i6;
import 'package:drift/internal/modular.dart' as i7;

abstract class $ServerDatabase extends i0.GeneratedDatabase {
  $ServerDatabase(i0.QueryExecutor e) : super(e);
  $ServerDatabaseManager get managers => $ServerDatabaseManager(this);
  late final i1.Users users = i1.Users(this);
  late final i2.Bundles bundles = i2.Bundles(this);
  late final i3.Attributes attributes = i3.Attributes(this);
  late final i1.Clients clients = i1.Clients(this);
  late final i4.Events events = i4.Events(this);
  late final i5.Auths auths = i5.Auths(this);
  i6.ServerDrift get serverDrift => i7.ReadDatabaseContainer(this)
      .accessor<i6.ServerDrift>(i6.ServerDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        bundles,
        attributes,
        i3.attributesEntityIdAttribute,
        clients,
        events,
        i4.eventClientIdIndex,
        auths
      ];
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
  i3.$AttributesTableManager get attributes =>
      i3.$AttributesTableManager(_db, _db.attributes);
  i1.$ClientsTableManager get clients =>
      i1.$ClientsTableManager(_db, _db.clients);
  i4.$EventsTableManager get events => i4.$EventsTableManager(_db, _db.events);
  i5.$AuthsTableManager get auths => i5.$AuthsTableManager(_db, _db.auths);
}
