// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/test.drift.dart' as i1;
import 'package:backend/src/converters.dart' as i2;
import 'dart:typed_data' as i3;
import 'package:drift/internal/modular.dart' as i4;

typedef $UsersCreateCompanionBuilder = i1.UsersCompanion Function({
  i0.Value<int> id,
  i0.Value<String?> name,
  i0.Value<i2.Preferences?> preferences,
});
typedef $UsersUpdateCompanionBuilder = i1.UsersCompanion Function({
  i0.Value<int> id,
  i0.Value<String?> name,
  i0.Value<i2.Preferences?> preferences,
});

class $UsersFilterComposer extends i0.Composer<i0.GeneratedDatabase, i1.Users> {
  $UsersFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnWithTypeConverterFilters<i2.Preferences?, i2.Preferences,
          i3.Uint8List>
      get preferences => $composableBuilder(
          column: $table.preferences,
          builder: (column) => i0.ColumnWithTypeConverterFilters(column));
}

class $UsersOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Users> {
  $UsersOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<i3.Uint8List> get preferences => $composableBuilder(
      column: $table.preferences,
      builder: (column) => i0.ColumnOrderings(column));
}

class $UsersAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Users> {
  $UsersAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<i2.Preferences?, i3.Uint8List>
      get preferences => $composableBuilder(
          column: $table.preferences, builder: (column) => column);
}

class $UsersTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.Users,
    i1.User,
    i1.$UsersFilterComposer,
    i1.$UsersOrderingComposer,
    i1.$UsersAnnotationComposer,
    $UsersCreateCompanionBuilder,
    $UsersUpdateCompanionBuilder,
    (i1.User, i0.BaseReferences<i0.GeneratedDatabase, i1.Users, i1.User>),
    i1.User,
    i0.PrefetchHooks Function()> {
  $UsersTableManager(i0.GeneratedDatabase db, i1.Users table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$UsersFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$UsersOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$UsersAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<int> id = const i0.Value.absent(),
            i0.Value<String?> name = const i0.Value.absent(),
            i0.Value<i2.Preferences?> preferences = const i0.Value.absent(),
          }) =>
              i1.UsersCompanion(
            id: id,
            name: name,
            preferences: preferences,
          ),
          createCompanionCallback: ({
            i0.Value<int> id = const i0.Value.absent(),
            i0.Value<String?> name = const i0.Value.absent(),
            i0.Value<i2.Preferences?> preferences = const i0.Value.absent(),
          }) =>
              i1.UsersCompanion.insert(
            id: id,
            name: name,
            preferences: preferences,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $UsersProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.Users,
    i1.User,
    i1.$UsersFilterComposer,
    i1.$UsersOrderingComposer,
    i1.$UsersAnnotationComposer,
    $UsersCreateCompanionBuilder,
    $UsersUpdateCompanionBuilder,
    (i1.User, i0.BaseReferences<i0.GeneratedDatabase, i1.Users, i1.User>),
    i1.User,
    i0.PrefetchHooks Function()>;

class Users extends i0.Table with i0.TableInfo<Users, i1.User> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Users(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: i0.DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const i0.VerificationMeta _nameMeta =
      const i0.VerificationMeta('name');
  late final i0.GeneratedColumn<String> name = i0.GeneratedColumn<String>(
      'name', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _preferencesMeta =
      const i0.VerificationMeta('preferences');
  late final i0.GeneratedColumnWithTypeConverter<i2.Preferences?, i3.Uint8List>
      preferences = i0.GeneratedColumn<i3.Uint8List>(
              'preferences', aliasedName, true,
              type: i0.DriftSqlType.blob,
              requiredDuringInsert: false,
              $customConstraints: '')
          .withConverter<i2.Preferences?>(i1.Users.$converterpreferencesn);
  @override
  List<i0.GeneratedColumn> get $columns => [id, name, preferences];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.User> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    context.handle(_preferencesMeta, const i0.VerificationResult.success());
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.User(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}name']),
      preferences: i1.Users.$converterpreferencesn.fromSql(attachedDatabase
          .typeMapping
          .read(i0.DriftSqlType.blob, data['${effectivePrefix}preferences'])),
    );
  }

  @override
  Users createAlias(String alias) {
    return Users(attachedDatabase, alias);
  }

  static i0.JsonTypeConverter2<i2.Preferences, i3.Uint8List, Object?>
      $converterpreferences = i2.Preferences.converter;
  static i0.JsonTypeConverter2<i2.Preferences?, i3.Uint8List?, Object?>
      $converterpreferencesn =
      i0.JsonTypeConverter2.asNullable($converterpreferences);
  @override
  bool get dontWriteConstraints => true;
}

class User extends i0.DataClass implements i0.Insertable<i1.User> {
  final int id;
  final String? name;
  final i2.Preferences? preferences;
  const User({required this.id, this.name, this.preferences});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = i0.Variable<String>(name);
    }
    if (!nullToAbsent || preferences != null) {
      map['preferences'] = i0.Variable<i3.Uint8List>(
          i1.Users.$converterpreferencesn.toSql(preferences));
    }
    return map;
  }

  i1.UsersCompanion toCompanion(bool nullToAbsent) {
    return i1.UsersCompanion(
      id: i0.Value(id),
      name: name == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(name),
      preferences: preferences == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(preferences),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      preferences: i1.Users.$converterpreferencesn
          .fromJson(serializer.fromJson<Object?>(json['preferences'])),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'preferences': serializer
          .toJson<Object?>(i1.Users.$converterpreferencesn.toJson(preferences)),
    };
  }

  i1.User copyWith(
          {int? id,
          i0.Value<String?> name = const i0.Value.absent(),
          i0.Value<i2.Preferences?> preferences = const i0.Value.absent()}) =>
      i1.User(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        preferences: preferences.present ? preferences.value : this.preferences,
      );
  User copyWithCompanion(i1.UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      preferences:
          data.preferences.present ? data.preferences.value : this.preferences,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('preferences: $preferences')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, preferences);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.User &&
          other.id == this.id &&
          other.name == this.name &&
          other.preferences == this.preferences);
}

class UsersCompanion extends i0.UpdateCompanion<i1.User> {
  final i0.Value<int> id;
  final i0.Value<String?> name;
  final i0.Value<i2.Preferences?> preferences;
  const UsersCompanion({
    this.id = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.preferences = const i0.Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.preferences = const i0.Value.absent(),
  });
  static i0.Insertable<i1.User> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? name,
    i0.Expression<i3.Uint8List>? preferences,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (preferences != null) 'preferences': preferences,
    });
  }

  i1.UsersCompanion copyWith(
      {i0.Value<int>? id,
      i0.Value<String?>? name,
      i0.Value<i2.Preferences?>? preferences}) {
    return i1.UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      preferences: preferences ?? this.preferences,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = i0.Variable<String>(name.value);
    }
    if (preferences.present) {
      map['preferences'] = i0.Variable<i3.Uint8List>(
          i1.Users.$converterpreferencesn.toSql(preferences.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('preferences: $preferences')
          ..write(')'))
        .toString();
  }
}

class TestDrift extends i4.ModularAccessor {
  TestDrift(i0.GeneratedDatabase db) : super(db);
  Future<int> insertUser(
      {required int id, required i2.Preferences? preferences}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'INSERT INTO users (id, preferences) VALUES (?1, ?2)',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO users (id, preferences) VALUES (\$1, \$2)',
      },
      variables: [
        i0.Variable<int>(id),
        i0.Variable<i3.Uint8List>(
            i1.Users.$converterpreferencesn.toSql(preferences))
      ],
      updates: {users},
    );
  }

  i0.Selectable<i1.User> selectUsers() {
    return customSelect('SELECT * FROM users', variables: [], readsFrom: {
      users,
    }).asyncMap(users.mapFromRow);
  }

  i1.Users get users =>
      i4.ReadDatabaseContainer(attachedDatabase).resultSet<i1.Users>('users');
}
