// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i2;
import 'package:backend/src/shared_definitions/event_types.dart' as i3;
import 'package:backend/src/shared_definitions/event_content.dart' as i4;
import 'dart:typed_data' as i5;
import 'package:backend/client.drift.dart' as i6;

class EventsDrift extends i1.ModularAccessor {
  EventsDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i2.Event> getLocalEventsToPush() {
    return customSelect('SELECT e.* FROM events AS e',
        variables: [],
        readsFrom: {
          events,
        }).asyncMap(events.mapFromRow);
  }

  Future<int> insertLocalEvent(
      {required String id,
      required i3.EventTypes type,
      required String clientId,
      required String? targetNodeId,
      required String timestamp,
      required i4.EventContent? content}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'INSERT INTO events (id, type, client_id, target_node_id, timestamp, content) VALUES (?1, ?2, ?3, ?4, ?5, ?6)',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO events (id, type, client_id, target_node_id, timestamp, content) VALUES (\$1, \$2, \$3, \$4, \$5, \$6)',
      },
      variables: [
        i0.Variable<String>(id),
        i0.Variable<String>(i2.Events.$convertertype.toSql(type)),
        i0.Variable<String>(clientId),
        i0.Variable<String>(targetNodeId),
        i0.Variable<String>(timestamp),
        i0.Variable<i5.Uint8List>(i2.Events.$convertercontentn.toSql(content))
      ],
      updates: {events},
    );
  }

  Future<int> insertServerEvent(
      {required String id,
      required i3.EventTypes type,
      required String clientId,
      required String? targetNodeId,
      required String timestamp,
      required i4.EventContent? content}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'INSERT INTO events (id, type, client_id, target_node_id, timestamp, content) VALUES (?1, ?2, ?3, ?4, ?5, ?6) ON CONFLICT (id) DO UPDATE SET timestamp = EXCLUDED.timestamp WHERE events.type = EXCLUDED.type AND events.client_id = EXCLUDED.client_id AND events.target_node_id = EXCLUDED.target_node_id AND events.content = EXCLUDED.content',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO events (id, type, client_id, target_node_id, timestamp, content) VALUES (\$1, \$2, \$3, \$4, \$5, \$6) ON CONFLICT (id) DO UPDATE SET timestamp = EXCLUDED.timestamp WHERE events.type = EXCLUDED.type AND events.client_id = EXCLUDED.client_id AND events.target_node_id = EXCLUDED.target_node_id AND events.content = EXCLUDED.content',
      },
      variables: [
        i0.Variable<String>(id),
        i0.Variable<String>(i2.Events.$convertertype.toSql(type)),
        i0.Variable<String>(clientId),
        i0.Variable<String>(targetNodeId),
        i0.Variable<String>(timestamp),
        i0.Variable<i5.Uint8List>(i2.Events.$convertercontentn.toSql(content))
      ],
      updates: {events},
    );
  }

  i2.Events get events =>
      i1.ReadDatabaseContainer(attachedDatabase).resultSet<i2.Events>('events');
  i6.ClientDrift get clientDrift => this.accessor(i6.ClientDrift.new);
}
