// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:backend/src/shared_definitions/shared_attributes.drift.dart'
    as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:backend/src/shared_definitions/shared_events.drift.dart' as i3;

typedef $AttributesCreateCompanionBuilder = i1.AttributesCompanion Function({
  required String entityId,
  i0.Value<String?> attribute,
  i0.Value<String?> value,
  required String timestamp,
  i0.Value<int> rowid,
});
typedef $AttributesUpdateCompanionBuilder = i1.AttributesCompanion Function({
  i0.Value<String> entityId,
  i0.Value<String?> attribute,
  i0.Value<String?> value,
  i0.Value<String> timestamp,
  i0.Value<int> rowid,
});

class $AttributesFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Attributes> {
  $AttributesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get attribute => $composableBuilder(
      column: $table.attribute, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => i0.ColumnFilters(column));
}

class $AttributesOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Attributes> {
  $AttributesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
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
}

class $AttributesAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Attributes> {
  $AttributesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  i0.GeneratedColumn<String> get attribute =>
      $composableBuilder(column: $table.attribute, builder: (column) => column);

  i0.GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  i0.GeneratedColumn<String> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $AttributesTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.Attributes,
    i1.Attribute,
    i1.$AttributesFilterComposer,
    i1.$AttributesOrderingComposer,
    i1.$AttributesAnnotationComposer,
    $AttributesCreateCompanionBuilder,
    $AttributesUpdateCompanionBuilder,
    (
      i1.Attribute,
      i0.BaseReferences<i0.GeneratedDatabase, i1.Attributes, i1.Attribute>
    ),
    i1.Attribute,
    i0.PrefetchHooks Function()> {
  $AttributesTableManager(i0.GeneratedDatabase db, i1.Attributes table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$AttributesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$AttributesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$AttributesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> entityId = const i0.Value.absent(),
            i0.Value<String?> attribute = const i0.Value.absent(),
            i0.Value<String?> value = const i0.Value.absent(),
            i0.Value<String> timestamp = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.AttributesCompanion(
            entityId: entityId,
            attribute: attribute,
            value: value,
            timestamp: timestamp,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String entityId,
            i0.Value<String?> attribute = const i0.Value.absent(),
            i0.Value<String?> value = const i0.Value.absent(),
            required String timestamp,
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.AttributesCompanion.insert(
            entityId: entityId,
            attribute: attribute,
            value: value,
            timestamp: timestamp,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $AttributesProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.Attributes,
    i1.Attribute,
    i1.$AttributesFilterComposer,
    i1.$AttributesOrderingComposer,
    i1.$AttributesAnnotationComposer,
    $AttributesCreateCompanionBuilder,
    $AttributesUpdateCompanionBuilder,
    (
      i1.Attribute,
      i0.BaseReferences<i0.GeneratedDatabase, i1.Attributes, i1.Attribute>
    ),
    i1.Attribute,
    i0.PrefetchHooks Function()>;

class Attributes extends i0.Table with i0.TableInfo<Attributes, i1.Attribute> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Attributes(this.attachedDatabase, [this._alias]);
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
      'attribute', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _valueMeta =
      const i0.VerificationMeta('value');
  late final i0.GeneratedColumn<String> value = i0.GeneratedColumn<String>(
      'value', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _timestampMeta =
      const i0.VerificationMeta('timestamp');
  late final i0.GeneratedColumn<String> timestamp = i0.GeneratedColumn<String>(
      'timestamp', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<i0.GeneratedColumn> get $columns =>
      [entityId, attribute, value, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attributes';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Attribute> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('attribute')) {
      context.handle(_attributeMeta,
          attribute.isAcceptableOrUnknown(data['attribute']!, _attributeMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
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
  Set<i0.GeneratedColumn> get $primaryKey => const {};
  @override
  i1.Attribute map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Attribute(
      entityId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      attribute: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}attribute']),
      value: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}value']),
      timestamp: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  Attributes createAlias(String alias) {
    return Attributes(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Attribute extends i0.DataClass implements i0.Insertable<i1.Attribute> {
  final String entityId;

  /// for now means node
  final String? attribute;
  final String? value;

  /// for now string
  final String timestamp;
  const Attribute(
      {required this.entityId,
      this.attribute,
      this.value,
      required this.timestamp});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['entity_id'] = i0.Variable<String>(entityId);
    if (!nullToAbsent || attribute != null) {
      map['attribute'] = i0.Variable<String>(attribute);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = i0.Variable<String>(value);
    }
    map['timestamp'] = i0.Variable<String>(timestamp);
    return map;
  }

  i1.AttributesCompanion toCompanion(bool nullToAbsent) {
    return i1.AttributesCompanion(
      entityId: i0.Value(entityId),
      attribute: attribute == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(attribute),
      value: value == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(value),
      timestamp: i0.Value(timestamp),
    );
  }

  factory Attribute.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Attribute(
      entityId: serializer.fromJson<String>(json['entity_id']),
      attribute: serializer.fromJson<String?>(json['attribute']),
      value: serializer.fromJson<String?>(json['value']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entity_id': serializer.toJson<String>(entityId),
      'attribute': serializer.toJson<String?>(attribute),
      'value': serializer.toJson<String?>(value),
      'timestamp': serializer.toJson<String>(timestamp),
    };
  }

  i1.Attribute copyWith(
          {String? entityId,
          i0.Value<String?> attribute = const i0.Value.absent(),
          i0.Value<String?> value = const i0.Value.absent(),
          String? timestamp}) =>
      i1.Attribute(
        entityId: entityId ?? this.entityId,
        attribute: attribute.present ? attribute.value : this.attribute,
        value: value.present ? value.value : this.value,
        timestamp: timestamp ?? this.timestamp,
      );
  Attribute copyWithCompanion(i1.AttributesCompanion data) {
    return Attribute(
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      attribute: data.attribute.present ? data.attribute.value : this.attribute,
      value: data.value.present ? data.value.value : this.value,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attribute(')
          ..write('entityId: $entityId, ')
          ..write('attribute: $attribute, ')
          ..write('value: $value, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entityId, attribute, value, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Attribute &&
          other.entityId == this.entityId &&
          other.attribute == this.attribute &&
          other.value == this.value &&
          other.timestamp == this.timestamp);
}

class AttributesCompanion extends i0.UpdateCompanion<i1.Attribute> {
  final i0.Value<String> entityId;
  final i0.Value<String?> attribute;
  final i0.Value<String?> value;
  final i0.Value<String> timestamp;
  final i0.Value<int> rowid;
  const AttributesCompanion({
    this.entityId = const i0.Value.absent(),
    this.attribute = const i0.Value.absent(),
    this.value = const i0.Value.absent(),
    this.timestamp = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  AttributesCompanion.insert({
    required String entityId,
    this.attribute = const i0.Value.absent(),
    this.value = const i0.Value.absent(),
    required String timestamp,
    this.rowid = const i0.Value.absent(),
  })  : entityId = i0.Value(entityId),
        timestamp = i0.Value(timestamp);
  static i0.Insertable<i1.Attribute> custom({
    i0.Expression<String>? entityId,
    i0.Expression<String>? attribute,
    i0.Expression<String>? value,
    i0.Expression<String>? timestamp,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (entityId != null) 'entity_id': entityId,
      if (attribute != null) 'attribute': attribute,
      if (value != null) 'value': value,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.AttributesCompanion copyWith(
      {i0.Value<String>? entityId,
      i0.Value<String?>? attribute,
      i0.Value<String?>? value,
      i0.Value<String>? timestamp,
      i0.Value<int>? rowid}) {
    return i1.AttributesCompanion(
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
    return (StringBuffer('AttributesCompanion(')
          ..write('entityId: $entityId, ')
          ..write('attribute: $attribute, ')
          ..write('value: $value, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

i0.Index get attributesEntityIdAttribute =>
    i0.Index.byDialect('attributes_entity_id_attribute', {
      i0.SqlDialect.sqlite:
          'CREATE UNIQUE INDEX attributes_entity_id_attribute ON attributes (entity_id, attribute)',
      i0.SqlDialect.postgres:
          'CREATE UNIQUE INDEX attributes_entity_id_attribute ON attributes (entity_id, attribute)',
    });

class SharedAttributesDrift extends i2.ModularAccessor {
  SharedAttributesDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i1.Attribute> getAttributes() {
    return customSelect('SELECT * FROM attributes', variables: [], readsFrom: {
      attributes,
    }).asyncMap(attributes.mapFromRow);
  }

  Future<int> insertEventIntoAttributes(
      {required String entityId,
      required String? attribute,
      required String? value,
      required String timestamp}) {
    return customInsert(
      switch (executor.dialect) {
        i0.SqlDialect.sqlite =>
          'INSERT INTO attributes (entity_id, attribute, value, timestamp) VALUES (?1, ?2, ?3, ?4) ON CONFLICT (entity_id, attribute) DO UPDATE SET value = excluded.value, timestamp = excluded.timestamp WHERE excluded.timestamp > attributes.timestamp',
        i0.SqlDialect.postgres ||
        _ =>
          'INSERT INTO attributes (entity_id, attribute, value, timestamp) VALUES (\$1, \$2, \$3, \$4) ON CONFLICT (entity_id, attribute) DO UPDATE SET value = excluded.value, timestamp = excluded.timestamp WHERE excluded.timestamp > attributes.timestamp',
      },
      variables: [
        i0.Variable<String>(entityId),
        i0.Variable<String>(attribute),
        i0.Variable<String>(value),
        i0.Variable<String>(timestamp)
      ],
      updates: {attributes},
    );
  }

  Future<int> cleanAttributesTable() {
    return customUpdate(
      'DELETE FROM attributes',
      variables: [],
      updates: {attributes},
      updateKind: i0.UpdateKind.delete,
    );
  }

  Future<int> insertAllEventsIntoAttributes() {
    return customInsert(
      'INSERT OR REPLACE INTO attributes (entity_id, attribute, value, timestamp) SELECT e1.entity_id, e1.attribute, e1.value, e1.timestamp FROM events AS e1 LEFT OUTER JOIN events AS e2 ON e1.entity_id = e2.entity_id AND e1.attribute = e2.attribute AND e2.timestamp > e1.timestamp WHERE e2.entity_id IS NULL AND NOT EXISTS (SELECT 1 FROM attributes AS a WHERE a.entity_id = e1.entity_id AND a.attribute = e1.attribute AND a.timestamp > e1.timestamp)',
      variables: [],
      updates: {attributes},
    );
  }

  i1.Attributes get attributes => i2.ReadDatabaseContainer(attachedDatabase)
      .resultSet<i1.Attributes>('attributes');
  i3.Events get events =>
      i2.ReadDatabaseContainer(attachedDatabase).resultSet<i3.Events>('events');
  i3.SharedEventsDrift get sharedEventsDrift =>
      this.accessor(i3.SharedEventsDrift.new);
}
