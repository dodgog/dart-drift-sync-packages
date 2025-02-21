// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i1;
import 'package:backend/src/shared_definitions/event_types.dart' as i2;
import 'package:backend/src/shared_definitions/event_content.dart' as i3;
import 'dart:typed_data' as i4;
import 'package:drift/internal/modular.dart' as i5;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i6;

typedef $EventsCreateCompanionBuilder = i1.EventsCompanion Function({
  required String id,
  required i2.EventTypes type,
  i0.Value<String?> targetNodeId,
  required String clientId,
  required String timestamp,
  i0.Value<i3.EventContent?> content,
  i0.Value<int> rowid,
});
typedef $EventsUpdateCompanionBuilder = i1.EventsCompanion Function({
  i0.Value<String> id,
  i0.Value<i2.EventTypes> type,
  i0.Value<String?> targetNodeId,
  i0.Value<String> clientId,
  i0.Value<String> timestamp,
  i0.Value<i3.EventContent?> content,
  i0.Value<int> rowid,
});

final class $EventsReferences
    extends i0.BaseReferences<i0.GeneratedDatabase, i1.Events, i1.Event> {
  $EventsReferences(super.$_db, super.$_table, super.$_typedResult);

  static i6.Clients _clientIdTable(i0.GeneratedDatabase db) =>
      i5.ReadDatabaseContainer(db).resultSet<i6.Clients>('clients').createAlias(
          i0.$_aliasNameGenerator(
              i5.ReadDatabaseContainer(db)
                  .resultSet<i1.Events>('events')
                  .clientId,
              i5.ReadDatabaseContainer(db)
                  .resultSet<i6.Clients>('clients')
                  .id));

  i6.$ClientsProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = i6
        .$ClientsTableManager($_db,
            i5.ReadDatabaseContainer($_db).resultSet<i6.Clients>('clients'))
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return i0.ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $EventsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Events> {
  $EventsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnWithTypeConverterFilters<i2.EventTypes, i2.EventTypes, String>
      get type => $composableBuilder(
          column: $table.type,
          builder: (column) => i0.ColumnWithTypeConverterFilters(column));

  i0.ColumnFilters<String> get targetNodeId => $composableBuilder(
      column: $table.targetNodeId,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnWithTypeConverterFilters<i3.EventContent?, i3.EventContent,
          i4.Uint8List>
      get content => $composableBuilder(
          column: $table.content,
          builder: (column) => i0.ColumnWithTypeConverterFilters(column));

  i6.$ClientsFilterComposer get clientId {
    final i6.$ClientsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable:
            i5.ReadDatabaseContainer($db).resultSet<i6.Clients>('clients'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i6.$ClientsFilterComposer(
              $db: $db,
              $table: i5.ReadDatabaseContainer($db)
                  .resultSet<i6.Clients>('clients'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $EventsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Events> {
  $EventsOrderingComposer({
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

  i0.ColumnOrderings<String> get targetNodeId => $composableBuilder(
      column: $table.targetNodeId,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get timestamp => $composableBuilder(
      column: $table.timestamp,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<i4.Uint8List> get content => $composableBuilder(
      column: $table.content, builder: (column) => i0.ColumnOrderings(column));

  i6.$ClientsOrderingComposer get clientId {
    final i6.$ClientsOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable:
            i5.ReadDatabaseContainer($db).resultSet<i6.Clients>('clients'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i6.$ClientsOrderingComposer(
              $db: $db,
              $table: i5.ReadDatabaseContainer($db)
                  .resultSet<i6.Clients>('clients'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $EventsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Events> {
  $EventsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<i2.EventTypes, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  i0.GeneratedColumn<String> get targetNodeId => $composableBuilder(
      column: $table.targetNodeId, builder: (column) => column);

  i0.GeneratedColumn<String> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<i3.EventContent?, i4.Uint8List>
      get content => $composableBuilder(
          column: $table.content, builder: (column) => column);

  i6.$ClientsAnnotationComposer get clientId {
    final i6.$ClientsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable:
            i5.ReadDatabaseContainer($db).resultSet<i6.Clients>('clients'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i6.$ClientsAnnotationComposer(
              $db: $db,
              $table: i5.ReadDatabaseContainer($db)
                  .resultSet<i6.Clients>('clients'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $EventsTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.Events,
    i1.Event,
    i1.$EventsFilterComposer,
    i1.$EventsOrderingComposer,
    i1.$EventsAnnotationComposer,
    $EventsCreateCompanionBuilder,
    $EventsUpdateCompanionBuilder,
    (i1.Event, i1.$EventsReferences),
    i1.Event,
    i0.PrefetchHooks Function({bool clientId})> {
  $EventsTableManager(i0.GeneratedDatabase db, i1.Events table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$EventsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$EventsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$EventsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> id = const i0.Value.absent(),
            i0.Value<i2.EventTypes> type = const i0.Value.absent(),
            i0.Value<String?> targetNodeId = const i0.Value.absent(),
            i0.Value<String> clientId = const i0.Value.absent(),
            i0.Value<String> timestamp = const i0.Value.absent(),
            i0.Value<i3.EventContent?> content = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.EventsCompanion(
            id: id,
            type: type,
            targetNodeId: targetNodeId,
            clientId: clientId,
            timestamp: timestamp,
            content: content,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required i2.EventTypes type,
            i0.Value<String?> targetNodeId = const i0.Value.absent(),
            required String clientId,
            required String timestamp,
            i0.Value<i3.EventContent?> content = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.EventsCompanion.insert(
            id: id,
            type: type,
            targetNodeId: targetNodeId,
            clientId: clientId,
            timestamp: timestamp,
            content: content,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), i1.$EventsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({clientId = false}) {
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
                if (clientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clientId,
                    referencedTable: i1.$EventsReferences._clientIdTable(db),
                    referencedColumn:
                        i1.$EventsReferences._clientIdTable(db).id,
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

typedef $EventsProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.Events,
    i1.Event,
    i1.$EventsFilterComposer,
    i1.$EventsOrderingComposer,
    i1.$EventsAnnotationComposer,
    $EventsCreateCompanionBuilder,
    $EventsUpdateCompanionBuilder,
    (i1.Event, i1.$EventsReferences),
    i1.Event,
    i0.PrefetchHooks Function({bool clientId})>;

class Events extends i0.Table with i0.TableInfo<Events, i1.Event> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Events(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const i0.VerificationMeta _typeMeta =
      const i0.VerificationMeta('type');
  late final i0.GeneratedColumnWithTypeConverter<i2.EventTypes, String> type =
      i0.GeneratedColumn<String>('type', aliasedName, false,
              type: i0.DriftSqlType.string,
              requiredDuringInsert: true,
              $customConstraints: 'NOT NULL')
          .withConverter<i2.EventTypes>(i1.Events.$convertertype);
  static const i0.VerificationMeta _targetNodeIdMeta =
      const i0.VerificationMeta('targetNodeId');
  late final i0.GeneratedColumn<String> targetNodeId =
      i0.GeneratedColumn<String>('target_node_id', aliasedName, true,
          type: i0.DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const i0.VerificationMeta _clientIdMeta =
      const i0.VerificationMeta('clientId');
  late final i0.GeneratedColumn<String> clientId = i0.GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES clients(id)');
  static const i0.VerificationMeta _timestampMeta =
      const i0.VerificationMeta('timestamp');
  late final i0.GeneratedColumn<String> timestamp = i0.GeneratedColumn<String>(
      'timestamp', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _contentMeta =
      const i0.VerificationMeta('content');
  late final i0.GeneratedColumnWithTypeConverter<i3.EventContent?, i4.Uint8List>
      content = i0.GeneratedColumn<i4.Uint8List>('content', aliasedName, true,
              type: i0.DriftSqlType.blob,
              requiredDuringInsert: false,
              $customConstraints: '')
          .withConverter<i3.EventContent?>(i1.Events.$convertercontentn);
  @override
  List<i0.GeneratedColumn> get $columns =>
      [id, type, targetNodeId, clientId, timestamp, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Event> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    context.handle(_typeMeta, const i0.VerificationResult.success());
    if (data.containsKey('target_node_id')) {
      context.handle(
          _targetNodeIdMeta,
          targetNodeId.isAcceptableOrUnknown(
              data['target_node_id']!, _targetNodeIdMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    context.handle(_contentMeta, const i0.VerificationResult.success());
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Event(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: i1.Events.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}type'])!),
      targetNodeId: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}target_node_id']),
      clientId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}client_id'])!,
      timestamp: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}timestamp'])!,
      content: i1.Events.$convertercontentn.fromSql(attachedDatabase.typeMapping
          .read(i0.DriftSqlType.blob, data['${effectivePrefix}content'])),
    );
  }

  @override
  Events createAlias(String alias) {
    return Events(attachedDatabase, alias);
  }

  static i0.JsonTypeConverter2<i2.EventTypes, String, String> $convertertype =
      const i0.EnumNameConverter<i2.EventTypes>(i2.EventTypes.values);
  static i0.JsonTypeConverter2<i3.EventContent, i4.Uint8List, dynamic>
      $convertercontent = i3.EventContent.binaryConverter;
  static i0.JsonTypeConverter2<i3.EventContent?, i4.Uint8List?, dynamic>
      $convertercontentn = i0.JsonTypeConverter2.asNullable($convertercontent);
  @override
  bool get dontWriteConstraints => true;
}

class Event extends i0.DataClass implements i0.Insertable<i1.Event> {
  final String id;
  final i2.EventTypes type;
  final String? targetNodeId;

  /// doesn't always reference an existing node, so references is omitted
  final String clientId;
  final String timestamp;
  final i3.EventContent? content;
  const Event(
      {required this.id,
      required this.type,
      this.targetNodeId,
      required this.clientId,
      required this.timestamp,
      this.content});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    {
      map['type'] = i0.Variable<String>(i1.Events.$convertertype.toSql(type));
    }
    if (!nullToAbsent || targetNodeId != null) {
      map['target_node_id'] = i0.Variable<String>(targetNodeId);
    }
    map['client_id'] = i0.Variable<String>(clientId);
    map['timestamp'] = i0.Variable<String>(timestamp);
    if (!nullToAbsent || content != null) {
      map['content'] = i0.Variable<i4.Uint8List>(
          i1.Events.$convertercontentn.toSql(content));
    }
    return map;
  }

  i1.EventsCompanion toCompanion(bool nullToAbsent) {
    return i1.EventsCompanion(
      id: i0.Value(id),
      type: i0.Value(type),
      targetNodeId: targetNodeId == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(targetNodeId),
      clientId: i0.Value(clientId),
      timestamp: i0.Value(timestamp),
      content: content == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(content),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<String>(json['id']),
      type: i1.Events.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      targetNodeId: serializer.fromJson<String?>(json['target_node_id']),
      clientId: serializer.fromJson<String>(json['client_id']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
      content: i1.Events.$convertercontentn
          .fromJson(serializer.fromJson<dynamic>(json['content'])),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(i1.Events.$convertertype.toJson(type)),
      'target_node_id': serializer.toJson<String?>(targetNodeId),
      'client_id': serializer.toJson<String>(clientId),
      'timestamp': serializer.toJson<String>(timestamp),
      'content': serializer
          .toJson<dynamic>(i1.Events.$convertercontentn.toJson(content)),
    };
  }

  i1.Event copyWith(
          {String? id,
          i2.EventTypes? type,
          i0.Value<String?> targetNodeId = const i0.Value.absent(),
          String? clientId,
          String? timestamp,
          i0.Value<i3.EventContent?> content = const i0.Value.absent()}) =>
      i1.Event(
        id: id ?? this.id,
        type: type ?? this.type,
        targetNodeId:
            targetNodeId.present ? targetNodeId.value : this.targetNodeId,
        clientId: clientId ?? this.clientId,
        timestamp: timestamp ?? this.timestamp,
        content: content.present ? content.value : this.content,
      );
  Event copyWithCompanion(i1.EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      targetNodeId: data.targetNodeId.present
          ? data.targetNodeId.value
          : this.targetNodeId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('targetNodeId: $targetNodeId, ')
          ..write('clientId: $clientId, ')
          ..write('timestamp: $timestamp, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, targetNodeId, clientId, timestamp, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Event &&
          other.id == this.id &&
          other.type == this.type &&
          other.targetNodeId == this.targetNodeId &&
          other.clientId == this.clientId &&
          other.timestamp == this.timestamp &&
          other.content == this.content);
}

class EventsCompanion extends i0.UpdateCompanion<i1.Event> {
  final i0.Value<String> id;
  final i0.Value<i2.EventTypes> type;
  final i0.Value<String?> targetNodeId;
  final i0.Value<String> clientId;
  final i0.Value<String> timestamp;
  final i0.Value<i3.EventContent?> content;
  final i0.Value<int> rowid;
  const EventsCompanion({
    this.id = const i0.Value.absent(),
    this.type = const i0.Value.absent(),
    this.targetNodeId = const i0.Value.absent(),
    this.clientId = const i0.Value.absent(),
    this.timestamp = const i0.Value.absent(),
    this.content = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  EventsCompanion.insert({
    required String id,
    required i2.EventTypes type,
    this.targetNodeId = const i0.Value.absent(),
    required String clientId,
    required String timestamp,
    this.content = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  })  : id = i0.Value(id),
        type = i0.Value(type),
        clientId = i0.Value(clientId),
        timestamp = i0.Value(timestamp);
  static i0.Insertable<i1.Event> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? type,
    i0.Expression<String>? targetNodeId,
    i0.Expression<String>? clientId,
    i0.Expression<String>? timestamp,
    i0.Expression<i4.Uint8List>? content,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (targetNodeId != null) 'target_node_id': targetNodeId,
      if (clientId != null) 'client_id': clientId,
      if (timestamp != null) 'timestamp': timestamp,
      if (content != null) 'content': content,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.EventsCompanion copyWith(
      {i0.Value<String>? id,
      i0.Value<i2.EventTypes>? type,
      i0.Value<String?>? targetNodeId,
      i0.Value<String>? clientId,
      i0.Value<String>? timestamp,
      i0.Value<i3.EventContent?>? content,
      i0.Value<int>? rowid}) {
    return i1.EventsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      targetNodeId: targetNodeId ?? this.targetNodeId,
      clientId: clientId ?? this.clientId,
      timestamp: timestamp ?? this.timestamp,
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
          i0.Variable<String>(i1.Events.$convertertype.toSql(type.value));
    }
    if (targetNodeId.present) {
      map['target_node_id'] = i0.Variable<String>(targetNodeId.value);
    }
    if (clientId.present) {
      map['client_id'] = i0.Variable<String>(clientId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = i0.Variable<String>(timestamp.value);
    }
    if (content.present) {
      map['content'] = i0.Variable<i4.Uint8List>(
          i1.Events.$convertercontentn.toSql(content.value));
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('targetNodeId: $targetNodeId, ')
          ..write('clientId: $clientId, ')
          ..write('timestamp: $timestamp, ')
          ..write('content: $content, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

i0.Index get eventClientIdIndex => i0.Index.byDialect('event_client_id_index', {
      i0.SqlDialect.sqlite:
          'CREATE INDEX event_client_id_index ON events (client_id)',
      i0.SqlDialect.postgres:
          'CREATE INDEX event_client_id_index ON events (client_id)',
    });

class SharedEventsDrift extends i5.ModularAccessor {
  SharedEventsDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i1.Event> getEvents() {
    return customSelect('SELECT * FROM events', variables: [], readsFrom: {
      events,
    }).asyncMap(events.mapFromRow);
  }

  i1.Events get events =>
      i5.ReadDatabaseContainer(attachedDatabase).resultSet<i1.Events>('events');
  i6.SharedUsersDrift get sharedUsersDrift =>
      this.accessor(i6.SharedUsersDrift.new);
}
