import 'package:mocktail/mocktail.dart';
import 'package:kototinder/domain/repositories/cat_repository.dart';
import 'package:kototinder/domain/entities/cat.dart';
import 'package:kototinder/data/cat_data_source.dart';
import 'package:kototinder/data/database/database.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class MockCatRepository extends Mock implements CatRepository {}

class MockCatDataSource extends Mock implements CatDataSource {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockCat extends Mock implements Cat {}

class MockLikedCat extends Mock implements LikedCat {}

class MockConnectivity extends Mock implements Connectivity {
  final StreamController<ConnectivityResult> _controller =
      StreamController<ConnectivityResult>.broadcast();

  MockConnectivity([
    ConnectivityResult initialStatus = ConnectivityResult.wifi,
  ]) {
    when(() => onConnectivityChanged).thenAnswer((_) => _controller.stream);
    when(() => checkConnectivity()).thenAnswer((_) async => initialStatus);
    _controller.add(initialStatus);
  }

  void emit(ConnectivityResult result) => _controller.add(result);
  void dispose() => _controller.close();
}

class FakeCat extends Fake implements Cat {
  @override
  String get id => 'fake_id';
  @override
  String get imageUrl => 'fake_url';
  @override
  String get breed => 'Fake Breed';
  @override
  String get description => 'Fake description';
  @override
  String get temperament => 'Fake temperament';
  @override
  String get origin => 'Fake origin';
}

class FakeLikedCat extends Fake implements LikedCat {
  @override
  String get id => 'fake_id';
  @override
  String get imageUrl => 'fake_url';
  @override
  String get breed => 'Fake Breed';
  @override
  DateTime get likedAt => DateTime.now();
}

void setUpTestFallbacks() {
  registerFallbackValue(FakeCat());
  registerFallbackValue(FakeLikedCat());
}

Cat createTestCat({
  String id = '1',
  String imageUrl = 'test_url',
  String breed = 'Test Breed',
  String description = 'Test description',
  String temperament = 'Test temperament',
  String origin = 'Test origin',
}) {
  final cat = MockCat();
  when(() => cat.id).thenReturn(id);
  when(() => cat.imageUrl).thenReturn(imageUrl);
  when(() => cat.breed).thenReturn(breed);
  when(() => cat.description).thenReturn(description);
  when(() => cat.temperament).thenReturn(temperament);
  when(() => cat.origin).thenReturn(origin);
  return cat;
}

LikedCat createTestLikedCat({
  String id = '1',
  String imageUrl = 'test_url',
  String breed = 'Test Breed',
  DateTime? likedAt,
}) {
  final likedCat = MockLikedCat();
  when(() => likedCat.id).thenReturn(id);
  when(() => likedCat.imageUrl).thenReturn(imageUrl);
  when(() => likedCat.breed).thenReturn(breed);
  when(() => likedCat.likedAt).thenReturn(likedAt ?? DateTime.now());
  return likedCat;
}
