import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import '../../domain/entities/cat.dart';

part 'database.g.dart';

@DataClassName('CatData')
class Cats extends Table {
  TextColumn get id => text()();
  TextColumn get imageUrl => text()();
  TextColumn get breed => text()();
  TextColumn get description => text()();
  TextColumn get temperament => text()();
  TextColumn get origin => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LikedCatData')
class LikedCats extends Table {
  TextColumn get id => text()();
  TextColumn get imageUrl => text()();
  TextColumn get breed => text()();
  DateTimeColumn get likedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Cats, LikedCats])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Cat>> getAllCats() async {
    return await select(cats).get().then(
      (rows) =>
          rows
              .map(
                (row) => Cat(
                  id: row.id,
                  imageUrl: row.imageUrl,
                  breed: row.breed,
                  description: row.description,
                  temperament: row.temperament,
                  origin: row.origin,
                ),
              )
              .toList(),
    );
  }

  Future<void> insertCat(Cat cat) async {
    await into(cats).insert(
      CatsCompanion.insert(
        id: cat.id,
        imageUrl: cat.imageUrl,
        breed: cat.breed,
        description: cat.description,
        temperament: cat.temperament,
        origin: cat.origin,
      ),
      mode: InsertMode.replace,
    );
  }

  Future<List<LikedCat>> getLikedCats() async {
    return await select(likedCats).get().then(
      (rows) =>
          rows
              .map(
                (row) => LikedCat(
                  id: row.id,
                  imageUrl: row.imageUrl,
                  breed: row.breed,
                  likedAt: row.likedAt,
                ),
              )
              .toList(),
    );
  }

  Future<void> likeCat(LikedCat cat) async {
    await into(likedCats).insert(
      LikedCatsCompanion.insert(
        id: cat.id,
        imageUrl: cat.imageUrl,
        breed: cat.breed,
        likedAt: cat.likedAt,
      ),
      mode: InsertMode.replace,
    );
  }

  Future<void> removeLikedCat(String id) async {
    await (delete(likedCats)..where((t) => t.id.equals(id))).go();
  }

  Future<void> clearAllLikedCats() async {
    await delete(likedCats).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
