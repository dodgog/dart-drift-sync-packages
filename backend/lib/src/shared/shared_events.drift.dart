// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared/shared_events.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:backend/src/shared/shared_users.drift.dart' as i3;

typedef $EventsCreateCompanionBuilder = i1.EventsCompanion Function({
  required String id,
  required String type,
  required String clientId,
  i0.Value<String?> serverTimeStamp,
  required String clientTimeStamp,
  i0.Value<String?> content,
  i0.Value<int> rowid,
});
typedef $EventsUpdateCompanionBuilder = i1.EventsCompanion Function({
  i0.Value<String> id,
  i0.Value<String> type,
  i0.Value<String> clientId,
  i0.Value<String?> serverTimeStamp,
  i0.Value<String> clientTimeStamp,
  i0.Value<String?> content,
  i0.Value<int> rowid,
});

final class $EventsReferences
    extends i0.BaseReferences<i0.GeneratedDatabase, i1.Events, i1.Event> {
  $EventsReferences(super.$_db, super.$_table, super.$_typedResult);

  static i3.Clients _clientIdTable(i0.GeneratedDatabase db) =>
      i2.ReadDatabaseContainer(db).resultSet<i3.Clients>('clients').createAlias(
          i0.$_aliasNameGenerator(
              i2.ReadDatabaseContainer(db)
                  .resultSet<i1.Events>('events')
                  .clientId,
              i2.ReadDatabaseContainer(db)
                  .resultSet<i3.Clients>('clients')
                  .id));

  i3.$ClientsProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = i3
        .$ClientsTableManager($_db,
            i2.ReadDatabaseContainer($_db).resultSet<i3.Clients>('clients'))
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

  i0.ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get serverTimeStamp => $composableBuilder(
      column: $table.serverTimeStamp,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get clientTimeStamp => $composableBuilder(
      column: $table.clientTimeStamp,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => i0.ColumnFilters(column));

  i3.$ClientsFilterComposer get clientId {
    final i3.$ClientsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i3.Clients>('clients'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i3.$ClientsFilterComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i3.Clients>('clients'),
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

  i0.ColumnOrderings<String> get serverTimeStamp => $composableBuilder(
      column: $table.serverTimeStamp,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get clientTimeStamp => $composableBuilder(
      column: $table.clientTimeStamp,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => i0.ColumnOrderings(column));

  i3.$ClientsOrderingComposer get clientId {
    final i3.$ClientsOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i3.Clients>('clients'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i3.$ClientsOrderingComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i3.Clients>('clients'),
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

  i0.GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  i0.GeneratedColumn<String> get serverTimeStamp => $composableBuilder(
      column: $table.serverTimeStamp, builder: (column) => column);

  i0.GeneratedColumn<String> get clientTimeStamp => $composableBuilder(
      column: $table.clientTimeStamp, builder: (column) => column);

  i0.GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  i3.$ClientsAnnotationComposer get clientId {
    final i3.$ClientsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i3.Clients>('clients'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i3.$ClientsAnnotationComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i3.Clients>('clients'),
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
            i0.Value<String> type = const i0.Value.absent(),
            i0.Value<String> clientId = const i0.Value.absent(),
            i0.Value<String?> serverTimeStamp = const i0.Value.absent(),
            i0.Value<String> clientTimeStamp = const i0.Value.absent(),
            i0.Value<String?> content = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.EventsCompanion(
            id: id,
            type: type,
            clientId: clientId,
            serverTimeStamp: serverTimeStamp,
            clientTimeStamp: clientTimeStamp,
            content: content,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String type,
            required String clientId,
            i0.Value<String?> serverTimeStamp = const i0.Value.absent(),
            required String clientTimeStamp,
            i0.Value<String?> content = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.EventsCompanion.insert(
            id: id,
            type: type,
            clientId: clientId,
            serverTimeStamp: serverTimeStamp,
            clientTimeStamp: clientTimeStamp,
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
  late final i0.GeneratedColumn<String> type = i0.GeneratedColumn<String>(
      'type', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _clientIdMeta =
      const i0.VerificationMeta('clientId');
  late final i0.GeneratedColumn<String> clientId = i0.GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES clients(id)');
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
  static const i0.VerificationMeta _contentMeta =
      const i0.VerificationMeta('content');
  late final i0.GeneratedColumn<String> content = i0.GeneratedColumn<String>(
      'content', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<i0.GeneratedColumn> get $columns =>
      [id, type, clientId, serverTimeStamp, clientTimeStamp, content];
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
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
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
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
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
      type: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}type'])!,
      clientId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}client_id'])!,
      serverTimeStamp: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}server_time_stamp']),
      clientTimeStamp: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}client_time_stamp'])!,
      content: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}content']),
    );
  }

  @override
  Events createAlias(String alias) {
    return Events(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Event extends i0.DataClass implements i0.Insertable<i1.Event> {
  final String id;
  final String type;
  final String clientId;
  final String? serverTimeStamp;

  /// TODO: dialect aware date https://drift.simonbinder.eu/sql_api/types/#dialect-awareness
  final String clientTimeStamp;

  /// time should be in iso8601
  final String? content;
  const Event(
      {required this.id,
      required this.type,
      required this.clientId,
      this.serverTimeStamp,
      required this.clientTimeStamp,
      this.content});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    map['type'] = i0.Variable<String>(type);
    map['client_id'] = i0.Variable<String>(clientId);
    if (!nullToAbsent || serverTimeStamp != null) {
      map['server_time_stamp'] = i0.Variable<String>(serverTimeStamp);
    }
    map['client_time_stamp'] = i0.Variable<String>(clientTimeStamp);
    if (!nullToAbsent || content != null) {
      map['content'] = i0.Variable<String>(content);
    }
    return map;
  }

  i1.EventsCompanion toCompanion(bool nullToAbsent) {
    return i1.EventsCompanion(
      id: i0.Value(id),
      type: i0.Value(type),
      clientId: i0.Value(clientId),
      serverTimeStamp: serverTimeStamp == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(serverTimeStamp),
      clientTimeStamp: i0.Value(clientTimeStamp),
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
      type: serializer.fromJson<String>(json['type']),
      clientId: serializer.fromJson<String>(json['client_id']),
      serverTimeStamp: serializer.fromJson<String?>(json['server_time_stamp']),
      clientTimeStamp: serializer.fromJson<String>(json['client_time_stamp']),
      content: serializer.fromJson<String?>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'client_id': serializer.toJson<String>(clientId),
      'server_time_stamp': serializer.toJson<String?>(serverTimeStamp),
      'client_time_stamp': serializer.toJson<String>(clientTimeStamp),
      'content': serializer.toJson<String?>(content),
    };
  }

  i1.Event copyWith(
          {String? id,
          String? type,
          String? clientId,
          i0.Value<String?> serverTimeStamp = const i0.Value.absent(),
          String? clientTimeStamp,
          i0.Value<String?> content = const i0.Value.absent()}) =>
      i1.Event(
        id: id ?? this.id,
        type: type ?? this.type,
        clientId: clientId ?? this.clientId,
        serverTimeStamp: serverTimeStamp.present
            ? serverTimeStamp.value
            : this.serverTimeStamp,
        clientTimeStamp: clientTimeStamp ?? this.clientTimeStamp,
        content: content.present ? content.value : this.content,
      );
  Event copyWithCompanion(i1.EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      serverTimeStamp: data.serverTimeStamp.present
          ? data.serverTimeStamp.value
          : this.serverTimeStamp,
      clientTimeStamp: data.clientTimeStamp.present
          ? data.clientTimeStamp.value
          : this.clientTimeStamp,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('clientId: $clientId, ')
          ..write('serverTimeStamp: $serverTimeStamp, ')
          ..write('clientTimeStamp: $clientTimeStamp, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, type, clientId, serverTimeStamp, clientTimeStamp, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Event &&
          other.id == this.id &&
          other.type == this.type &&
          other.clientId == this.clientId &&
          other.serverTimeStamp == this.serverTimeStamp &&
          other.clientTimeStamp == this.clientTimeStamp &&
          other.content == this.content);
}

class EventsCompanion extends i0.UpdateCompanion<i1.Event> {
  final i0.Value<String> id;
  final i0.Value<String> type;
  final i0.Value<String> clientId;
  final i0.Value<String?> serverTimeStamp;
  final i0.Value<String> clientTimeStamp;
  final i0.Value<String?> content;
  final i0.Value<int> rowid;
  const EventsCompanion({
    this.id = const i0.Value.absent(),
    this.type = const i0.Value.absent(),
    this.clientId = const i0.Value.absent(),
    this.serverTimeStamp = const i0.Value.absent(),
    this.clientTimeStamp = const i0.Value.absent(),
    this.content = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  EventsCompanion.insert({
    required String id,
    required String type,
    required String clientId,
    this.serverTimeStamp = const i0.Value.absent(),
    required String clientTimeStamp,
    this.content = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  })  : id = i0.Value(id),
        type = i0.Value(type),
        clientId = i0.Value(clientId),
        clientTimeStamp = i0.Value(clientTimeStamp);
  static i0.Insertable<i1.Event> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? type,
    i0.Expression<String>? clientId,
    i0.Expression<String>? serverTimeStamp,
    i0.Expression<String>? clientTimeStamp,
    i0.Expression<String>? content,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (clientId != null) 'client_id': clientId,
      if (serverTimeStamp != null) 'server_time_stamp': serverTimeStamp,
      if (clientTimeStamp != null) 'client_time_stamp': clientTimeStamp,
      if (content != null) 'content': content,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.EventsCompanion copyWith(
      {i0.Value<String>? id,
      i0.Value<String>? type,
      i0.Value<String>? clientId,
      i0.Value<String?>? serverTimeStamp,
      i0.Value<String>? clientTimeStamp,
      i0.Value<String?>? content,
      i0.Value<int>? rowid}) {
    return i1.EventsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      clientId: clientId ?? this.clientId,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
      clientTimeStamp: clientTimeStamp ?? this.clientTimeStamp,
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
      map['type'] = i0.Variable<String>(type.value);
    }
    if (clientId.present) {
      map['client_id'] = i0.Variable<String>(clientId.value);
    }
    if (serverTimeStamp.present) {
      map['server_time_stamp'] = i0.Variable<String>(serverTimeStamp.value);
    }
    if (clientTimeStamp.present) {
      map['client_time_stamp'] = i0.Variable<String>(clientTimeStamp.value);
    }
    if (content.present) {
      map['content'] = i0.Variable<String>(content.value);
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
          ..write('clientId: $clientId, ')
          ..write('serverTimeStamp: $serverTimeStamp, ')
          ..write('clientTimeStamp: $clientTimeStamp, ')
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

class SharedEventsDrift extends i2.ModularAccessor {
  SharedEventsDrift(i0.GeneratedDatabase db) : super(db);
  i3.SharedUsersDrift get sharedUsersDrift =>
      this.accessor(i3.SharedUsersDrift.new);
}
