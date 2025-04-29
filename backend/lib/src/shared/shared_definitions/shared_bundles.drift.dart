// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared/shared_definitions/shared_bundles.drift.dart'
    as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:backend/src/shared/shared_definitions/shared_users.drift.dart'
    as i3;

typedef $BundlesCreateCompanionBuilder = i1.BundlesCompanion Function({
  required String id,
  required String userId,
  required String timestamp,
  i0.Value<String?> payload,
  i0.Value<int> rowid,
});
typedef $BundlesUpdateCompanionBuilder = i1.BundlesCompanion Function({
  i0.Value<String> id,
  i0.Value<String> userId,
  i0.Value<String> timestamp,
  i0.Value<String?> payload,
  i0.Value<int> rowid,
});

final class $BundlesReferences
    extends i0.BaseReferences<i0.GeneratedDatabase, i1.Bundles, i1.Bundle> {
  $BundlesReferences(super.$_db, super.$_table, super.$_typedResult);

  static i3.Users _userIdTable(i0.GeneratedDatabase db) =>
      i2.ReadDatabaseContainer(db).resultSet<i3.Users>('users').createAlias(
          i0.$_aliasNameGenerator(
              i2.ReadDatabaseContainer(db)
                  .resultSet<i1.Bundles>('bundles')
                  .userId,
              i2.ReadDatabaseContainer(db).resultSet<i3.Users>('users').id));

  i3.$UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = i3
        .$UsersTableManager(
            $_db, i2.ReadDatabaseContainer($_db).resultSet<i3.Users>('users'))
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return i0.ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $BundlesFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Bundles> {
  $BundlesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => i0.ColumnFilters(column));

  i3.$UsersFilterComposer get userId {
    final i3.$UsersFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i3.Users>('users'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i3.$UsersFilterComposer(
              $db: $db,
              $table:
                  i2.ReadDatabaseContainer($db).resultSet<i3.Users>('users'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $BundlesOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Bundles> {
  $BundlesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get timestamp => $composableBuilder(
      column: $table.timestamp,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => i0.ColumnOrderings(column));

  i3.$UsersOrderingComposer get userId {
    final i3.$UsersOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i3.Users>('users'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i3.$UsersOrderingComposer(
              $db: $db,
              $table:
                  i2.ReadDatabaseContainer($db).resultSet<i3.Users>('users'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $BundlesAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Bundles> {
  $BundlesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  i0.GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  i3.$UsersAnnotationComposer get userId {
    final i3.$UsersAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i3.Users>('users'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i3.$UsersAnnotationComposer(
              $db: $db,
              $table:
                  i2.ReadDatabaseContainer($db).resultSet<i3.Users>('users'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $BundlesTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.Bundles,
    i1.Bundle,
    i1.$BundlesFilterComposer,
    i1.$BundlesOrderingComposer,
    i1.$BundlesAnnotationComposer,
    $BundlesCreateCompanionBuilder,
    $BundlesUpdateCompanionBuilder,
    (i1.Bundle, i1.$BundlesReferences),
    i1.Bundle,
    i0.PrefetchHooks Function({bool userId})> {
  $BundlesTableManager(i0.GeneratedDatabase db, i1.Bundles table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$BundlesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$BundlesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$BundlesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> id = const i0.Value.absent(),
            i0.Value<String> userId = const i0.Value.absent(),
            i0.Value<String> timestamp = const i0.Value.absent(),
            i0.Value<String?> payload = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.BundlesCompanion(
            id: id,
            userId: userId,
            timestamp: timestamp,
            payload: payload,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String timestamp,
            i0.Value<String?> payload = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.BundlesCompanion.insert(
            id: id,
            userId: userId,
            timestamp: timestamp,
            payload: payload,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), i1.$BundlesReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return i0.PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends i0.TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: i1.$BundlesReferences._userIdTable(db),
                    referencedColumn: i1.$BundlesReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $BundlesProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.Bundles,
    i1.Bundle,
    i1.$BundlesFilterComposer,
    i1.$BundlesOrderingComposer,
    i1.$BundlesAnnotationComposer,
    $BundlesCreateCompanionBuilder,
    $BundlesUpdateCompanionBuilder,
    (i1.Bundle, i1.$BundlesReferences),
    i1.Bundle,
    i0.PrefetchHooks Function({bool userId})>;

class Bundles extends i0.Table with i0.TableInfo<Bundles, i1.Bundle> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Bundles(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const i0.VerificationMeta _userIdMeta =
      const i0.VerificationMeta('userId');
  late final i0.GeneratedColumn<String> userId = i0.GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES users(id)');
  static const i0.VerificationMeta _timestampMeta =
      const i0.VerificationMeta('timestamp');
  late final i0.GeneratedColumn<String> timestamp = i0.GeneratedColumn<String>(
      'timestamp', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _payloadMeta =
      const i0.VerificationMeta('payload');
  late final i0.GeneratedColumn<String> payload = i0.GeneratedColumn<String>(
      'payload', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<i0.GeneratedColumn> get $columns => [id, userId, timestamp, payload];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bundles';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Bundle> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Bundle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Bundle(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      timestamp: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}timestamp'])!,
      payload: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}payload']),
    );
  }

  @override
  Bundles createAlias(String alias) {
    return Bundles(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Bundle extends i0.DataClass implements i0.Insertable<i1.Bundle> {
  final String id;
  final String userId;
  final String timestamp;
  final String? payload;
  const Bundle(
      {required this.id,
      required this.userId,
      required this.timestamp,
      this.payload});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    map['user_id'] = i0.Variable<String>(userId);
    map['timestamp'] = i0.Variable<String>(timestamp);
    if (!nullToAbsent || payload != null) {
      map['payload'] = i0.Variable<String>(payload);
    }
    return map;
  }

  i1.BundlesCompanion toCompanion(bool nullToAbsent) {
    return i1.BundlesCompanion(
      id: i0.Value(id),
      userId: i0.Value(userId),
      timestamp: i0.Value(timestamp),
      payload: payload == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(payload),
    );
  }

  factory Bundle.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Bundle(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['user_id']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
      payload: serializer.fromJson<String?>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<String>(userId),
      'timestamp': serializer.toJson<String>(timestamp),
      'payload': serializer.toJson<String?>(payload),
    };
  }

  i1.Bundle copyWith(
          {String? id,
          String? userId,
          String? timestamp,
          i0.Value<String?> payload = const i0.Value.absent()}) =>
      i1.Bundle(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        timestamp: timestamp ?? this.timestamp,
        payload: payload.present ? payload.value : this.payload,
      );
  Bundle copyWithCompanion(i1.BundlesCompanion data) {
    return Bundle(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      payload: data.payload.present ? data.payload.value : this.payload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bundle(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('timestamp: $timestamp, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, timestamp, payload);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Bundle &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.timestamp == this.timestamp &&
          other.payload == this.payload);
}

class BundlesCompanion extends i0.UpdateCompanion<i1.Bundle> {
  final i0.Value<String> id;
  final i0.Value<String> userId;
  final i0.Value<String> timestamp;
  final i0.Value<String?> payload;
  final i0.Value<int> rowid;
  const BundlesCompanion({
    this.id = const i0.Value.absent(),
    this.userId = const i0.Value.absent(),
    this.timestamp = const i0.Value.absent(),
    this.payload = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  BundlesCompanion.insert({
    required String id,
    required String userId,
    required String timestamp,
    this.payload = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  })  : id = i0.Value(id),
        userId = i0.Value(userId),
        timestamp = i0.Value(timestamp);
  static i0.Insertable<i1.Bundle> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? userId,
    i0.Expression<String>? timestamp,
    i0.Expression<String>? payload,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (timestamp != null) 'timestamp': timestamp,
      if (payload != null) 'payload': payload,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.BundlesCompanion copyWith(
      {i0.Value<String>? id,
      i0.Value<String>? userId,
      i0.Value<String>? timestamp,
      i0.Value<String?>? payload,
      i0.Value<int>? rowid}) {
    return i1.BundlesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
      payload: payload ?? this.payload,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = i0.Variable<String>(userId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = i0.Variable<String>(timestamp.value);
    }
    if (payload.present) {
      map['payload'] = i0.Variable<String>(payload.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BundlesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('timestamp: $timestamp, ')
          ..write('payload: $payload, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class SharedBundlesDrift extends i2.ModularAccessor {
  SharedBundlesDrift(i0.GeneratedDatabase db) : super(db);
  Future<int> insertBundle(
      {required String id,
      required String userId,
      required String timestamp,
      required String? payload}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'INSERT INTO bundles (id, user_id, timestamp, payload) VALUES (?1, ?2, ?3, ?4) ON CONFLICT (id) DO NOTHING',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO bundles (id, user_id, timestamp, payload) VALUES (\$1, \$2, \$3, \$4) ON CONFLICT (id) DO NOTHING',
      },
      variables: [
        i0.Variable<String>(id),
        i0.Variable<String>(userId),
        i0.Variable<String>(timestamp),
        i0.Variable<String>(payload)
      ],
      updates: {bundles},
    );
  }

  i0.Selectable<String> getAllBundlesIds() {
    return customSelect('SELECT id FROM bundles', variables: [], readsFrom: {
      bundles,
    }).map((i0.QueryRow row) => row.read<String>('id'));
  }

  i1.Bundles get bundles => i2.ReadDatabaseContainer(attachedDatabase)
      .resultSet<i1.Bundles>('bundles');
  i3.SharedUsersDrift get sharedUsersDrift =>
      this.accessor(i3.SharedUsersDrift.new);
}
