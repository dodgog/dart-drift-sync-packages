// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i2;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i3;
import 'package:backend/src/shared_definitions/shared_attributes.drift.dart'
    as i4;
import 'package:backend/src/shared_definitions/shared_bundles.drift.dart' as i5;

class SharedDrift extends i1.ModularAccessor {
  SharedDrift(i0.GeneratedDatabase db) : super(db);
  i2.SharedEventsDrift get sharedEventsDrift =>
      this.accessor(i2.SharedEventsDrift.new);
  i3.SharedUsersDrift get sharedUsersDrift =>
      this.accessor(i3.SharedUsersDrift.new);
  i4.SharedAttributesDrift get sharedAttributesDrift =>
      this.accessor(i4.SharedAttributesDrift.new);
  i5.SharedBundlesDrift get sharedBundlesDrift =>
      this.accessor(i5.SharedBundlesDrift.new);
}
