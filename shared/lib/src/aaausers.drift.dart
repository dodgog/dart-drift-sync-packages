// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:shared/src/aaausers.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;

typedef $AaausersCreateCompanionBuilder = i1.AaausersCompanion Function({
  required String id,
  i0.Value<String?> name,
  i0.Value<int> rowid,
});
typedef $AaausersUpdateCompanionBuilder = i1.AaausersCompanion Function({
  i0.Value<String> id,
  i0.Value<String?> name,
  i0.Value<int> rowid,
});

final class $AaausersReferences
    extends i0.BaseReferences<i0.GeneratedDatabase, i1.Aaausers, i1.Aaauser> {
  $AaausersReferences(super.$_db, super.$_table, super.$_typedResult);

  static i0.MultiTypedResultKey<i1.Clients, List<i1.Client>> _clientsRefsTable(
          i0.GeneratedDatabase db) =>
      i0.MultiTypedResultKey.fromTable(
          i2.ReadDatabaseContainer(db).resultSet<i1.Clients>('clients'),
          aliasName: i0.$_aliasNameGenerator(
              i2.ReadDatabaseContainer(db)
                  .resultSet<i1.Aaausers>('aaausers')
                  .id,
              i2.ReadDatabaseContainer(db)
                  .resultSet<i1.Clients>('clients')
                  .userId));

  i1.$ClientsProcessedTableManager get clientsRefs {
    final manager = i1
        .$ClientsTableManager($_db,
            i2.ReadDatabaseContainer($_db).resultSet<i1.Clients>('clients'))
        .filter((f) => f.userId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_clientsRefsTable($_db));
    return i0.ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $AaausersFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Aaausers> {
  $AaausersFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => i0.ColumnFilters(column));

  i0.Expression<bool> clientsRefs(
      i0.Expression<bool> Function(i1.$ClientsFilterComposer f) f) {
    final i1.$ClientsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i1.Clients>('clients'),
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i1.$ClientsFilterComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i1.Clients>('clients'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $AaausersOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Aaausers> {
  $AaausersOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => i0.ColumnOrderings(column));
}

class $AaausersAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Aaausers> {
  $AaausersAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  i0.Expression<T> clientsRefs<T extends Object>(
      i0.Expression<T> Function(i1.$ClientsAnnotationComposer a) f) {
    final i1.$ClientsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i1.Clients>('clients'),
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i1.$ClientsAnnotationComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i1.Clients>('clients'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $AaausersTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.Aaausers,
    i1.Aaauser,
    i1.$AaausersFilterComposer,
    i1.$AaausersOrderingComposer,
    i1.$AaausersAnnotationComposer,
    $AaausersCreateCompanionBuilder,
    $AaausersUpdateCompanionBuilder,
    (i1.Aaauser, i1.$AaausersReferences),
    i1.Aaauser,
    i0.PrefetchHooks Function({bool clientsRefs})> {
  $AaausersTableManager(i0.GeneratedDatabase db, i1.Aaausers table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$AaausersFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$AaausersOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$AaausersAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> id = const i0.Value.absent(),
            i0.Value<String?> name = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.AaausersCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            i0.Value<String?> name = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.AaausersCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), i1.$AaausersReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({clientsRefs = false}) {
            return i0.PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (clientsRefs)
                  i2.ReadDatabaseContainer(db).resultSet<i1.Clients>('clients')
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (clientsRefs)
                    await i0.$_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            i1.$AaausersReferences._clientsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            i1.$AaausersReferences(db, table, p0).clientsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $AaausersProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.Aaausers,
    i1.Aaauser,
    i1.$AaausersFilterComposer,
    i1.$AaausersOrderingComposer,
    i1.$AaausersAnnotationComposer,
    $AaausersCreateCompanionBuilder,
    $AaausersUpdateCompanionBuilder,
    (i1.Aaauser, i1.$AaausersReferences),
    i1.Aaauser,
    i0.PrefetchHooks Function({bool clientsRefs})>;
typedef $ClientsCreateCompanionBuilder = i1.ClientsCompanion Function({
  required String id,
  i0.Value<String?> userId,
  i0.Value<int> rowid,
});
typedef $ClientsUpdateCompanionBuilder = i1.ClientsCompanion Function({
  i0.Value<String> id,
  i0.Value<String?> userId,
  i0.Value<int> rowid,
});

final class $ClientsReferences
    extends i0.BaseReferences<i0.GeneratedDatabase, i1.Clients, i1.Client> {
  $ClientsReferences(super.$_db, super.$_table, super.$_typedResult);

  static i1.Aaausers _userIdTable(i0.GeneratedDatabase db) =>
      i2.ReadDatabaseContainer(db)
          .resultSet<i1.Aaausers>('aaausers')
          .createAlias(i0.$_aliasNameGenerator(
              i2.ReadDatabaseContainer(db)
                  .resultSet<i1.Clients>('clients')
                  .userId,
              i2.ReadDatabaseContainer(db)
                  .resultSet<i1.Aaausers>('aaausers')
                  .id));

  i1.$AaausersProcessedTableManager? get userId {
    if ($_item.userId == null) return null;
    final manager = i1
        .$AaausersTableManager($_db,
            i2.ReadDatabaseContainer($_db).resultSet<i1.Aaausers>('aaausers'))
        .filter((f) => f.id($_item.userId!));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return i0.ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $ClientsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Clients> {
  $ClientsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i1.$AaausersFilterComposer get userId {
    final i1.$AaausersFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i1.Aaausers>('aaausers'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i1.$AaausersFilterComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i1.Aaausers>('aaausers'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $ClientsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Clients> {
  $ClientsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i1.$AaausersOrderingComposer get userId {
    final i1.$AaausersOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i1.Aaausers>('aaausers'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i1.$AaausersOrderingComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i1.Aaausers>('aaausers'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $ClientsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Clients> {
  $ClientsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i1.$AaausersAnnotationComposer get userId {
    final i1.$AaausersAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i1.Aaausers>('aaausers'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i1.$AaausersAnnotationComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i1.Aaausers>('aaausers'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $ClientsTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.Clients,
    i1.Client,
    i1.$ClientsFilterComposer,
    i1.$ClientsOrderingComposer,
    i1.$ClientsAnnotationComposer,
    $ClientsCreateCompanionBuilder,
    $ClientsUpdateCompanionBuilder,
    (i1.Client, i1.$ClientsReferences),
    i1.Client,
    i0.PrefetchHooks Function({bool userId})> {
  $ClientsTableManager(i0.GeneratedDatabase db, i1.Clients table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$ClientsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$ClientsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$ClientsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> id = const i0.Value.absent(),
            i0.Value<String?> userId = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.ClientsCompanion(
            id: id,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            i0.Value<String?> userId = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.ClientsCompanion.insert(
            id: id,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), i1.$ClientsReferences(db, table, e)))
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
                    referencedTable: i1.$ClientsReferences._userIdTable(db),
                    referencedColumn: i1.$ClientsReferences._userIdTable(db).id,
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

typedef $ClientsProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.Clients,
    i1.Client,
    i1.$ClientsFilterComposer,
    i1.$ClientsOrderingComposer,
    i1.$ClientsAnnotationComposer,
    $ClientsCreateCompanionBuilder,
    $ClientsUpdateCompanionBuilder,
    (i1.Client, i1.$ClientsReferences),
    i1.Client,
    i0.PrefetchHooks Function({bool userId})>;

class Aaausers extends i0.Table with i0.TableInfo<Aaausers, i1.Aaauser> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Aaausers(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _nameMeta =
      const i0.VerificationMeta('name');
  late final i0.GeneratedColumn<String> name = i0.GeneratedColumn<String>(
      'name', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<i0.GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'aaausers';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Aaauser> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => const {};
  @override
  i1.Aaauser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Aaauser(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}name']),
    );
  }

  @override
  Aaausers createAlias(String alias) {
    return Aaausers(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Aaauser extends i0.DataClass implements i0.Insertable<i1.Aaauser> {
  final String id;
  final String? name;
  const Aaauser({required this.id, this.name});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = i0.Variable<String>(name);
    }
    return map;
  }

  i1.AaausersCompanion toCompanion(bool nullToAbsent) {
    return i1.AaausersCompanion(
      id: i0.Value(id),
      name: name == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(name),
    );
  }

  factory Aaauser.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Aaauser(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
    };
  }

  i1.Aaauser copyWith(
          {String? id, i0.Value<String?> name = const i0.Value.absent()}) =>
      i1.Aaauser(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
      );
  Aaauser copyWithCompanion(i1.AaausersCompanion data) {
    return Aaauser(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Aaauser(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Aaauser && other.id == this.id && other.name == this.name);
}

class AaausersCompanion extends i0.UpdateCompanion<i1.Aaauser> {
  final i0.Value<String> id;
  final i0.Value<String?> name;
  final i0.Value<int> rowid;
  const AaausersCompanion({
    this.id = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  AaausersCompanion.insert({
    required String id,
    this.name = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  }) : id = i0.Value(id);
  static i0.Insertable<i1.Aaauser> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? name,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.AaausersCompanion copyWith(
      {i0.Value<String>? id, i0.Value<String?>? name, i0.Value<int>? rowid}) {
    return i1.AaausersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = i0.Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AaausersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Clients extends i0.Table with i0.TableInfo<Clients, i1.Client> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Clients(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _userIdMeta =
      const i0.VerificationMeta('userId');
  late final i0.GeneratedColumn<String> userId = i0.GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES aaausers(id)');
  @override
  List<i0.GeneratedColumn> get $columns => [id, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Client> instance,
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
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => const {};
  @override
  i1.Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Client(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}user_id']),
    );
  }

  @override
  Clients createAlias(String alias) {
    return Clients(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Client extends i0.DataClass implements i0.Insertable<i1.Client> {
  final String id;
  final String? userId;
  const Client({required this.id, this.userId});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = i0.Variable<String>(userId);
    }
    return map;
  }

  i1.ClientsCompanion toCompanion(bool nullToAbsent) {
    return i1.ClientsCompanion(
      id: i0.Value(id),
      userId: userId == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(userId),
    );
  }

  factory Client.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['user_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<String?>(userId),
    };
  }

  i1.Client copyWith(
          {String? id, i0.Value<String?> userId = const i0.Value.absent()}) =>
      i1.Client(
        id: id ?? this.id,
        userId: userId.present ? userId.value : this.userId,
      );
  Client copyWithCompanion(i1.ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Client &&
          other.id == this.id &&
          other.userId == this.userId);
}

class ClientsCompanion extends i0.UpdateCompanion<i1.Client> {
  final i0.Value<String> id;
  final i0.Value<String?> userId;
  final i0.Value<int> rowid;
  const ClientsCompanion({
    this.id = const i0.Value.absent(),
    this.userId = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  ClientsCompanion.insert({
    required String id,
    this.userId = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  }) : id = i0.Value(id);
  static i0.Insertable<i1.Client> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? userId,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.ClientsCompanion copyWith(
      {i0.Value<String>? id, i0.Value<String?>? userId, i0.Value<int>? rowid}) {
    return i1.ClientsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
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
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}
