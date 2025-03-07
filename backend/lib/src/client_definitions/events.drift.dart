// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i2;
import 'package:backend/src/client_definitions/users.drift.dart' as i3;
import 'package:backend/client.drift.dart' as i4;

class EventsDrift extends i1.ModularAccessor {
  EventsDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i2.Event> getLocalEventsToPush() {
    return customSelect(
        'SELECT e.* FROM events AS e WHERE e.timestamp > (SELECT COALESCE(last_server_issued_timestamp, hlc_absolute_zero) FROM config LIMIT 1)',
        variables: [],
        readsFrom: {
          events,
          config,
        }).asyncMap(events.mapFromRow);
  }

  i2.Events get events =>
      i1.ReadDatabaseContainer(attachedDatabase).resultSet<i2.Events>('events');
  i3.Config get config =>
      i1.ReadDatabaseContainer(attachedDatabase).resultSet<i3.Config>('config');
  i4.ClientDrift get clientDrift => this.accessor(i4.ClientDrift.new);
}
