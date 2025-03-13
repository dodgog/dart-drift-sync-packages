// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/internal/modular.dart' as i1;
import 'package:backend/src/shared_definitions/shared_bundles.drift.dart' as i2;
import 'package:backend/server.drift.dart' as i3;
import 'package:backend/src/server_definitions/users.drift.dart' as i4;

class BundlesDrift extends i1.ModularAccessor {
  BundlesDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<String> getBundleIdsForUser({required String userId}) {
    return customSelect(
        switch (executor.dialect) {
          i0.SqlDialect.sqlite => 'SELECT id FROM bundles WHERE user_id = ?1',
          i0.SqlDialect.postgres ||
          _ =>
            'SELECT id FROM bundles WHERE user_id = \$1',
        },
        variables: [
          i0.Variable<String>(userId)
        ],
        readsFrom: {
          bundles,
        }).map((i0.QueryRow row) => row.read<String>('id'));
  }

  i0.Selectable<String?> getBundlePayloadById({required String id}) {
    return customSelect(
        switch (executor.dialect) {
          i0.SqlDialect.sqlite => 'SELECT payload FROM bundles WHERE id = ?1',
          i0.SqlDialect.postgres ||
          _ =>
            'SELECT payload FROM bundles WHERE id = \$1',
        },
        variables: [
          i0.Variable<String>(id)
        ],
        readsFrom: {
          bundles,
        }).map((i0.QueryRow row) => row.readNullable<String>('payload'));
  }

  i0.Selectable<i2.Bundle> getUserBundlesSinceTimestamp(
      {required String userId, required String timestamp}) {
    return customSelect(
        switch (executor.dialect) {
          i0.SqlDialect.sqlite =>
            'SELECT * FROM bundles WHERE user_id = ?1 AND timestamp > ?2',
          i0.SqlDialect.postgres ||
          _ =>
            'SELECT * FROM bundles WHERE user_id = \$1 AND timestamp > \$2',
        },
        variables: [
          i0.Variable<String>(userId),
          i0.Variable<String>(timestamp)
        ],
        readsFrom: {
          bundles,
        }).asyncMap(bundles.mapFromRow);
  }

  i0.Selectable<i2.Bundle> getAllUserBundles({required String userId}) {
    return customSelect(
        switch (executor.dialect) {
          i0.SqlDialect.sqlite => 'SELECT * FROM bundles WHERE user_id = ?1',
          i0.SqlDialect.postgres ||
          _ =>
            'SELECT * FROM bundles WHERE user_id = \$1',
        },
        variables: [
          i0.Variable<String>(userId)
        ],
        readsFrom: {
          bundles,
        }).asyncMap(bundles.mapFromRow);
  }

  i2.Bundles get bundles => i1.ReadDatabaseContainer(attachedDatabase)
      .resultSet<i2.Bundles>('bundles');
  i3.ServerDrift get serverDrift => this.accessor(i3.ServerDrift.new);
  i4.UsersDrift get usersDrift => this.accessor(i4.UsersDrift.new);
}
