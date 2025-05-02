// dart format width=80
// ignore_for_file: type=lint
import 'package:backend/src/shared/shared_definitions/shared_bundles.drift.dart'
    as i3;
import 'package:backend/src/shared/shared_definitions/shared_users.drift.dart'
    as i2;
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;

class SharedDrift extends i1.ModularAccessor {
  SharedDrift(i0.GeneratedDatabase db) : super(db);
  i2.SharedUsersDrift get sharedUsersDrift =>
      this.accessor(i2.SharedUsersDrift.new);
  i3.SharedBundlesDrift get sharedBundlesDrift =>
      this.accessor(i3.SharedBundlesDrift.new);
}
