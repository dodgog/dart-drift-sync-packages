// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;
import 'package:backend/src/server_definitions/events.drift.dart' as i2;
import 'package:backend/src/server_definitions/users.drift.dart' as i3;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i4;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i5;
import 'package:backend/src/shared_definitions/shared_nodes.drift.dart' as i6;

class ServerDrift extends i1.ModularAccessor {
  ServerDrift(i0.GeneratedDatabase db) : super(db);
  i2.EventsDrift get eventsDrift => this.accessor(i2.EventsDrift.new);
  i3.UsersDrift get usersDrift => this.accessor(i3.UsersDrift.new);
  i4.SharedEventsDrift get sharedEventsDrift =>
      this.accessor(i4.SharedEventsDrift.new);
  i5.SharedUsersDrift get sharedUsersDrift =>
      this.accessor(i5.SharedUsersDrift.new);
  i6.SharedNodesDrift get sharedNodesDrift =>
      this.accessor(i6.SharedNodesDrift.new);
}
