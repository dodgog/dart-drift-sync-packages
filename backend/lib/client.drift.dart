// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;
import 'package:backend/src/client/events.drift.dart' as i2;
import 'package:backend/src/client/users.drift.dart' as i3;
import 'package:backend/src/shared/shared_events.drift.dart' as i4;
import 'package:backend/src/shared/shared_users.drift.dart' as i5;

class ClientDrift extends i1.ModularAccessor {
  ClientDrift(i0.GeneratedDatabase db) : super(db);
  i2.EventsDrift get eventsDrift => this.accessor(i2.EventsDrift.new);
  i3.UsersDrift get usersDrift => this.accessor(i3.UsersDrift.new);
  i4.SharedEventsDrift get sharedEventsDrift =>
      this.accessor(i4.SharedEventsDrift.new);
  i5.SharedUsersDrift get sharedUsersDrift =>
      this.accessor(i5.SharedUsersDrift.new);
}
