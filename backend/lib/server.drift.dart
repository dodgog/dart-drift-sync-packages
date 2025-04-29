// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;
import 'package:backend/src/server/server_definitions/users.drift.dart' as i2;
import 'package:backend/src/server/server_definitions/bundles.drift.dart' as i3;
import 'package:backend/shared.drift.dart' as i4;

class ServerDrift extends i1.ModularAccessor {
  ServerDrift(i0.GeneratedDatabase db) : super(db);
  i2.UsersDrift get usersDrift => this.accessor(i2.UsersDrift.new);
  i3.BundlesDrift get bundlesDrift => this.accessor(i3.BundlesDrift.new);
  i4.SharedDrift get sharedDrift => this.accessor(i4.SharedDrift.new);
}
