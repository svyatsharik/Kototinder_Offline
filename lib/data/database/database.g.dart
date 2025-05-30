// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CatsTable extends Cats with TableInfo<$CatsTable, CatData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
    'breed',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _temperamentMeta = const VerificationMeta(
    'temperament',
  );
  @override
  late final GeneratedColumn<String> temperament = GeneratedColumn<String>(
    'temperament',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    imageUrl,
    breed,
    description,
    temperament,
    origin,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cats';
  @override
  VerificationContext validateIntegrity(
    Insertable<CatData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
        _breedMeta,
        breed.isAcceptableOrUnknown(data['breed']!, _breedMeta),
      );
    } else if (isInserting) {
      context.missing(_breedMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('temperament')) {
      context.handle(
        _temperamentMeta,
        temperament.isAcceptableOrUnknown(
          data['temperament']!,
          _temperamentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_temperamentMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CatData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CatData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      imageUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image_url'],
          )!,
      breed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}breed'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      temperament:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}temperament'],
          )!,
      origin:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}origin'],
          )!,
    );
  }

  @override
  $CatsTable createAlias(String alias) {
    return $CatsTable(attachedDatabase, alias);
  }
}

class CatData extends DataClass implements Insertable<CatData> {
  final String id;
  final String imageUrl;
  final String breed;
  final String description;
  final String temperament;
  final String origin;
  const CatData({
    required this.id,
    required this.imageUrl,
    required this.breed,
    required this.description,
    required this.temperament,
    required this.origin,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['image_url'] = Variable<String>(imageUrl);
    map['breed'] = Variable<String>(breed);
    map['description'] = Variable<String>(description);
    map['temperament'] = Variable<String>(temperament);
    map['origin'] = Variable<String>(origin);
    return map;
  }

  CatsCompanion toCompanion(bool nullToAbsent) {
    return CatsCompanion(
      id: Value(id),
      imageUrl: Value(imageUrl),
      breed: Value(breed),
      description: Value(description),
      temperament: Value(temperament),
      origin: Value(origin),
    );
  }

  factory CatData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CatData(
      id: serializer.fromJson<String>(json['id']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      breed: serializer.fromJson<String>(json['breed']),
      description: serializer.fromJson<String>(json['description']),
      temperament: serializer.fromJson<String>(json['temperament']),
      origin: serializer.fromJson<String>(json['origin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'breed': serializer.toJson<String>(breed),
      'description': serializer.toJson<String>(description),
      'temperament': serializer.toJson<String>(temperament),
      'origin': serializer.toJson<String>(origin),
    };
  }

  CatData copyWith({
    String? id,
    String? imageUrl,
    String? breed,
    String? description,
    String? temperament,
    String? origin,
  }) => CatData(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    breed: breed ?? this.breed,
    description: description ?? this.description,
    temperament: temperament ?? this.temperament,
    origin: origin ?? this.origin,
  );
  CatData copyWithCompanion(CatsCompanion data) {
    return CatData(
      id: data.id.present ? data.id.value : this.id,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      breed: data.breed.present ? data.breed.value : this.breed,
      description:
          data.description.present ? data.description.value : this.description,
      temperament:
          data.temperament.present ? data.temperament.value : this.temperament,
      origin: data.origin.present ? data.origin.value : this.origin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CatData(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('breed: $breed, ')
          ..write('description: $description, ')
          ..write('temperament: $temperament, ')
          ..write('origin: $origin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, imageUrl, breed, description, temperament, origin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatData &&
          other.id == this.id &&
          other.imageUrl == this.imageUrl &&
          other.breed == this.breed &&
          other.description == this.description &&
          other.temperament == this.temperament &&
          other.origin == this.origin);
}

class CatsCompanion extends UpdateCompanion<CatData> {
  final Value<String> id;
  final Value<String> imageUrl;
  final Value<String> breed;
  final Value<String> description;
  final Value<String> temperament;
  final Value<String> origin;
  final Value<int> rowid;
  const CatsCompanion({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.breed = const Value.absent(),
    this.description = const Value.absent(),
    this.temperament = const Value.absent(),
    this.origin = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CatsCompanion.insert({
    required String id,
    required String imageUrl,
    required String breed,
    required String description,
    required String temperament,
    required String origin,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       imageUrl = Value(imageUrl),
       breed = Value(breed),
       description = Value(description),
       temperament = Value(temperament),
       origin = Value(origin);
  static Insertable<CatData> custom({
    Expression<String>? id,
    Expression<String>? imageUrl,
    Expression<String>? breed,
    Expression<String>? description,
    Expression<String>? temperament,
    Expression<String>? origin,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageUrl != null) 'image_url': imageUrl,
      if (breed != null) 'breed': breed,
      if (description != null) 'description': description,
      if (temperament != null) 'temperament': temperament,
      if (origin != null) 'origin': origin,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CatsCompanion copyWith({
    Value<String>? id,
    Value<String>? imageUrl,
    Value<String>? breed,
    Value<String>? description,
    Value<String>? temperament,
    Value<String>? origin,
    Value<int>? rowid,
  }) {
    return CatsCompanion(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      breed: breed ?? this.breed,
      description: description ?? this.description,
      temperament: temperament ?? this.temperament,
      origin: origin ?? this.origin,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (temperament.present) {
      map['temperament'] = Variable<String>(temperament.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatsCompanion(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('breed: $breed, ')
          ..write('description: $description, ')
          ..write('temperament: $temperament, ')
          ..write('origin: $origin, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LikedCatsTable extends LikedCats
    with TableInfo<$LikedCatsTable, LikedCatData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LikedCatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
    'breed',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _likedAtMeta = const VerificationMeta(
    'likedAt',
  );
  @override
  late final GeneratedColumn<DateTime> likedAt = GeneratedColumn<DateTime>(
    'liked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, imageUrl, breed, likedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liked_cats';
  @override
  VerificationContext validateIntegrity(
    Insertable<LikedCatData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
        _breedMeta,
        breed.isAcceptableOrUnknown(data['breed']!, _breedMeta),
      );
    } else if (isInserting) {
      context.missing(_breedMeta);
    }
    if (data.containsKey('liked_at')) {
      context.handle(
        _likedAtMeta,
        likedAt.isAcceptableOrUnknown(data['liked_at']!, _likedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_likedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LikedCatData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LikedCatData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      imageUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image_url'],
          )!,
      breed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}breed'],
          )!,
      likedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}liked_at'],
          )!,
    );
  }

  @override
  $LikedCatsTable createAlias(String alias) {
    return $LikedCatsTable(attachedDatabase, alias);
  }
}

class LikedCatData extends DataClass implements Insertable<LikedCatData> {
  final String id;
  final String imageUrl;
  final String breed;
  final DateTime likedAt;
  const LikedCatData({
    required this.id,
    required this.imageUrl,
    required this.breed,
    required this.likedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['image_url'] = Variable<String>(imageUrl);
    map['breed'] = Variable<String>(breed);
    map['liked_at'] = Variable<DateTime>(likedAt);
    return map;
  }

  LikedCatsCompanion toCompanion(bool nullToAbsent) {
    return LikedCatsCompanion(
      id: Value(id),
      imageUrl: Value(imageUrl),
      breed: Value(breed),
      likedAt: Value(likedAt),
    );
  }

  factory LikedCatData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LikedCatData(
      id: serializer.fromJson<String>(json['id']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      breed: serializer.fromJson<String>(json['breed']),
      likedAt: serializer.fromJson<DateTime>(json['likedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'breed': serializer.toJson<String>(breed),
      'likedAt': serializer.toJson<DateTime>(likedAt),
    };
  }

  LikedCatData copyWith({
    String? id,
    String? imageUrl,
    String? breed,
    DateTime? likedAt,
  }) => LikedCatData(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    breed: breed ?? this.breed,
    likedAt: likedAt ?? this.likedAt,
  );
  LikedCatData copyWithCompanion(LikedCatsCompanion data) {
    return LikedCatData(
      id: data.id.present ? data.id.value : this.id,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      breed: data.breed.present ? data.breed.value : this.breed,
      likedAt: data.likedAt.present ? data.likedAt.value : this.likedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LikedCatData(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('breed: $breed, ')
          ..write('likedAt: $likedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imageUrl, breed, likedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LikedCatData &&
          other.id == this.id &&
          other.imageUrl == this.imageUrl &&
          other.breed == this.breed &&
          other.likedAt == this.likedAt);
}

class LikedCatsCompanion extends UpdateCompanion<LikedCatData> {
  final Value<String> id;
  final Value<String> imageUrl;
  final Value<String> breed;
  final Value<DateTime> likedAt;
  final Value<int> rowid;
  const LikedCatsCompanion({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.breed = const Value.absent(),
    this.likedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LikedCatsCompanion.insert({
    required String id,
    required String imageUrl,
    required String breed,
    required DateTime likedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       imageUrl = Value(imageUrl),
       breed = Value(breed),
       likedAt = Value(likedAt);
  static Insertable<LikedCatData> custom({
    Expression<String>? id,
    Expression<String>? imageUrl,
    Expression<String>? breed,
    Expression<DateTime>? likedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageUrl != null) 'image_url': imageUrl,
      if (breed != null) 'breed': breed,
      if (likedAt != null) 'liked_at': likedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LikedCatsCompanion copyWith({
    Value<String>? id,
    Value<String>? imageUrl,
    Value<String>? breed,
    Value<DateTime>? likedAt,
    Value<int>? rowid,
  }) {
    return LikedCatsCompanion(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      breed: breed ?? this.breed,
      likedAt: likedAt ?? this.likedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (likedAt.present) {
      map['liked_at'] = Variable<DateTime>(likedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LikedCatsCompanion(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('breed: $breed, ')
          ..write('likedAt: $likedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CatsTable cats = $CatsTable(this);
  late final $LikedCatsTable likedCats = $LikedCatsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cats, likedCats];
}

typedef $$CatsTableCreateCompanionBuilder =
    CatsCompanion Function({
      required String id,
      required String imageUrl,
      required String breed,
      required String description,
      required String temperament,
      required String origin,
      Value<int> rowid,
    });
typedef $$CatsTableUpdateCompanionBuilder =
    CatsCompanion Function({
      Value<String> id,
      Value<String> imageUrl,
      Value<String> breed,
      Value<String> description,
      Value<String> temperament,
      Value<String> origin,
      Value<int> rowid,
    });

class $$CatsTableFilterComposer extends Composer<_$AppDatabase, $CatsTable> {
  $$CatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get temperament => $composableBuilder(
    column: $table.temperament,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CatsTableOrderingComposer extends Composer<_$AppDatabase, $CatsTable> {
  $$CatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get temperament => $composableBuilder(
    column: $table.temperament,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CatsTable> {
  $$CatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get breed =>
      $composableBuilder(column: $table.breed, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get temperament => $composableBuilder(
    column: $table.temperament,
    builder: (column) => column,
  );

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);
}

class $$CatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CatsTable,
          CatData,
          $$CatsTableFilterComposer,
          $$CatsTableOrderingComposer,
          $$CatsTableAnnotationComposer,
          $$CatsTableCreateCompanionBuilder,
          $$CatsTableUpdateCompanionBuilder,
          (CatData, BaseReferences<_$AppDatabase, $CatsTable, CatData>),
          CatData,
          PrefetchHooks Function()
        > {
  $$CatsTableTableManager(_$AppDatabase db, $CatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> breed = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> temperament = const Value.absent(),
                Value<String> origin = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CatsCompanion(
                id: id,
                imageUrl: imageUrl,
                breed: breed,
                description: description,
                temperament: temperament,
                origin: origin,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String imageUrl,
                required String breed,
                required String description,
                required String temperament,
                required String origin,
                Value<int> rowid = const Value.absent(),
              }) => CatsCompanion.insert(
                id: id,
                imageUrl: imageUrl,
                breed: breed,
                description: description,
                temperament: temperament,
                origin: origin,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CatsTable,
      CatData,
      $$CatsTableFilterComposer,
      $$CatsTableOrderingComposer,
      $$CatsTableAnnotationComposer,
      $$CatsTableCreateCompanionBuilder,
      $$CatsTableUpdateCompanionBuilder,
      (CatData, BaseReferences<_$AppDatabase, $CatsTable, CatData>),
      CatData,
      PrefetchHooks Function()
    >;
typedef $$LikedCatsTableCreateCompanionBuilder =
    LikedCatsCompanion Function({
      required String id,
      required String imageUrl,
      required String breed,
      required DateTime likedAt,
      Value<int> rowid,
    });
typedef $$LikedCatsTableUpdateCompanionBuilder =
    LikedCatsCompanion Function({
      Value<String> id,
      Value<String> imageUrl,
      Value<String> breed,
      Value<DateTime> likedAt,
      Value<int> rowid,
    });

class $$LikedCatsTableFilterComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get likedAt => $composableBuilder(
    column: $table.likedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LikedCatsTableOrderingComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get likedAt => $composableBuilder(
    column: $table.likedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LikedCatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get breed =>
      $composableBuilder(column: $table.breed, builder: (column) => column);

  GeneratedColumn<DateTime> get likedAt =>
      $composableBuilder(column: $table.likedAt, builder: (column) => column);
}

class $$LikedCatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LikedCatsTable,
          LikedCatData,
          $$LikedCatsTableFilterComposer,
          $$LikedCatsTableOrderingComposer,
          $$LikedCatsTableAnnotationComposer,
          $$LikedCatsTableCreateCompanionBuilder,
          $$LikedCatsTableUpdateCompanionBuilder,
          (
            LikedCatData,
            BaseReferences<_$AppDatabase, $LikedCatsTable, LikedCatData>,
          ),
          LikedCatData,
          PrefetchHooks Function()
        > {
  $$LikedCatsTableTableManager(_$AppDatabase db, $LikedCatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LikedCatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LikedCatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LikedCatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> breed = const Value.absent(),
                Value<DateTime> likedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LikedCatsCompanion(
                id: id,
                imageUrl: imageUrl,
                breed: breed,
                likedAt: likedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String imageUrl,
                required String breed,
                required DateTime likedAt,
                Value<int> rowid = const Value.absent(),
              }) => LikedCatsCompanion.insert(
                id: id,
                imageUrl: imageUrl,
                breed: breed,
                likedAt: likedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LikedCatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LikedCatsTable,
      LikedCatData,
      $$LikedCatsTableFilterComposer,
      $$LikedCatsTableOrderingComposer,
      $$LikedCatsTableAnnotationComposer,
      $$LikedCatsTableCreateCompanionBuilder,
      $$LikedCatsTableUpdateCompanionBuilder,
      (
        LikedCatData,
        BaseReferences<_$AppDatabase, $LikedCatsTable, LikedCatData>,
      ),
      LikedCatData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CatsTableTableManager get cats => $$CatsTableTableManager(_db, _db.cats);
  $$LikedCatsTableTableManager get likedCats =>
      $$LikedCatsTableTableManager(_db, _db.likedCats);
}
