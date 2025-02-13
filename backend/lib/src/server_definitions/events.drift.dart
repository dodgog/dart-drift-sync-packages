// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i2;
import 'package:backend/src/shared_definitions/event_types.dart' as i3;
import 'package:backend/src/shared_definitions/event_content.dart' as i4;
import 'dart:typed_data' as i5;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i6;
import 'package:backend/server.drift.dart' as i7;
import 'package:backend/src/server_definitions/users.drift.dart' as i8;

class EventsDrift extends i1.ModularAccessor {
  EventsDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i2.Event> getUserEventsSinceTimestamp(
      {required String? timestamp, required String? userId}) {
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
      required i3.EventTypes? type,
      required String clientId,
      required String? targetNodeId,
      required String? serverTimeStamp,
      required String clientTimeStamp,
      required i4.EventContent? content}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'INSERT INTO events (id, type, client_id, target_node_id, server_time_stamp, client_time_stamp, content) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7)',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO events (id, type, client_id, target_node_id, server_time_stamp, client_time_stamp, content) VALUES (\$1, \$2, \$3, \$4, \$5, \$6, \$7)',
      },
      variables: [
        i0.Variable<String>(id),
        i0.Variable<String>(i2.Events.$convertertypen.toSql(type)),
        i0.Variable<String>(clientId),
        i0.Variable<String>(targetNodeId),
        i0.Variable<String>(serverTimeStamp),
        i0.Variable<String>(clientTimeStamp),
        i0.Variable<i5.Uint8List>(i2.Events.$convertercontentn.toSql(content))
      ],
      updates: {events},
    );
  }

  i0.Selectable<String?> getLatestTimestampAffectingUser(
      {required String? userId}) {
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
  i6.Clients get clients => i1.ReadDatabaseContainer(attachedDatabase)
      .resultSet<i6.Clients>('clients');
  i7.ServerDrift get serverDrift => this.accessor(i7.ServerDrift.new);
  i8.UsersDrift get usersDrift => this.accessor(i8.UsersDrift.new);
}
