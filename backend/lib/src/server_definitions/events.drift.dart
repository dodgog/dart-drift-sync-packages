// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i2;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i3;
import 'package:backend/server.drift.dart' as i4;
import 'package:backend/src/server_definitions/users.drift.dart' as i5;

class EventsDrift extends i1.ModularAccessor {
  EventsDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i2.Event> getUserEventsSinceTimestamp(
      {required String? timestamp, required String userId}) {
    return customSelect(
        switch (executor.dialect) {
          i0.SqlDialect.sqlite =>
            'SELECT e.* FROM events AS e JOIN clients AS c ON e.client_id = c.id WHERE e.timestamp > COALESCE(?1, \'1969-01-01T00:00:01.000Z-0000-00000\') AND c.user_id = ?2 ORDER BY e.timestamp ASC',
          i0.SqlDialect.postgres ||
          _ =>
            'SELECT e.* FROM events AS e JOIN clients AS c ON e.client_id = c.id WHERE e.timestamp > COALESCE(\$1, \'1969-01-01T00:00:01.000Z-0000-00000\') AND c.user_id = \$2 ORDER BY e.timestamp ASC',
        },
        variables: [
          i0.Variable<String>(timestamp),
          i0.Variable<String>(userId)
        ],
        readsFrom: {
          events,
          clients,
        }).asyncMap(events.mapFromRow);
  }

  i0.Selectable<String?> getLatestTimestampAffectingUser(
      {required String? userId}) {
    return customSelect(
        switch (executor.dialect) {
          i0.SqlDialect.sqlite =>
            'SELECT MAX(e.timestamp) AS _c0 FROM events AS e JOIN clients AS c ON e.client_id = c.id WHERE c.user_id = ?1',
          i0.SqlDialect.postgres ||
          _ =>
            'SELECT MAX(e.timestamp) AS _c0 FROM events AS e JOIN clients AS c ON e.client_id = c.id WHERE c.user_id = \$1',
        },
        variables: [
          i0.Variable<String>(userId)
        ],
        readsFrom: {
          events,
          clients,
        }).map((i0.QueryRow row) => row.readNullable<String>('_c0'));
  }

  i2.Events get events =>
      i1.ReadDatabaseContainer(attachedDatabase).resultSet<i2.Events>('events');
  i3.Clients get clients => i1.ReadDatabaseContainer(attachedDatabase)
      .resultSet<i3.Clients>('clients');
  i4.ServerDrift get serverDrift => this.accessor(i4.ServerDrift.new);
  i5.UsersDrift get usersDrift => this.accessor(i5.UsersDrift.new);
}
