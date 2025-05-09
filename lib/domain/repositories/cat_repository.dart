import '../entities/cat.dart';

abstract class CatRepository {
  Future<Cat> getRandomCat();
  Future<void> likeCat(Cat cat);
  Future<List<LikedCat>> getLikedCats();
  Future<void> removeLikedCat(String id);
  Future<void> clearAllLikedCats();
}
