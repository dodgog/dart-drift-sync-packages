// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/client/client_definitions/events.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:backend/src/client/client_definitions/users.drift.dart' as i3;
import 'package:backend/client.drift.dart' as i4;
import 'package:backend/src/shared_definitions/shared_users.drift.dart' as i5;

typedef $EventsCreateCompanionBuilder = i1.EventsCompanion Function({
  required String id,
  required String clientId,
  required String entityId,
  required String attribute,
  required String value,
  required String timestamp,
  i0.Value<int> rowid,
});
typedef $EventsUpdateCompanionBuilder = i1.EventsCompanion Function({
  i0.Value<String> id,
  i0.Value<String> clientId,
  i0.Value<String> entityId,
  i0.Value<String> attribute,
  i0.Value<String> value,
  i0.Value<String> timestamp,
  i0.Value<int> rowid,
});

final class $EventsReferences
    extends i0.BaseReferences<i0.GeneratedDatabase, i1.Events, i1.Event> {
  $EventsReferences(super.$_db, super.$_table, super.$_typedResult);

  static i5.Clients _clientIdTable(i0.GeneratedDatabase db) =>
      i2.ReadDatabaseContainer(db).resultSet<i5.Clients>('clients').createAlias(
          i0.$_aliasNameGenerator(
              i2.ReadDatabaseContainer(db)
                  .resultSet<i1.Events>('events')
                  .clientId,
              i2.ReadDatabaseContainer(db)
                  .resultSet<i5.Clients>('clients')
                  .id));

  i5.$ClientsProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = i5
        .$ClientsTableManager($_db,
            i2.ReadDatabaseContainer($_db).resultSet<i5.Clients>('clients'))
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

  i0.ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get attribute => $composableBuilder(
      column: $table.attribute, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => i0.ColumnFilters(column));

  i5.$ClientsFilterComposer get clientId {
    final i5.$ClientsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i5.Clients>('clients'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i5.$ClientsFilterComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i5.Clients>('clients'),
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

  i0.ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get attribute => $composableBuilder(
      column: $table.attribute,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get timestamp => $composableBuilder(
      column: $table.timestamp,
      builder: (column) => i0.ColumnOrderings(column));

  i5.$ClientsOrderingComposer get clientId {
    final i5.$ClientsOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i5.Clients>('clients'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i5.$ClientsOrderingComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i5.Clients>('clients'),
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

  i0.GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  i0.GeneratedColumn<String> get attribute =>
      $composableBuilder(column: $table.attribute, builder: (column) => column);

  i0.GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  i0.GeneratedColumn<String> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  i5.$ClientsAnnotationComposer get clientId {
    final i5.$ClientsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i5.Clients>('clients'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i5.$ClientsAnnotationComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i5.Clients>('clients'),
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
            i0.Value<String> clientId = const i0.Value.absent(),
            i0.Value<String> entityId = const i0.Value.absent(),
            i0.Value<String> attribute = const i0.Value.absent(),
            i0.Value<String> value = const i0.Value.absent(),
            i0.Value<String> timestamp = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.EventsCompanion(
            id: id,
            clientId: clientId,
            entityId: entityId,
            attribute: attribute,
            value: value,
            timestamp: timestamp,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String clientId,
            required String entityId,
            required String attribute,
            required String value,
            required String timestamp,
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.EventsCompanion.insert(
            id: id,
            clientId: clientId,
            entityId: entityId,
            attribute: attribute,
            value: value,
            timestamp: timestamp,
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
  static const i0.VerificationMeta _clientIdMeta =
      const i0.VerificationMeta('clientId');
  late final i0.GeneratedColumn<String> clientId = i0.GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES clients(id)');
  static const i0.VerificationMeta _entityIdMeta =
      const i0.VerificationMeta('entityId');
  late final i0.GeneratedColumn<String> entityId = i0.GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _attributeMeta =
      const i0.VerificationMeta('attribute');
  late final i0.GeneratedColumn<String> attribute = i0.GeneratedColumn<String>(
      'attribute', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _valueMeta =
      const i0.VerificationMeta('value');
  late final i0.GeneratedColumn<String> value = i0.GeneratedColumn<String>(
      'value', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _timestampMeta =
      const i0.VerificationMeta('timestamp');
  late final i0.GeneratedColumn<String> timestamp = i0.GeneratedColumn<String>(
      'timestamp', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<i0.GeneratedColumn> get $columns =>
      [id, clientId, entityId, attribute, value, timestamp];
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
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('attribute')) {
      context.handle(_attributeMeta,
          attribute.isAcceptableOrUnknown(data['attribute']!, _attributeMeta));
    } else if (isInserting) {
      context.missing(_attributeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
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
      clientId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}client_id'])!,
      entityId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      attribute: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}attribute'])!,
      value: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}value'])!,
      timestamp: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}timestamp'])!,
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
  final String clientId;

  /// todo: potentially also add the user_id list to specify user groups in the future
  /// part of the event which exactly matches the attributes table
  final String entityId;

  /// doesn't always reference an existing node, so references is omitted
  final String attribute;
  final String value;
  final String timestamp;
  const Event(
      {required this.id,
      required this.clientId,
      required this.entityId,
      required this.attribute,
      required this.value,
      required this.timestamp});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    map['client_id'] = i0.Variable<String>(clientId);
    map['entity_id'] = i0.Variable<String>(entityId);
    map['attribute'] = i0.Variable<String>(attribute);
    map['value'] = i0.Variable<String>(value);
    map['timestamp'] = i0.Variable<String>(timestamp);
    return map;
  }

  i1.EventsCompanion toCompanion(bool nullToAbsent) {
    return i1.EventsCompanion(
      id: i0.Value(id),
      clientId: i0.Value(clientId),
      entityId: i0.Value(entityId),
      attribute: i0.Value(attribute),
      value: i0.Value(value),
      timestamp: i0.Value(timestamp),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['client_id']),
      entityId: serializer.fromJson<String>(json['entity_id']),
      attribute: serializer.fromJson<String>(json['attribute']),
      value: serializer.fromJson<String>(json['value']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'client_id': serializer.toJson<String>(clientId),
      'entity_id': serializer.toJson<String>(entityId),
      'attribute': serializer.toJson<String>(attribute),
      'value': serializer.toJson<String>(value),
      'timestamp': serializer.toJson<String>(timestamp),
    };
  }

  i1.Event copyWith(
          {String? id,
          String? clientId,
          String? entityId,
          String? attribute,
          String? value,
          String? timestamp}) =>
      i1.Event(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        entityId: entityId ?? this.entityId,
        attribute: attribute ?? this.attribute,
        value: value ?? this.value,
        timestamp: timestamp ?? this.timestamp,
      );
  Event copyWithCompanion(i1.EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      attribute: data.attribute.present ? data.attribute.value : this.attribute,
      value: data.value.present ? data.value.value : this.value,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('entityId: $entityId, ')
          ..write('attribute: $attribute, ')
          ..write('value: $value, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, clientId, entityId, attribute, value, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Event &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.entityId == this.entityId &&
          other.attribute == this.attribute &&
          other.value == this.value &&
          other.timestamp == this.timestamp);
}

class EventsCompanion extends i0.UpdateCompanion<i1.Event> {
  final i0.Value<String> id;
  final i0.Value<String> clientId;
  final i0.Value<String> entityId;
  final i0.Value<String> attribute;
  final i0.Value<String> value;
  final i0.Value<String> timestamp;
  final i0.Value<int> rowid;
  const EventsCompanion({
    this.id = const i0.Value.absent(),
    this.clientId = const i0.Value.absent(),
    this.entityId = const i0.Value.absent(),
    this.attribute = const i0.Value.absent(),
    this.value = const i0.Value.absent(),
    this.timestamp = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  EventsCompanion.insert({
    required String id,
    required String clientId,
    required String entityId,
    required String attribute,
    required String value,
    required String timestamp,
    this.rowid = const i0.Value.absent(),
  })  : id = i0.Value(id),
        clientId = i0.Value(clientId),
        entityId = i0.Value(entityId),
        attribute = i0.Value(attribute),
        value = i0.Value(value),
        timestamp = i0.Value(timestamp);
  static i0.Insertable<i1.Event> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? clientId,
    i0.Expression<String>? entityId,
    i0.Expression<String>? attribute,
    i0.Expression<String>? value,
    i0.Expression<String>? timestamp,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (entityId != null) 'entity_id': entityId,
      if (attribute != null) 'attribute': attribute,
      if (value != null) 'value': value,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.EventsCompanion copyWith(
      {i0.Value<String>? id,
      i0.Value<String>? clientId,
      i0.Value<String>? entityId,
      i0.Value<String>? attribute,
      i0.Value<String>? value,
      i0.Value<String>? timestamp,
      i0.Value<int>? rowid}) {
    return i1.EventsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      entityId: entityId ?? this.entityId,
      attribute: attribute ?? this.attribute,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = i0.Variable<String>(clientId.value);
    }
    if (entityId.present) {
      map['entity_id'] = i0.Variable<String>(entityId.value);
    }
    if (attribute.present) {
      map['attribute'] = i0.Variable<String>(attribute.value);
    }
    if (value.present) {
      map['value'] = i0.Variable<String>(value.value);
    }
    if (timestamp.present) {
      map['timestamp'] = i0.Variable<String>(timestamp.value);
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
          ..write('clientId: $clientId, ')
          ..write('entityId: $entityId, ')
          ..write('attribute: $attribute, ')
          ..write('value: $value, ')
          ..write('timestamp: $timestamp, ')
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

class EventsDrift extends i2.ModularAccessor {
  EventsDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i1.Event> getEvents() {
    return customSelect('SELECT * FROM events', variables: [], readsFrom: {
      events,
    }).asyncMap(events.mapFromRow);
  }

  Future<int> insertEvent(
      {required String id,
      required String clientId,
      required String entityId,
      required String attribute,
      required String value,
      required String timestamp}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'INSERT INTO events (id, client_id, entity_id, attribute, value, timestamp) VALUES (?1, ?2, ?3, ?4, ?5, ?6) ON CONFLICT (id) DO NOTHING',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO events (id, client_id, entity_id, attribute, value, timestamp) VALUES (\$1, \$2, \$3, \$4, \$5, \$6) ON CONFLICT (id) DO NOTHING',
      },
      variables: [
        i0.Variable<String>(id),
        i0.Variable<String>(clientId),
        i0.Variable<String>(entityId),
        i0.Variable<String>(attribute),
        i0.Variable<String>(value),
        i0.Variable<String>(timestamp)
      ],
      updates: {events},
    );
  }

  i0.Selectable<i1.Event> getLocalEventsToPush() {
    return customSelect(
        'SELECT e.* FROM events AS e WHERE e.timestamp > (SELECT COALESCE(last_server_issued_timestamp, hlc_absolute_zero) FROM config LIMIT 1)',
        variables: [],
        readsFrom: {
          events,
          config,
        }).asyncMap(events.mapFromRow);
  }

  i1.Events get events =>
      i2.ReadDatabaseContainer(attachedDatabase).resultSet<i1.Events>('events');
  i3.Config get config =>
      i2.ReadDatabaseContainer(attachedDatabase).resultSet<i3.Config>('config');
  i4.ClientDrift get clientDrift => this.accessor(i4.ClientDrift.new);
}
