// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/server/users.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:backend/src/shared/users.drift.dart' as i3;

typedef $AuthCreateCompanionBuilder = i1.AuthCompanion Function({
  i0.Value<String?> userId,
  i0.Value<String?> token,
  i0.Value<int> rowid,
});
typedef $AuthUpdateCompanionBuilder = i1.AuthCompanion Function({
  i0.Value<String?> userId,
  i0.Value<String?> token,
  i0.Value<int> rowid,
});

final class $AuthReferences
    extends i0.BaseReferences<i0.GeneratedDatabase, i1.Auth, i1.AuthData> {
  $AuthReferences(super.$_db, super.$_table, super.$_typedResult);

  static i3.Users _userIdTable(i0.GeneratedDatabase db) =>
      i2.ReadDatabaseContainer(db).resultSet<i3.Users>('users').createAlias(
          i0.$_aliasNameGenerator(
              i2.ReadDatabaseContainer(db).resultSet<i1.Auth>('auth').userId,
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

class $AuthFilterComposer extends i0.Composer<i0.GeneratedDatabase, i1.Auth> {
  $AuthFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get token => $composableBuilder(
      column: $table.token, builder: (column) => i0.ColumnFilters(column));

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

class $AuthOrderingComposer extends i0.Composer<i0.GeneratedDatabase, i1.Auth> {
  $AuthOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get token => $composableBuilder(
      column: $table.token, builder: (column) => i0.ColumnOrderings(column));

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

class $AuthAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Auth> {
  $AuthAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);

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

class $AuthTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.Auth,
    i1.AuthData,
    i1.$AuthFilterComposer,
    i1.$AuthOrderingComposer,
    i1.$AuthAnnotationComposer,
    $AuthCreateCompanionBuilder,
    $AuthUpdateCompanionBuilder,
    (i1.AuthData, i1.$AuthReferences),
    i1.AuthData,
    i0.PrefetchHooks Function({bool userId})> {
  $AuthTableManager(i0.GeneratedDatabase db, i1.Auth table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$AuthFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$AuthOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$AuthAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String?> userId = const i0.Value.absent(),
            i0.Value<String?> token = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.AuthCompanion(
            userId: userId,
            token: token,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            i0.Value<String?> userId = const i0.Value.absent(),
            i0.Value<String?> token = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.AuthCompanion.insert(
            userId: userId,
            token: token,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map(
                  (e) => (e.readTable(table), i1.$AuthReferences(db, table, e)))
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
                    referencedTable: i1.$AuthReferences._userIdTable(db),
                    referencedColumn: i1.$AuthReferences._userIdTable(db).id,
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

typedef $AuthProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.Auth,
    i1.AuthData,
    i1.$AuthFilterComposer,
    i1.$AuthOrderingComposer,
    i1.$AuthAnnotationComposer,
    $AuthCreateCompanionBuilder,
    $AuthUpdateCompanionBuilder,
    (i1.AuthData, i1.$AuthReferences),
    i1.AuthData,
    i0.PrefetchHooks Function({bool userId})>;

class Auth extends i0.Table with i0.TableInfo<Auth, i1.AuthData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Auth(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _userIdMeta =
      const i0.VerificationMeta('userId');
  late final i0.GeneratedColumn<String> userId = i0.GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES users(id)');
  static const i0.VerificationMeta _tokenMeta =
      const i0.VerificationMeta('token');
  late final i0.GeneratedColumn<String> token = i0.GeneratedColumn<String>(
      'token', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<i0.GeneratedColumn> get $columns => [userId, token];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'auth';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.AuthData> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => const {};
  @override
  i1.AuthData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.AuthData(
      userId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}user_id']),
      token: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}token']),
    );
  }

  @override
  Auth createAlias(String alias) {
    return Auth(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class AuthData extends i0.DataClass implements i0.Insertable<i1.AuthData> {
  final String? userId;
  final String? token;
  const AuthData({this.userId, this.token});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (!nullToAbsent || userId != null) {
      map['user_id'] = i0.Variable<String>(userId);
    }
    if (!nullToAbsent || token != null) {
      map['token'] = i0.Variable<String>(token);
    }
    return map;
  }

  i1.AuthCompanion toCompanion(bool nullToAbsent) {
    return i1.AuthCompanion(
      userId: userId == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(userId),
      token: token == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(token),
    );
  }

  factory AuthData.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return AuthData(
      userId: serializer.fromJson<String?>(json['user_id']),
      token: serializer.fromJson<String?>(json['token']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user_id': serializer.toJson<String?>(userId),
      'token': serializer.toJson<String?>(token),
    };
  }

  i1.AuthData copyWith(
          {i0.Value<String?> userId = const i0.Value.absent(),
          i0.Value<String?> token = const i0.Value.absent()}) =>
      i1.AuthData(
        userId: userId.present ? userId.value : this.userId,
        token: token.present ? token.value : this.token,
      );
  AuthData copyWithCompanion(i1.AuthCompanion data) {
    return AuthData(
      userId: data.userId.present ? data.userId.value : this.userId,
      token: data.token.present ? data.token.value : this.token,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuthData(')
          ..write('userId: $userId, ')
          ..write('token: $token')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, token);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.AuthData &&
          other.userId == this.userId &&
          other.token == this.token);
}

class AuthCompanion extends i0.UpdateCompanion<i1.AuthData> {
  final i0.Value<String?> userId;
  final i0.Value<String?> token;
  final i0.Value<int> rowid;
  const AuthCompanion({
    this.userId = const i0.Value.absent(),
    this.token = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  AuthCompanion.insert({
    this.userId = const i0.Value.absent(),
    this.token = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  static i0.Insertable<i1.AuthData> custom({
    i0.Expression<String>? userId,
    i0.Expression<String>? token,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (token != null) 'token': token,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.AuthCompanion copyWith(
      {i0.Value<String?>? userId,
      i0.Value<String?>? token,
      i0.Value<int>? rowid}) {
    return i1.AuthCompanion(
      userId: userId ?? this.userId,
      token: token ?? this.token,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (userId.present) {
      map['user_id'] = i0.Variable<String>(userId.value);
    }
    if (token.present) {
      map['token'] = i0.Variable<String>(token.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthCompanion(')
          ..write('userId: $userId, ')
          ..write('token: $token, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class UsersDrift extends i2.ModularAccessor {
  UsersDrift(i0.GeneratedDatabase db) : super(db);
  Future<int> authUser({String? userId, String? token}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'INSERT INTO auth (user_id, token) VALUES (?1, ?2)',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO auth (user_id, token) VALUES (\$1, \$2)',
      },
      variables: [i0.Variable<String>(userId), i0.Variable<String>(token)],
      updates: {auth},
    );
  }

  Future<int> cleanAuthedUsers() {
    return customUpdate(
      'DELETE FROM auth',
      variables: [],
      updates: {auth},
      updateKind: i0.UpdateKind.delete,
    );
  }

  i1.Auth get auth =>
      i2.ReadDatabaseContainer(attachedDatabase).resultSet<i1.Auth>('auth');
}
