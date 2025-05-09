import 'package:flutter_test/flutter_test.dart';
import 'package:kototinder/domain/entities/cat.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:kototinder/presentation/bloc/cat_bloc/cat_bloc.dart';
import '../../helpers/test_helpers.dart';

void main() {
  late MockCatRepository catRepository;
  late MockConnectivity mockConnectivity;
  late CatBloc catBloc;
  late Cat testCat;
  late LikedCat testLikedCat;

  setUpAll(() {
    setUpTestFallbacks();
  });

  setUp(() {
    catRepository = MockCatRepository();
    mockConnectivity = MockConnectivity();
    catBloc = CatBloc(
      catRepository: catRepository,
      connectivity: mockConnectivity,
    );
    testCat = createTestCat();
    testLikedCat = createTestLikedCat();
  });

  tearDown(() {
    mockConnectivity.dispose();
  });

  group('Connectivity', () {
    blocTest<CatBloc, CatState>(
      'changes isOnline when connectivity changes',
      build: () {
        when(
          () => catRepository.getRandomCat(),
        ).thenAnswer((_) async => testCat);
        when(() => catRepository.getLikedCats()).thenAnswer((_) async => []);
        return catBloc;
      },
      seed: () => CatLoaded(cat: testCat, likedCats: [], isOnline: true),
      act: (bloc) async {
        await Future.delayed(Duration.zero);
        mockConnectivity.emit(ConnectivityResult.none);
        await Future.delayed(Duration.zero);
      },
      expect: () => [CatLoaded(cat: testCat, likedCats: [], isOnline: false)],
      verify: (_) {
        verifyNever(() => catRepository.getRandomCat());
        verifyNever(() => catRepository.getLikedCats());
      },
    );
  });

  group('LoadRandomCatEvent', () {
    blocTest<CatBloc, CatState>(
      'emits [CatLoading, CatLoaded] when successful',
      build: () {
        when(
          () => catRepository.getRandomCat(),
        ).thenAnswer((_) async => testCat);
        when(() => catRepository.getLikedCats()).thenAnswer((_) async => []);
        return catBloc;
      },
      act: (bloc) => bloc.add(LoadRandomCatEvent()),
      expect:
          () => [
            CatLoading(),
            CatLoaded(cat: testCat, likedCats: [], isOnline: true),
          ],
    );

    blocTest<CatBloc, CatState>(
      'emits [CatLoading, CatError] when fails',
      build: () {
        when(() => catRepository.getRandomCat()).thenThrow(Exception('Error'));
        return catBloc;
      },
      act: (bloc) => bloc.add(LoadRandomCatEvent()),
      expect: () => [CatLoading(), CatError(message: 'Exception: Error')],
    );
  });

  group('LikeCatEvent', () {
    blocTest<CatBloc, CatState>(
      'successfully likes a cat',
      build: () {
        when(() => catRepository.likeCat(any())).thenAnswer((_) async {});
        when(
          () => catRepository.getLikedCats(),
        ).thenAnswer((_) async => [testLikedCat]);
        when(
          () => catRepository.getRandomCat(),
        ).thenAnswer((_) async => testCat);
        return catBloc;
      },
      seed: () => CatLoaded(cat: testCat, likedCats: [], isOnline: true),
      act: (bloc) => bloc.add(LikeCatEvent()),
      expect:
          () => [
            CatActionInProgress(cat: testCat),
            CatLiked(cat: testCat, likedCats: [testLikedCat], isOnline: true),
            CatLoading(),
            CatLoaded(cat: testCat, likedCats: [testLikedCat], isOnline: true),
          ],
    );
  });

  group('DislikeCatEvent', () {
    blocTest<CatBloc, CatState>(
      'emits [CatLoading, CatLoaded] when dislike succeeds',
      build: () {
        when(
          () => catRepository.getRandomCat(),
        ).thenAnswer((_) async => testCat);
        when(() => catRepository.getLikedCats()).thenAnswer((_) async => []);
        return catBloc;
      },
      seed: () => CatLoaded(cat: testCat, likedCats: [], isOnline: true),
      act: (bloc) {
        bloc.add(DislikeCatEvent());
        return bloc.stream.firstWhere((state) => state is! CatLoading);
      },
      expect:
          () => [
            CatLoading(),
            CatLoaded(cat: testCat, likedCats: [], isOnline: true),
          ],
      verify: (_) {
        verify(() => catRepository.getRandomCat()).called(1);
        verify(() => catRepository.getLikedCats()).called(1);
      },
    );

    blocTest<CatBloc, CatState>(
      'emits [CatLoading, CatError] when loading fails',
      build: () {
        when(() => catRepository.getRandomCat()).thenThrow(Exception('Error'));
        when(() => catRepository.getLikedCats()).thenAnswer((_) async => []);
        return catBloc;
      },
      seed: () => CatLoaded(cat: testCat, likedCats: [], isOnline: true),
      act: (bloc) {
        bloc.add(DislikeCatEvent());
        return bloc.stream.firstWhere((state) => state is! CatLoading);
      },
      expect: () => [CatLoading(), CatError(message: 'Exception: Error')],
      verify: (_) {
        verify(() => catRepository.getRandomCat()).called(1);
        verifyNever(() => catRepository.getLikedCats());
      },
    );
  });

  group('Liked cats operations', () {
    blocTest<CatBloc, CatState>(
      'removes liked cat',
      build: () {
        when(() => catRepository.removeLikedCat('1')).thenAnswer((_) async {});
        when(() => catRepository.getLikedCats()).thenAnswer((_) async => []);
        return catBloc;
      },
      seed:
          () =>
              CatLiked(cat: testCat, likedCats: [testLikedCat], isOnline: true),
      act: (bloc) => bloc.add(RemoveLikedCatEvent('1')),
      expect: () => [CatLiked(cat: testCat, likedCats: [], isOnline: true)],
    );

    blocTest<CatBloc, CatState>(
      'clears all liked cats',
      build: () {
        when(() => catRepository.clearAllLikedCats()).thenAnswer((_) async {});
        when(() => catRepository.getLikedCats()).thenAnswer((_) async => []);
        return catBloc;
      },
      seed:
          () =>
              CatLiked(cat: testCat, likedCats: [testLikedCat], isOnline: true),
      act: (bloc) => bloc.add(ClearAllLikedCatsEvent()),
      expect: () => [CatLiked(cat: testCat, likedCats: [], isOnline: true)],
    );
  });
}
