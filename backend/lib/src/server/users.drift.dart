// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/server/users.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:backend/src/shared/shared_users.drift.dart' as i3;

typedef $AuthsCreateCompanionBuilder = i1.AuthsCompanion Function({
  i0.Value<String?> userId,
  i0.Value<String?> token,
  i0.Value<int> rowid,
});
typedef $AuthsUpdateCompanionBuilder = i1.AuthsCompanion Function({
  i0.Value<String?> userId,
  i0.Value<String?> token,
  i0.Value<int> rowid,
});

final class $AuthsReferences
    extends i0.BaseReferences<i0.GeneratedDatabase, i1.Auths, i1.Auth> {
  $AuthsReferences(super.$_db, super.$_table, super.$_typedResult);

  static i3.Users _userIdTable(i0.GeneratedDatabase db) =>
      i2.ReadDatabaseContainer(db).resultSet<i3.Users>('users').createAlias(
          i0.$_aliasNameGenerator(
              i2.ReadDatabaseContainer(db).resultSet<i1.Auths>('auths').userId,
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

class $AuthsFilterComposer extends i0.Composer<i0.GeneratedDatabase, i1.Auths> {
  $AuthsFilterComposer({
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

class $AuthsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Auths> {
  $AuthsOrderingComposer({
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

class $AuthsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Auths> {
  $AuthsAnnotationComposer({
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

class $AuthsTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.Auths,
    i1.Auth,
    i1.$AuthsFilterComposer,
    i1.$AuthsOrderingComposer,
    i1.$AuthsAnnotationComposer,
    $AuthsCreateCompanionBuilder,
    $AuthsUpdateCompanionBuilder,
    (i1.Auth, i1.$AuthsReferences),
    i1.Auth,
    i0.PrefetchHooks Function({bool userId})> {
  $AuthsTableManager(i0.GeneratedDatabase db, i1.Auths table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$AuthsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$AuthsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$AuthsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String?> userId = const i0.Value.absent(),
            i0.Value<String?> token = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.AuthsCompanion(
            userId: userId,
            token: token,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            i0.Value<String?> userId = const i0.Value.absent(),
            i0.Value<String?> token = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.AuthsCompanion.insert(
            userId: userId,
            token: token,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), i1.$AuthsReferences(db, table, e)))
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
                    referencedTable: i1.$AuthsReferences._userIdTable(db),
                    referencedColumn: i1.$AuthsReferences._userIdTable(db).id,
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

typedef $AuthsProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.Auths,
    i1.Auth,
    i1.$AuthsFilterComposer,
    i1.$AuthsOrderingComposer,
    i1.$AuthsAnnotationComposer,
    $AuthsCreateCompanionBuilder,
    $AuthsUpdateCompanionBuilder,
    (i1.Auth, i1.$AuthsReferences),
    i1.Auth,
    i0.PrefetchHooks Function({bool userId})>;

class Auths extends i0.Table with i0.TableInfo<Auths, i1.Auth> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Auths(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'auths';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Auth> instance,
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
  i1.Auth map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Auth(
      userId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}user_id']),
      token: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}token']),
    );
  }

  @override
  Auths createAlias(String alias) {
    return Auths(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Auth extends i0.DataClass implements i0.Insertable<i1.Auth> {
  final String? userId;
  final String? token;
  const Auth({this.userId, this.token});
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

  i1.AuthsCompanion toCompanion(bool nullToAbsent) {
    return i1.AuthsCompanion(
      userId: userId == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(userId),
      token: token == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(token),
    );
  }

  factory Auth.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Auth(
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

  i1.Auth copyWith(
          {i0.Value<String?> userId = const i0.Value.absent(),
          i0.Value<String?> token = const i0.Value.absent()}) =>
      i1.Auth(
        userId: userId.present ? userId.value : this.userId,
        token: token.present ? token.value : this.token,
      );
  Auth copyWithCompanion(i1.AuthsCompanion data) {
    return Auth(
      userId: data.userId.present ? data.userId.value : this.userId,
      token: data.token.present ? data.token.value : this.token,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Auth(')
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
      (other is i1.Auth &&
          other.userId == this.userId &&
          other.token == this.token);
}

class AuthsCompanion extends i0.UpdateCompanion<i1.Auth> {
  final i0.Value<String?> userId;
  final i0.Value<String?> token;
  final i0.Value<int> rowid;
  const AuthsCompanion({
    this.userId = const i0.Value.absent(),
    this.token = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  AuthsCompanion.insert({
    this.userId = const i0.Value.absent(),
    this.token = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  static i0.Insertable<i1.Auth> custom({
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

  i1.AuthsCompanion copyWith(
      {i0.Value<String?>? userId,
      i0.Value<String?>? token,
      i0.Value<int>? rowid}) {
    return i1.AuthsCompanion(
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
    return (StringBuffer('AuthsCompanion(')
          ..write('userId: $userId, ')
          ..write('token: $token, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class UsersDrift extends i2.ModularAccessor {
  UsersDrift(i0.GeneratedDatabase db) : super(db);
  Future<int> createUser({required String userId, required String? name}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite => 'INSERT INTO users (id, name) VALUES (?1, ?2)',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO users (id, name) VALUES (\$1, \$2)',
      },
      variables: [i0.Variable<String>(userId), i0.Variable<String>(name)],
      updates: {users},
    );
  }

  Future<int> authUser({required String? userId, required String? token}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'INSERT INTO auths (user_id, token) VALUES (?1, ?2)',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO auths (user_id, token) VALUES (\$1, \$2)',
      },
      variables: [i0.Variable<String>(userId), i0.Variable<String>(token)],
      updates: {auths},
    );
  }

  Future<int> cleanAuthedUsers() {
    return customUpdate(
      'DELETE FROM auths',
      variables: [],
      updates: {auths},
      updateKind: i0.UpdateKind.delete,
    );
  }

  i0.Selectable<bool> userExistsAndAuthed(
      {required String userId, required String? token}) {
    return customSelect(
        switch (executor.dialect) {
          i0.SqlDialect.sqlite =>
            'SELECT COUNT(*) > 0 AS is_valid FROM users AS u INNER JOIN auths AS a ON u.id = a.user_id WHERE u.id = ?1 AND a.token = ?2',
          i0.SqlDialect.postgres ||
          _ =>
            'SELECT COUNT(*) > 0 AS is_valid FROM users AS u INNER JOIN auths AS a ON u.id = a.user_id WHERE u.id = \$1 AND a.token = \$2',
        },
        variables: [
          i0.Variable<String>(userId),
          i0.Variable<String>(token)
        ],
        readsFrom: {
          users,
          auths,
        }).map((i0.QueryRow row) => row.read<bool>('is_valid'));
  }

  i3.Users get users =>
      i2.ReadDatabaseContainer(attachedDatabase).resultSet<i3.Users>('users');
  i1.Auths get auths =>
      i2.ReadDatabaseContainer(attachedDatabase).resultSet<i1.Auths>('auths');
  i3.SharedUsersDrift get sharedUsersDrift =>
      this.accessor(i3.SharedUsersDrift.new);
}
