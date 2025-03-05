// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/client_definitions/users.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i3;
import 'package:backend/client.drift.dart' as i4;

typedef $ConfigCreateCompanionBuilder = i1.ConfigCompanion Function({
  i0.Value<String?> clientId,
  i0.Value<String?> lastServerIssuedTimestamp,
  i0.Value<String?> userId,
  i0.Value<String?> userToken,
  i0.Value<String> hlcAbsoluteZero,
  i0.Value<int> rowid,
});
typedef $ConfigUpdateCompanionBuilder = i1.ConfigCompanion Function({
  i0.Value<String?> clientId,
  i0.Value<String?> lastServerIssuedTimestamp,
  i0.Value<String?> userId,
  i0.Value<String?> userToken,
  i0.Value<String> hlcAbsoluteZero,
  i0.Value<int> rowid,
});

final class $ConfigReferences
    extends i0.BaseReferences<i0.GeneratedDatabase, i1.Config, i1.ConfigData> {
  $ConfigReferences(super.$_db, super.$_table, super.$_typedResult);

  static i3.Users _userIdTable(i0.GeneratedDatabase db) =>
      i2.ReadDatabaseContainer(db).resultSet<i3.Users>('users').createAlias(
          i0.$_aliasNameGenerator(
              i2.ReadDatabaseContainer(db)
                  .resultSet<i1.Config>('config')
                  .userId,
              i2.ReadDatabaseContainer(db).resultSet<i3.Users>('users').id));

  i3.$UsersProcessedTableManager? get userId {
    final $_column = $_itemColumn<String>('user_id');
    if ($_column == null) return null;
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

class $ConfigFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Config> {
  $ConfigFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get lastServerIssuedTimestamp => $composableBuilder(
      column: $table.lastServerIssuedTimestamp,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get userToken => $composableBuilder(
      column: $table.userToken, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get hlcAbsoluteZero => $composableBuilder(
      column: $table.hlcAbsoluteZero,
      builder: (column) => i0.ColumnFilters(column));

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

class $ConfigOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Config> {
  $ConfigOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get lastServerIssuedTimestamp =>
      $composableBuilder(
          column: $table.lastServerIssuedTimestamp,
          builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get userToken => $composableBuilder(
      column: $table.userToken,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get hlcAbsoluteZero => $composableBuilder(
      column: $table.hlcAbsoluteZero,
      builder: (column) => i0.ColumnOrderings(column));

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

class $ConfigAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Config> {
  $ConfigAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  i0.GeneratedColumn<String> get lastServerIssuedTimestamp =>
      $composableBuilder(
          column: $table.lastServerIssuedTimestamp,
          builder: (column) => column);

  i0.GeneratedColumn<String> get userToken =>
      $composableBuilder(column: $table.userToken, builder: (column) => column);

  i0.GeneratedColumn<String> get hlcAbsoluteZero => $composableBuilder(
      column: $table.hlcAbsoluteZero, builder: (column) => column);

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

class $ConfigTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.Config,
    i1.ConfigData,
    i1.$ConfigFilterComposer,
    i1.$ConfigOrderingComposer,
    i1.$ConfigAnnotationComposer,
    $ConfigCreateCompanionBuilder,
    $ConfigUpdateCompanionBuilder,
    (i1.ConfigData, i1.$ConfigReferences),
    i1.ConfigData,
    i0.PrefetchHooks Function({bool userId})> {
  $ConfigTableManager(i0.GeneratedDatabase db, i1.Config table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$ConfigFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$ConfigOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$ConfigAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String?> clientId = const i0.Value.absent(),
            i0.Value<String?> lastServerIssuedTimestamp =
                const i0.Value.absent(),
            i0.Value<String?> userId = const i0.Value.absent(),
            i0.Value<String?> userToken = const i0.Value.absent(),
            i0.Value<String> hlcAbsoluteZero = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.ConfigCompanion(
            clientId: clientId,
            lastServerIssuedTimestamp: lastServerIssuedTimestamp,
            userId: userId,
            userToken: userToken,
            hlcAbsoluteZero: hlcAbsoluteZero,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            i0.Value<String?> clientId = const i0.Value.absent(),
            i0.Value<String?> lastServerIssuedTimestamp =
                const i0.Value.absent(),
            i0.Value<String?> userId = const i0.Value.absent(),
            i0.Value<String?> userToken = const i0.Value.absent(),
            i0.Value<String> hlcAbsoluteZero = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.ConfigCompanion.insert(
            clientId: clientId,
            lastServerIssuedTimestamp: lastServerIssuedTimestamp,
            userId: userId,
            userToken: userToken,
            hlcAbsoluteZero: hlcAbsoluteZero,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), i1.$ConfigReferences(db, table, e)))
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
                    referencedTable: i1.$ConfigReferences._userIdTable(db),
                    referencedColumn: i1.$ConfigReferences._userIdTable(db).id,
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

typedef $ConfigProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.Config,
    i1.ConfigData,
    i1.$ConfigFilterComposer,
    i1.$ConfigOrderingComposer,
    i1.$ConfigAnnotationComposer,
    $ConfigCreateCompanionBuilder,
    $ConfigUpdateCompanionBuilder,
    (i1.ConfigData, i1.$ConfigReferences),
    i1.ConfigData,
    i0.PrefetchHooks Function({bool userId})>;

class Config extends i0.Table with i0.TableInfo<Config, i1.ConfigData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Config(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _clientIdMeta =
      const i0.VerificationMeta('clientId');
  late final i0.GeneratedColumn<String> clientId = i0.GeneratedColumn<String>(
      'client_id', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _lastServerIssuedTimestampMeta =
      const i0.VerificationMeta('lastServerIssuedTimestamp');
  late final i0.GeneratedColumn<String> lastServerIssuedTimestamp =
      i0.GeneratedColumn<String>(
          'last_server_issued_timestamp', aliasedName, true,
          type: i0.DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const i0.VerificationMeta _userIdMeta =
      const i0.VerificationMeta('userId');
  late final i0.GeneratedColumn<String> userId = i0.GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES users(id)');
  static const i0.VerificationMeta _userTokenMeta =
      const i0.VerificationMeta('userToken');
  late final i0.GeneratedColumn<String> userToken = i0.GeneratedColumn<String>(
      'user_token', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _hlcAbsoluteZeroMeta =
      const i0.VerificationMeta('hlcAbsoluteZero');
  late final i0.GeneratedColumn<String> hlcAbsoluteZero =
      i0.GeneratedColumn<String>('hlc_absolute_zero', aliasedName, false,
          type: i0.DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints:
              'NOT NULL DEFAULT \'1969-01-01T00:00:01.000Z-0000-00000\'',
          defaultValue: const i0.CustomExpression(
              '\'1969-01-01T00:00:01.000Z-0000-00000\''));
  @override
  List<i0.GeneratedColumn> get $columns =>
      [clientId, lastServerIssuedTimestamp, userId, userToken, hlcAbsoluteZero];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'config';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.ConfigData> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    }
    if (data.containsKey('last_server_issued_timestamp')) {
      context.handle(
          _lastServerIssuedTimestampMeta,
          lastServerIssuedTimestamp.isAcceptableOrUnknown(
              data['last_server_issued_timestamp']!,
              _lastServerIssuedTimestampMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('user_token')) {
      context.handle(_userTokenMeta,
          userToken.isAcceptableOrUnknown(data['user_token']!, _userTokenMeta));
    }
    if (data.containsKey('hlc_absolute_zero')) {
      context.handle(
          _hlcAbsoluteZeroMeta,
          hlcAbsoluteZero.isAcceptableOrUnknown(
              data['hlc_absolute_zero']!, _hlcAbsoluteZeroMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => const {};
  @override
  i1.ConfigData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ConfigData(
      clientId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}client_id']),
      lastServerIssuedTimestamp: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string,
          data['${effectivePrefix}last_server_issued_timestamp']),
      userId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}user_id']),
      userToken: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}user_token']),
      hlcAbsoluteZero: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}hlc_absolute_zero'])!,
    );
  }

  @override
  Config createAlias(String alias) {
    return Config(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ConfigData extends i0.DataClass implements i0.Insertable<i1.ConfigData> {
  final String? clientId;

  /// unique per device
  final String? lastServerIssuedTimestamp;
  final String? userId;
  final String? userToken;
  final String hlcAbsoluteZero;
  const ConfigData(
      {this.clientId,
      this.lastServerIssuedTimestamp,
      this.userId,
      this.userToken,
      required this.hlcAbsoluteZero});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = i0.Variable<String>(clientId);
    }
    if (!nullToAbsent || lastServerIssuedTimestamp != null) {
      map['last_server_issued_timestamp'] =
          i0.Variable<String>(lastServerIssuedTimestamp);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = i0.Variable<String>(userId);
    }
    if (!nullToAbsent || userToken != null) {
      map['user_token'] = i0.Variable<String>(userToken);
    }
    map['hlc_absolute_zero'] = i0.Variable<String>(hlcAbsoluteZero);
    return map;
  }

  i1.ConfigCompanion toCompanion(bool nullToAbsent) {
    return i1.ConfigCompanion(
      clientId: clientId == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(clientId),
      lastServerIssuedTimestamp:
          lastServerIssuedTimestamp == null && nullToAbsent
              ? const i0.Value.absent()
              : i0.Value(lastServerIssuedTimestamp),
      userId: userId == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(userId),
      userToken: userToken == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(userToken),
      hlcAbsoluteZero: i0.Value(hlcAbsoluteZero),
    );
  }

  factory ConfigData.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ConfigData(
      clientId: serializer.fromJson<String?>(json['client_id']),
      lastServerIssuedTimestamp:
          serializer.fromJson<String?>(json['last_server_issued_timestamp']),
      userId: serializer.fromJson<String?>(json['user_id']),
      userToken: serializer.fromJson<String?>(json['user_token']),
      hlcAbsoluteZero: serializer.fromJson<String>(json['hlc_absolute_zero']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'client_id': serializer.toJson<String?>(clientId),
      'last_server_issued_timestamp':
          serializer.toJson<String?>(lastServerIssuedTimestamp),
      'user_id': serializer.toJson<String?>(userId),
      'user_token': serializer.toJson<String?>(userToken),
      'hlc_absolute_zero': serializer.toJson<String>(hlcAbsoluteZero),
    };
  }

  i1.ConfigData copyWith(
          {i0.Value<String?> clientId = const i0.Value.absent(),
          i0.Value<String?> lastServerIssuedTimestamp = const i0.Value.absent(),
          i0.Value<String?> userId = const i0.Value.absent(),
          i0.Value<String?> userToken = const i0.Value.absent(),
          String? hlcAbsoluteZero}) =>
      i1.ConfigData(
        clientId: clientId.present ? clientId.value : this.clientId,
        lastServerIssuedTimestamp: lastServerIssuedTimestamp.present
            ? lastServerIssuedTimestamp.value
            : this.lastServerIssuedTimestamp,
        userId: userId.present ? userId.value : this.userId,
        userToken: userToken.present ? userToken.value : this.userToken,
        hlcAbsoluteZero: hlcAbsoluteZero ?? this.hlcAbsoluteZero,
      );
  ConfigData copyWithCompanion(i1.ConfigCompanion data) {
    return ConfigData(
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      lastServerIssuedTimestamp: data.lastServerIssuedTimestamp.present
          ? data.lastServerIssuedTimestamp.value
          : this.lastServerIssuedTimestamp,
      userId: data.userId.present ? data.userId.value : this.userId,
      userToken: data.userToken.present ? data.userToken.value : this.userToken,
      hlcAbsoluteZero: data.hlcAbsoluteZero.present
          ? data.hlcAbsoluteZero.value
          : this.hlcAbsoluteZero,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConfigData(')
          ..write('clientId: $clientId, ')
          ..write('lastServerIssuedTimestamp: $lastServerIssuedTimestamp, ')
          ..write('userId: $userId, ')
          ..write('userToken: $userToken, ')
          ..write('hlcAbsoluteZero: $hlcAbsoluteZero')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      clientId, lastServerIssuedTimestamp, userId, userToken, hlcAbsoluteZero);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ConfigData &&
          other.clientId == this.clientId &&
          other.lastServerIssuedTimestamp == this.lastServerIssuedTimestamp &&
          other.userId == this.userId &&
          other.userToken == this.userToken &&
          other.hlcAbsoluteZero == this.hlcAbsoluteZero);
}

class ConfigCompanion extends i0.UpdateCompanion<i1.ConfigData> {
  final i0.Value<String?> clientId;
  final i0.Value<String?> lastServerIssuedTimestamp;
  final i0.Value<String?> userId;
  final i0.Value<String?> userToken;
  final i0.Value<String> hlcAbsoluteZero;
  final i0.Value<int> rowid;
  const ConfigCompanion({
    this.clientId = const i0.Value.absent(),
    this.lastServerIssuedTimestamp = const i0.Value.absent(),
    this.userId = const i0.Value.absent(),
    this.userToken = const i0.Value.absent(),
    this.hlcAbsoluteZero = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  ConfigCompanion.insert({
    this.clientId = const i0.Value.absent(),
    this.lastServerIssuedTimestamp = const i0.Value.absent(),
    this.userId = const i0.Value.absent(),
    this.userToken = const i0.Value.absent(),
    this.hlcAbsoluteZero = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  static i0.Insertable<i1.ConfigData> custom({
    i0.Expression<String>? clientId,
    i0.Expression<String>? lastServerIssuedTimestamp,
    i0.Expression<String>? userId,
    i0.Expression<String>? userToken,
    i0.Expression<String>? hlcAbsoluteZero,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (lastServerIssuedTimestamp != null)
        'last_server_issued_timestamp': lastServerIssuedTimestamp,
      if (userId != null) 'user_id': userId,
      if (userToken != null) 'user_token': userToken,
      if (hlcAbsoluteZero != null) 'hlc_absolute_zero': hlcAbsoluteZero,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.ConfigCompanion copyWith(
      {i0.Value<String?>? clientId,
      i0.Value<String?>? lastServerIssuedTimestamp,
      i0.Value<String?>? userId,
      i0.Value<String?>? userToken,
      i0.Value<String>? hlcAbsoluteZero,
      i0.Value<int>? rowid}) {
    return i1.ConfigCompanion(
      clientId: clientId ?? this.clientId,
      lastServerIssuedTimestamp:
          lastServerIssuedTimestamp ?? this.lastServerIssuedTimestamp,
      userId: userId ?? this.userId,
      userToken: userToken ?? this.userToken,
      hlcAbsoluteZero: hlcAbsoluteZero ?? this.hlcAbsoluteZero,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (clientId.present) {
      map['client_id'] = i0.Variable<String>(clientId.value);
    }
    if (lastServerIssuedTimestamp.present) {
      map['last_server_issued_timestamp'] =
          i0.Variable<String>(lastServerIssuedTimestamp.value);
    }
    if (userId.present) {
      map['user_id'] = i0.Variable<String>(userId.value);
    }
    if (userToken.present) {
      map['user_token'] = i0.Variable<String>(userToken.value);
    }
    if (hlcAbsoluteZero.present) {
      map['hlc_absolute_zero'] = i0.Variable<String>(hlcAbsoluteZero.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfigCompanion(')
          ..write('clientId: $clientId, ')
          ..write('lastServerIssuedTimestamp: $lastServerIssuedTimestamp, ')
          ..write('userId: $userId, ')
          ..write('userToken: $userToken, ')
          ..write('hlcAbsoluteZero: $hlcAbsoluteZero, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class UsersDrift extends i2.ModularAccessor {
  UsersDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i3.Client> getCurrentClient() {
    return customSelect(
        'SELECT c.* FROM clients AS c INNER JOIN config AS conf ON conf.client_id = c.id',
        variables: [],
        readsFrom: {
          clients,
          config,
        }).asyncMap(clients.mapFromRow);
  }

  Future<int> initializeConfig() {
    return customInsert(
      'INSERT INTO config (client_id, last_server_issued_timestamp, user_id, user_token) VALUES (NULL, NULL, NULL, NULL)',
      variables: [],
      updates: {config},
    );
  }

  Future<int> setClientId({required String? newClientId}) {
    return customUpdate(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite => 'UPDATE config SET client_id = ?1',
        i0.SqlDialect.postgres || _ => 'UPDATE config SET client_id = \$1',
      },
      variables: [i0.Variable<String>(newClientId)],
      updates: {config},
      updateKind: i0.UpdateKind.update,
    );
  }

  Future<int> setLastSyncTime({required String? newLastSyncTime}) {
    return customUpdate(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'UPDATE config SET last_server_issued_timestamp = ?1',
        i0.SqlDialect.postgres ||
        _ =>
          'UPDATE config SET last_server_issued_timestamp = \$1',
      },
      variables: [i0.Variable<String>(newLastSyncTime)],
      updates: {config},
      updateKind: i0.UpdateKind.update,
    );
  }

  i0.Selectable<i1.ConfigData> getConfig() {
    return customSelect('SELECT * FROM config', variables: [], readsFrom: {
      config,
    }).asyncMap(config.mapFromRow);
  }

  Future<int> setUserId({required String? newUserId}) {
    return customUpdate(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite => 'UPDATE config SET user_id = ?1',
        i0.SqlDialect.postgres || _ => 'UPDATE config SET user_id = \$1',
      },
      variables: [i0.Variable<String>(newUserId)],
      updates: {config},
      updateKind: i0.UpdateKind.update,
    );
  }

  Future<int> setUserToken({required String? newUserToken}) {
    return customUpdate(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite => 'UPDATE config SET user_token = ?1',
        i0.SqlDialect.postgres || _ => 'UPDATE config SET user_token = \$1',
      },
      variables: [i0.Variable<String>(newUserToken)],
      updates: {config},
      updateKind: i0.UpdateKind.update,
    );
  }

  i3.Clients get clients => i2.ReadDatabaseContainer(attachedDatabase)
      .resultSet<i3.Clients>('clients');
  i1.Config get config =>
      i2.ReadDatabaseContainer(attachedDatabase).resultSet<i1.Config>('config');
  i4.ClientDrift get clientDrift => this.accessor(i4.ClientDrift.new);
}
