// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared_definitions/shared_nodes.drift.dart' as i1;
import 'package:backend/src/shared_definitions/node_types.dart' as i2;
import 'package:backend/src/shared_definitions/node_content.dart' as i3;
import 'dart:typed_data' as i4;
import 'package:drift/internal/modular.dart' as i5;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i6;

typedef $NodesCreateCompanionBuilder = i1.NodesCompanion Function({
  required String id,
  required i2.NodeTypes type,
  i0.Value<String?> serverTimeStamp,
  required String clientTimeStamp,
  required String userId,
  i0.Value<bool> isDeleted,
  i0.Value<i3.NodeContent> content,
  i0.Value<int> rowid,
});
typedef $NodesUpdateCompanionBuilder = i1.NodesCompanion Function({
  i0.Value<String> id,
  i0.Value<i2.NodeTypes> type,
  i0.Value<String?> serverTimeStamp,
  i0.Value<String> clientTimeStamp,
  i0.Value<String> userId,
  i0.Value<bool> isDeleted,
  i0.Value<i3.NodeContent> content,
  i0.Value<int> rowid,
});

final class $NodesReferences
    extends i0.BaseReferences<i0.GeneratedDatabase, i1.Nodes, i1.Node> {
  $NodesReferences(super.$_db, super.$_table, super.$_typedResult);

  static i6.Users _userIdTable(i0.GeneratedDatabase db) =>
      i5.ReadDatabaseContainer(db).resultSet<i6.Users>('users').createAlias(
          i0.$_aliasNameGenerator(
              i5.ReadDatabaseContainer(db).resultSet<i1.Nodes>('nodes').userId,
              i5.ReadDatabaseContainer(db).resultSet<i6.Users>('users').id));

  i6.$UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = i6
        .$UsersTableManager(
            $_db, i5.ReadDatabaseContainer($_db).resultSet<i6.Users>('users'))
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return i0.ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $NodesFilterComposer extends i0.Composer<i0.GeneratedDatabase, i1.Nodes> {
  $NodesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnWithTypeConverterFilters<i2.NodeTypes, i2.NodeTypes, String>
      get type => $composableBuilder(
          column: $table.type,
          builder: (column) => i0.ColumnWithTypeConverterFilters(column));

  i0.ColumnFilters<String> get serverTimeStamp => $composableBuilder(
      column: $table.serverTimeStamp,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get clientTimeStamp => $composableBuilder(
      column: $table.clientTimeStamp,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnWithTypeConverterFilters<i3.NodeContent, i3.NodeContent,
          i4.Uint8List>
      get content => $composableBuilder(
          column: $table.content,
          builder: (column) => i0.ColumnWithTypeConverterFilters(column));

  i6.$UsersFilterComposer get userId {
    final i6.$UsersFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable:
            i5.ReadDatabaseContainer($db).resultSet<i6.Users>('users'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i6.$UsersFilterComposer(
              $db: $db,
              $table:
                  i5.ReadDatabaseContainer($db).resultSet<i6.Users>('users'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $NodesOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Nodes> {
  $NodesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get serverTimeStamp => $composableBuilder(
      column: $table.serverTimeStamp,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get clientTimeStamp => $composableBuilder(
      column: $table.clientTimeStamp,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<i4.Uint8List> get content => $composableBuilder(
      column: $table.content, builder: (column) => i0.ColumnOrderings(column));

  i6.$UsersOrderingComposer get userId {
    final i6.$UsersOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable:
            i5.ReadDatabaseContainer($db).resultSet<i6.Users>('users'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i6.$UsersOrderingComposer(
              $db: $db,
              $table:
                  i5.ReadDatabaseContainer($db).resultSet<i6.Users>('users'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $NodesAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Nodes> {
  $NodesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<i2.NodeTypes, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  i0.GeneratedColumn<String> get serverTimeStamp => $composableBuilder(
      column: $table.serverTimeStamp, builder: (column) => column);

  i0.GeneratedColumn<String> get clientTimeStamp => $composableBuilder(
      column: $table.clientTimeStamp, builder: (column) => column);

  i0.GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<i3.NodeContent, i4.Uint8List>
      get content => $composableBuilder(
          column: $table.content, builder: (column) => column);

  i6.$UsersAnnotationComposer get userId {
    final i6.$UsersAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable:
            i5.ReadDatabaseContainer($db).resultSet<i6.Users>('users'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i6.$UsersAnnotationComposer(
              $db: $db,
              $table:
                  i5.ReadDatabaseContainer($db).resultSet<i6.Users>('users'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $NodesTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.Nodes,
    i1.Node,
    i1.$NodesFilterComposer,
    i1.$NodesOrderingComposer,
    i1.$NodesAnnotationComposer,
    $NodesCreateCompanionBuilder,
    $NodesUpdateCompanionBuilder,
    (i1.Node, i1.$NodesReferences),
    i1.Node,
    i0.PrefetchHooks Function({bool userId})> {
  $NodesTableManager(i0.GeneratedDatabase db, i1.Nodes table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$NodesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$NodesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$NodesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> id = const i0.Value.absent(),
            i0.Value<i2.NodeTypes> type = const i0.Value.absent(),
            i0.Value<String?> serverTimeStamp = const i0.Value.absent(),
            i0.Value<String> clientTimeStamp = const i0.Value.absent(),
            i0.Value<String> userId = const i0.Value.absent(),
            i0.Value<bool> isDeleted = const i0.Value.absent(),
            i0.Value<i3.NodeContent> content = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.NodesCompanion(
            id: id,
            type: type,
            serverTimeStamp: serverTimeStamp,
            clientTimeStamp: clientTimeStamp,
            userId: userId,
            isDeleted: isDeleted,
            content: content,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required i2.NodeTypes type,
            i0.Value<String?> serverTimeStamp = const i0.Value.absent(),
            required String clientTimeStamp,
            required String userId,
            i0.Value<bool> isDeleted = const i0.Value.absent(),
            i0.Value<i3.NodeContent> content = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.NodesCompanion.insert(
            id: id,
            type: type,
            serverTimeStamp: serverTimeStamp,
            clientTimeStamp: clientTimeStamp,
            userId: userId,
            isDeleted: isDeleted,
            content: content,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), i1.$NodesReferences(db, table, e)))
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
                    referencedTable: i1.$NodesReferences._userIdTable(db),
                    referencedColumn: i1.$NodesReferences._userIdTable(db).id,
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

typedef $NodesProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.Nodes,
    i1.Node,
    i1.$NodesFilterComposer,
    i1.$NodesOrderingComposer,
    i1.$NodesAnnotationComposer,
    $NodesCreateCompanionBuilder,
    $NodesUpdateCompanionBuilder,
    (i1.Node, i1.$NodesReferences),
    i1.Node,
    i0.PrefetchHooks Function({bool userId})>;

class Nodes extends i0.Table with i0.TableInfo<Nodes, i1.Node> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Nodes(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const i0.VerificationMeta _typeMeta =
      const i0.VerificationMeta('type');
  late final i0.GeneratedColumnWithTypeConverter<i2.NodeTypes, String> type =
      i0.GeneratedColumn<String>('type', aliasedName, false,
              type: i0.DriftSqlType.string,
              requiredDuringInsert: true,
              $customConstraints: 'NOT NULL')
          .withConverter<i2.NodeTypes>(i1.Nodes.$convertertype);
  static const i0.VerificationMeta _serverTimeStampMeta =
      const i0.VerificationMeta('serverTimeStamp');
  late final i0.GeneratedColumn<String> serverTimeStamp =
      i0.GeneratedColumn<String>('server_time_stamp', aliasedName, true,
          type: i0.DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const i0.VerificationMeta _clientTimeStampMeta =
      const i0.VerificationMeta('clientTimeStamp');
  late final i0.GeneratedColumn<String> clientTimeStamp =
      i0.GeneratedColumn<String>('client_time_stamp', aliasedName, false,
          type: i0.DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _userIdMeta =
      const i0.VerificationMeta('userId');
  late final i0.GeneratedColumn<String> userId = i0.GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES users(id)');
  static const i0.VerificationMeta _isDeletedMeta =
      const i0.VerificationMeta('isDeleted');
  late final i0.GeneratedColumn<bool> isDeleted = i0.GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: i0.DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'DEFAULT 0 NOT NULL',
      defaultValue: const i0.CustomExpression('0'));
  static const i0.VerificationMeta _contentMeta =
      const i0.VerificationMeta('content');
  late final i0.GeneratedColumnWithTypeConverter<i3.NodeContent, i4.Uint8List>
      content = i0.GeneratedColumn<i4.Uint8List>('content', aliasedName, true,
              type: i0.DriftSqlType.blob,
              requiredDuringInsert: false,
              $customConstraints: '')
          .withConverter<i3.NodeContent>(i1.Nodes.$convertercontent);
  @override
  List<i0.GeneratedColumn> get $columns =>
      [id, type, serverTimeStamp, clientTimeStamp, userId, isDeleted, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nodes';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Node> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    context.handle(_typeMeta, const i0.VerificationResult.success());
    if (data.containsKey('server_time_stamp')) {
      context.handle(
          _serverTimeStampMeta,
          serverTimeStamp.isAcceptableOrUnknown(
              data['server_time_stamp']!, _serverTimeStampMeta));
    }
    if (data.containsKey('client_time_stamp')) {
      context.handle(
          _clientTimeStampMeta,
          clientTimeStamp.isAcceptableOrUnknown(
              data['client_time_stamp']!, _clientTimeStampMeta));
    } else if (isInserting) {
      context.missing(_clientTimeStampMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    context.handle(_contentMeta, const i0.VerificationResult.success());
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Node map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Node(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: i1.Nodes.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}type'])!),
      serverTimeStamp: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}server_time_stamp']),
      clientTimeStamp: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}client_time_stamp'])!,
      userId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      content: i1.Nodes.$convertercontent.fromSql(attachedDatabase.typeMapping
          .read(i0.DriftSqlType.blob, data['${effectivePrefix}content'])),
    );
  }

  @override
  Nodes createAlias(String alias) {
    return Nodes(attachedDatabase, alias);
  }

  static i0.JsonTypeConverter2<i2.NodeTypes, String, String> $convertertype =
      const i0.EnumNameConverter<i2.NodeTypes>(i2.NodeTypes.values);
  static i0.JsonTypeConverter2<i3.NodeContent, i4.Uint8List?, Object?>
      $convertercontent = i3.NodeContent.binaryConverter;
  @override
  bool get dontWriteConstraints => true;
}

class Node extends i0.DataClass implements i0.Insertable<i1.Node> {
  final String id;
  final i2.NodeTypes type;
  final String? serverTimeStamp;
  final String clientTimeStamp;
  final String userId;
  final bool isDeleted;
  final i3.NodeContent content;
  const Node(
      {required this.id,
      required this.type,
      this.serverTimeStamp,
      required this.clientTimeStamp,
      required this.userId,
      required this.isDeleted,
      required this.content});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    {
      map['type'] = i0.Variable<String>(i1.Nodes.$convertertype.toSql(type));
    }
    if (!nullToAbsent || serverTimeStamp != null) {
      map['server_time_stamp'] = i0.Variable<String>(serverTimeStamp);
    }
    map['client_time_stamp'] = i0.Variable<String>(clientTimeStamp);
    map['user_id'] = i0.Variable<String>(userId);
    map['is_deleted'] = i0.Variable<bool>(isDeleted);
    {
      map['content'] =
          i0.Variable<i4.Uint8List>(i1.Nodes.$convertercontent.toSql(content));
    }
    return map;
  }

  i1.NodesCompanion toCompanion(bool nullToAbsent) {
    return i1.NodesCompanion(
      id: i0.Value(id),
      type: i0.Value(type),
      serverTimeStamp: serverTimeStamp == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(serverTimeStamp),
      clientTimeStamp: i0.Value(clientTimeStamp),
      userId: i0.Value(userId),
      isDeleted: i0.Value(isDeleted),
      content: i0.Value(content),
    );
  }

  factory Node.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Node(
      id: serializer.fromJson<String>(json['id']),
      type: i1.Nodes.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      serverTimeStamp: serializer.fromJson<String?>(json['server_time_stamp']),
      clientTimeStamp: serializer.fromJson<String>(json['client_time_stamp']),
      userId: serializer.fromJson<String>(json['user_id']),
      isDeleted: serializer.fromJson<bool>(json['is_deleted']),
      content: i1.Nodes.$convertercontent
          .fromJson(serializer.fromJson<Object?>(json['content'])),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(i1.Nodes.$convertertype.toJson(type)),
      'server_time_stamp': serializer.toJson<String?>(serverTimeStamp),
      'client_time_stamp': serializer.toJson<String>(clientTimeStamp),
      'user_id': serializer.toJson<String>(userId),
      'is_deleted': serializer.toJson<bool>(isDeleted),
      'content': serializer
          .toJson<Object?>(i1.Nodes.$convertercontent.toJson(content)),
    };
  }

  i1.Node copyWith(
          {String? id,
          i2.NodeTypes? type,
          i0.Value<String?> serverTimeStamp = const i0.Value.absent(),
          String? clientTimeStamp,
          String? userId,
          bool? isDeleted,
          i3.NodeContent? content}) =>
      i1.Node(
        id: id ?? this.id,
        type: type ?? this.type,
        serverTimeStamp: serverTimeStamp.present
            ? serverTimeStamp.value
            : this.serverTimeStamp,
        clientTimeStamp: clientTimeStamp ?? this.clientTimeStamp,
        userId: userId ?? this.userId,
        isDeleted: isDeleted ?? this.isDeleted,
        content: content ?? this.content,
      );
  Node copyWithCompanion(i1.NodesCompanion data) {
    return Node(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      serverTimeStamp: data.serverTimeStamp.present
          ? data.serverTimeStamp.value
          : this.serverTimeStamp,
      clientTimeStamp: data.clientTimeStamp.present
          ? data.clientTimeStamp.value
          : this.clientTimeStamp,
      userId: data.userId.present ? data.userId.value : this.userId,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Node(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('serverTimeStamp: $serverTimeStamp, ')
          ..write('clientTimeStamp: $clientTimeStamp, ')
          ..write('userId: $userId, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, type, serverTimeStamp, clientTimeStamp, userId, isDeleted, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Node &&
          other.id == this.id &&
          other.type == this.type &&
          other.serverTimeStamp == this.serverTimeStamp &&
          other.clientTimeStamp == this.clientTimeStamp &&
          other.userId == this.userId &&
          other.isDeleted == this.isDeleted &&
          other.content == this.content);
}

class NodesCompanion extends i0.UpdateCompanion<i1.Node> {
  final i0.Value<String> id;
  final i0.Value<i2.NodeTypes> type;
  final i0.Value<String?> serverTimeStamp;
  final i0.Value<String> clientTimeStamp;
  final i0.Value<String> userId;
  final i0.Value<bool> isDeleted;
  final i0.Value<i3.NodeContent> content;
  final i0.Value<int> rowid;
  const NodesCompanion({
    this.id = const i0.Value.absent(),
    this.type = const i0.Value.absent(),
    this.serverTimeStamp = const i0.Value.absent(),
    this.clientTimeStamp = const i0.Value.absent(),
    this.userId = const i0.Value.absent(),
    this.isDeleted = const i0.Value.absent(),
    this.content = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  NodesCompanion.insert({
    required String id,
    required i2.NodeTypes type,
    this.serverTimeStamp = const i0.Value.absent(),
    required String clientTimeStamp,
    required String userId,
    this.isDeleted = const i0.Value.absent(),
    this.content = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  })  : id = i0.Value(id),
        type = i0.Value(type),
        clientTimeStamp = i0.Value(clientTimeStamp),
        userId = i0.Value(userId);
  static i0.Insertable<i1.Node> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? type,
    i0.Expression<String>? serverTimeStamp,
    i0.Expression<String>? clientTimeStamp,
    i0.Expression<String>? userId,
    i0.Expression<bool>? isDeleted,
    i0.Expression<i4.Uint8List>? content,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (serverTimeStamp != null) 'server_time_stamp': serverTimeStamp,
      if (clientTimeStamp != null) 'client_time_stamp': clientTimeStamp,
      if (userId != null) 'user_id': userId,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (content != null) 'content': content,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.NodesCompanion copyWith(
      {i0.Value<String>? id,
      i0.Value<i2.NodeTypes>? type,
      i0.Value<String?>? serverTimeStamp,
      i0.Value<String>? clientTimeStamp,
      i0.Value<String>? userId,
      i0.Value<bool>? isDeleted,
      i0.Value<i3.NodeContent>? content,
      i0.Value<int>? rowid}) {
    return i1.NodesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
      clientTimeStamp: clientTimeStamp ?? this.clientTimeStamp,
      userId: userId ?? this.userId,
      isDeleted: isDeleted ?? this.isDeleted,
      content: content ?? this.content,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] =
          i0.Variable<String>(i1.Nodes.$convertertype.toSql(type.value));
    }
    if (serverTimeStamp.present) {
      map['server_time_stamp'] = i0.Variable<String>(serverTimeStamp.value);
    }
    if (clientTimeStamp.present) {
      map['client_time_stamp'] = i0.Variable<String>(clientTimeStamp.value);
    }
    if (userId.present) {
      map['user_id'] = i0.Variable<String>(userId.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = i0.Variable<bool>(isDeleted.value);
    }
    if (content.present) {
      map['content'] = i0.Variable<i4.Uint8List>(
          i1.Nodes.$convertercontent.toSql(content.value));
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NodesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('serverTimeStamp: $serverTimeStamp, ')
          ..write('clientTimeStamp: $clientTimeStamp, ')
          ..write('userId: $userId, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('content: $content, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class SharedNodesDrift extends i5.ModularAccessor {
  SharedNodesDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i1.Node> getNodeById({required String id}) {
    return customSelect(
        switch (executor.dialect) {
          i0.SqlDialect.sqlite => 'SELECT * FROM nodes WHERE id = ?1',
          i0.SqlDialect.postgres || _ => 'SELECT * FROM nodes WHERE id = \$1',
        },
        variables: [
          i0.Variable<String>(id)
        ],
        readsFrom: {
          nodes,
        }).asyncMap(nodes.mapFromRow);
  }

  Future<int> mutateNodeById(
      {required String? serverTimeStamp,
      required String clientTimeStamp,
      required String userId,
      required bool isDeleted,
      required i3.NodeContent content,
      required String id}) {
    return customUpdate(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'UPDATE nodes SET server_time_stamp = ?1, client_time_stamp = ?2, user_id = ?3, is_deleted = ?4, content = ?5 WHERE id = ?6',
        i0.SqlDialect.postgres ||
        _ =>
          'UPDATE nodes SET server_time_stamp = \$1, client_time_stamp = \$2, user_id = \$3, is_deleted = \$4, content = \$5 WHERE id = \$6',
      },
      variables: [
        i0.Variable<String>(serverTimeStamp),
        i0.Variable<String>(clientTimeStamp),
        i0.Variable<String>(userId),
        i0.Variable<bool>(isDeleted),
        i0.Variable<i4.Uint8List>(i1.Nodes.$convertercontent.toSql(content)),
        i0.Variable<String>(id)
      ],
      updates: {nodes},
      updateKind: i0.UpdateKind.update,
    );
  }

  Future<int> insertNode(
      {required String id,
      required i2.NodeTypes type,
      required String? serverTimeStamp,
      required String clientTimeStamp,
      required String userId,
      required bool isDeleted,
      required i3.NodeContent content}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'INSERT INTO nodes (id, type, server_time_stamp, client_time_stamp, user_id, is_deleted, content) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7)',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO nodes (id, type, server_time_stamp, client_time_stamp, user_id, is_deleted, content) VALUES (\$1, \$2, \$3, \$4, \$5, \$6, \$7)',
      },
      variables: [
        i0.Variable<String>(id),
        i0.Variable<String>(i1.Nodes.$convertertype.toSql(type)),
        i0.Variable<String>(serverTimeStamp),
        i0.Variable<String>(clientTimeStamp),
        i0.Variable<String>(userId),
        i0.Variable<bool>(isDeleted),
        i0.Variable<i4.Uint8List>(i1.Nodes.$convertercontent.toSql(content))
      ],
      updates: {nodes},
    );
  }

  i1.Nodes get nodes =>
      i5.ReadDatabaseContainer(attachedDatabase).resultSet<i1.Nodes>('nodes');
  i6.SharedUsersDrift get sharedUsersDrift =>
      this.accessor(i6.SharedUsersDrift.new);
}
