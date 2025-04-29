// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;
import 'package:backend/src/client/client_definitions/events.drift.dart' as i2;
import 'package:backend/src/client/client_definitions/users.drift.dart' as i3;
import 'package:backend/src/client/client_definitions/attributes.drift.dart'
    as i4;
import 'package:backend/shared.drift.dart' as i5;

class ClientDrift extends i1.ModularAccessor {
  ClientDrift(i0.GeneratedDatabase db) : super(db);
  i2.EventsDrift get eventsDrift => this.accessor(i2.EventsDrift.new);
  i3.UsersDrift get usersDrift => this.accessor(i3.UsersDrift.new);
  i4.AttributesDrift get attributesDrift =>
      this.accessor(i4.AttributesDrift.new);
  i5.SharedDrift get sharedDrift => this.accessor(i5.SharedDrift.new);
}
