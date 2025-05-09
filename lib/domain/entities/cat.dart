import 'package:drift/drift.dart';

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

class LikedCats extends Table {
  TextColumn get id => text()();
  TextColumn get imageUrl => text()();
  TextColumn get breed => text()();
  DateTimeColumn get likedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Cat {
  final String id;
  final String imageUrl;
  final String breed;
  final String description;
  final String temperament;
  final String origin;

  Cat({
    required this.id,
    required this.imageUrl,
    required this.breed,
    required this.description,
    required this.temperament,
    required this.origin,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cat && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class LikedCat {
  final String id;
  final String imageUrl;
  final String breed;
  final DateTime likedAt;

  LikedCat({
    required this.id,
    required this.imageUrl,
    required this.breed,
    required this.likedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikedCat &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          likedAt == other.likedAt;

  @override
  int get hashCode => id.hashCode ^ likedAt.hashCode;
}
