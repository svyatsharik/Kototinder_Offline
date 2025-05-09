import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kototinder/data/cat_repository.dart';
import 'package:kototinder/domain/entities/cat.dart';
import '../helpers/test_helpers.dart';

void main() {
  late CatRepositoryImpl repository;
  late MockCatDataSource dataSource;
  late MockAppDatabase database;
  late Cat testCat;
  late LikedCat testLikedCat;

  setUpAll(() {
    setUpTestFallbacks();
  });

  setUp(() {
    dataSource = MockCatDataSource();
    database = MockAppDatabase();
    repository = CatRepositoryImpl(dataSource, database);
    testCat = createTestCat();
    testLikedCat = createTestLikedCat();
  });

  group('getRandomCat', () {
    test('successfully gets cat from API', () async {
      when(() => dataSource.fetchRandomCat()).thenAnswer((_) async => testCat);
      when(() => database.insertCat(any())).thenAnswer((_) async {});

      final result = await repository.getRandomCat();

      expect(result, testCat);
      verify(() => dataSource.fetchRandomCat()).called(1);
      verify(() => database.insertCat(testCat)).called(1);
    });

    test('falls back to cached cats on error', () async {
      when(() => dataSource.fetchRandomCat()).thenThrow(Exception('Error'));
      when(() => database.getAllCats()).thenAnswer((_) async => [testCat]);

      final result = await repository.getRandomCat();

      expect(result, testCat);
      verify(() => database.getAllCats()).called(1);
    });
  });

  group('likeCat', () {
    test('saves liked cat to database', () async {
      when(() => database.likeCat(any())).thenAnswer((_) async {});

      await repository.likeCat(testCat);

      verify(
        () => database.likeCat(
          any(
            that: isA<LikedCat>()
                .having((c) => c.id, 'id', testCat.id)
                .having((c) => c.breed, 'breed', testCat.breed),
          ),
        ),
      ).called(1);
    });
  });

  group('getLikedCats', () {
    test('returns liked cats from database', () async {
      when(
        () => database.getLikedCats(),
      ).thenAnswer((_) async => [testLikedCat]);

      final result = await repository.getLikedCats();

      expect(result, [testLikedCat]);
    });
  });

  group('removeLikedCat', () {
    test('removes cat by id', () async {
      when(() => database.removeLikedCat('1')).thenAnswer((_) async {});

      await repository.removeLikedCat('1');

      verify(() => database.removeLikedCat('1')).called(1);
    });
  });

  group('clearAllLikedCats', () {
    test('clears all liked cats', () async {
      when(() => database.clearAllLikedCats()).thenAnswer((_) async {});

      await repository.clearAllLikedCats();

      verify(() => database.clearAllLikedCats()).called(1);
    });
  });
}
