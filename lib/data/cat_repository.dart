import '../domain/repositories/cat_repository.dart';
import '../domain/entities/cat.dart';
import 'cat_data_source.dart';
import 'database/database.dart';

class CatRepositoryImpl implements CatRepository {
  final CatDataSource _dataSource;
  final AppDatabase _database;

  CatRepositoryImpl(this._dataSource, this._database);

  @override
  Future<Cat> getRandomCat() async {
    try {
      final cat = await _dataSource.fetchRandomCat();
      await _database.insertCat(cat);
      return cat;
    } catch (e) {
      final cachedCats = await _database.getAllCats();
      if (cachedCats.isNotEmpty) {
        return cachedCats[DateTime.now().millisecondsSinceEpoch %
            cachedCats.length];
      }
      throw Exception('No cats available offline');
    }
  }

  @override
  Future<void> likeCat(Cat cat) async {
    final likedCat = LikedCat(
      id: cat.id,
      imageUrl: cat.imageUrl,
      breed: cat.breed,
      likedAt: DateTime.now(),
    );
    await _database.likeCat(likedCat);
  }

  @override
  Future<List<LikedCat>> getLikedCats() async {
    return await _database.getLikedCats();
  }

  @override
  Future<void> removeLikedCat(String id) async {
    await _database.removeLikedCat(id);
  }

  @override
  Future<void> clearAllLikedCats() async {
    await _database.clearAllLikedCats();
  }
}
