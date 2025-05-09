import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';

class CatProvider with ChangeNotifier {
  final CatRepository repository;

  Cat? _currentCat;
  List<LikedCat> _likedCats = [];
  bool _isLoading = false;
  String? _error;

  CatProvider(this.repository) {
    loadRandomCat();
  }

  Cat? get currentCat => _currentCat;
  List<LikedCat> get likedCats => _likedCats;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadRandomCat() async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentCat = await repository.getRandomCat();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _currentCat = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> likeCurrentCat() async {
    if (_currentCat == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      await repository.likeCat(_currentCat!);
      _likedCats = await repository.getLikedCats();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    await loadRandomCat();
  }

  Future<void> dislikeCat() async {
    await loadRandomCat();
  }

  Future<void> loadLikedCats() async {
    _likedCats = await repository.getLikedCats();
    notifyListeners();
  }

  Future<void> removeLikedCat(String id) async {
    await repository.removeLikedCat(id);
    await loadLikedCats();
  }

  Future<void> clearAllData() async {
    await repository.clearAllLikedCats();
    _likedCats = [];
    notifyListeners();
  }
}
