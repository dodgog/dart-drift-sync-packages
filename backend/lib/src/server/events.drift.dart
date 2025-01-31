// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;
import 'package:backend/src/shared/shared_events.drift.dart' as i2;
import 'package:backend/src/shared/shared_users.drift.dart' as i3;
import 'package:backend/src/server/users.drift.dart' as i4;

class EventsDrift extends i1.ModularAccessor {
  EventsDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i2.Event> getUserEventsSinceTimestamp(
      {String? timestamp, String? userId}) {
    return customSelect(
        switch (executor.dialect) {
          i0.SqlDialect.sqlite =>
            'SELECT e.* FROM events AS e JOIN clients AS c ON e.client_id = c.id WHERE e.server_time_stamp > ?1 AND c.user_id = ?2 ORDER BY e.server_time_stamp ASC',
          i0.SqlDialect.postgres ||
          _ =>
            'SELECT e.* FROM events AS e JOIN clients AS c ON e.client_id = c.id WHERE e.server_time_stamp > \$1 AND c.user_id = \$2 ORDER BY e.server_time_stamp ASC',
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

  Future<int> insertEvent(
      {required String id,
      required String type,
      required String clientId,
      String? serverTimeStamp,
      required String clientTimeStamp,
      String? content}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'INSERT INTO events (id, type, client_id, server_time_stamp, client_time_stamp, content) VALUES (?1, ?2, ?3, ?4, ?5, ?6)',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO events (id, type, client_id, server_time_stamp, client_time_stamp, content) VALUES (\$1, \$2, \$3, \$4, \$5, \$6)',
      },
      variables: [
        i0.Variable<String>(id),
        i0.Variable<String>(type),
        i0.Variable<String>(clientId),
        i0.Variable<String>(serverTimeStamp),
        i0.Variable<String>(clientTimeStamp),
        i0.Variable<String>(content)
      ],
      updates: {events},
    );
  }

  i0.Selectable<String?> getLatestTimestampAffectingUser({String? userId}) {
    return customSelect(
        switch (executor.dialect) {
          i0.SqlDialect.sqlite =>
            'SELECT MAX(e.server_time_stamp) AS _c0 FROM events AS e JOIN clients AS c ON e.client_id = c.id WHERE c.user_id = ?1',
          i0.SqlDialect.postgres ||
          _ =>
            'SELECT MAX(e.server_time_stamp) AS _c0 FROM events AS e JOIN clients AS c ON e.client_id = c.id WHERE c.user_id = \$1',
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
  i4.UsersDrift get usersDrift => this.accessor(i4.UsersDrift.new);
}
