import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/cat.dart';
import '../../../domain/repositories/cat_repository.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatRepository catRepository;
  final Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isOnline = true;

  CatBloc({required this.catRepository, required this.connectivity})
    : super(CatInitial()) {
    _initConnectivitySubscription();

    on<LoadRandomCatEvent>(_onLoadRandomCat);
    on<LikeCatEvent>(_onLikeCat);
    on<DislikeCatEvent>(_onDislikeCat);
    on<LoadLikedCatsEvent>(_onLoadLikedCats);
    on<RemoveLikedCatEvent>(_onRemoveLikedCat);
    on<ClearAllLikedCatsEvent>(_onClearAllLikedCats);
    on<NetworkStatusChanged>(_onNetworkStatusChanged);
  }

  void _initConnectivitySubscription() {
    _connectivitySubscription = connectivity.onConnectivityChanged.listen((
      result,
    ) {
      final newStatus = result != ConnectivityResult.none;
      if (newStatus != _isOnline) {
        _isOnline = newStatus;
        add(NetworkStatusChanged(_isOnline));
      }
    });
  }

  Future<void> _onNetworkStatusChanged(
    NetworkStatusChanged event,
    Emitter<CatState> emit,
  ) async {
    if (state is CatLoaded) {
      emit((state as CatLoaded).copyWith(isOnline: event.isOnline));
    } else if (state is CatLiked) {
      emit((state as CatLiked).copyWith(isOnline: event.isOnline));
    }
  }

  Future<void> _onLoadRandomCat(
    LoadRandomCatEvent event,
    Emitter<CatState> emit,
  ) async {
    emit(CatLoading());
    try {
      final cat = await catRepository.getRandomCat();
      final likedCats = await catRepository.getLikedCats();
      emit(CatLoaded(cat: cat, likedCats: likedCats, isOnline: _isOnline));
    } catch (e) {
      emit(CatError(message: e.toString()));
    }
  }

  Future<void> _onLikeCat(LikeCatEvent event, Emitter<CatState> emit) async {
    if (state is! CatLoaded) return;

    final currentState = state as CatLoaded;
    emit(CatActionInProgress(cat: currentState.cat));

    try {
      await catRepository.likeCat(currentState.cat);
      final likedCats = await catRepository.getLikedCats();
      emit(
        CatLiked(
          cat: currentState.cat,
          likedCats: likedCats,
          isOnline: _isOnline,
        ),
      );
      add(LoadRandomCatEvent());
    } catch (e) {
      emit(CatError(message: e.toString(), cat: currentState.cat));
    }
  }

  Future<void> _onDislikeCat(
    DislikeCatEvent event,
    Emitter<CatState> emit,
  ) async {
    if (state is! CatLoaded) return;

    emit(CatLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      add(LoadRandomCatEvent());
    } catch (e) {
      emit(CatError(message: e.toString()));
    }
  }

  Future<void> _onLoadLikedCats(
    LoadLikedCatsEvent event,
    Emitter<CatState> emit,
  ) async {
    try {
      final likedCats = await catRepository.getLikedCats();
      if (state is CatLoaded) {
        emit((state as CatLoaded).copyWith(likedCats: likedCats));
      } else if (state is CatLiked) {
        emit((state as CatLiked).copyWith(likedCats: likedCats));
      }
    } catch (e) {
      emit(CatError(message: e.toString()));
    }
  }

  Future<void> _onRemoveLikedCat(
    RemoveLikedCatEvent event,
    Emitter<CatState> emit,
  ) async {
    try {
      await catRepository.removeLikedCat(event.catId);
      final likedCats = await catRepository.getLikedCats();
      if (state is CatLoaded) {
        emit((state as CatLoaded).copyWith(likedCats: likedCats));
      } else if (state is CatLiked) {
        emit((state as CatLiked).copyWith(likedCats: likedCats));
      }
    } catch (e) {
      emit(CatError(message: e.toString()));
    }
  }

  Future<void> _onClearAllLikedCats(
    ClearAllLikedCatsEvent event,
    Emitter<CatState> emit,
  ) async {
    try {
      await catRepository.clearAllLikedCats();
      final likedCats = await catRepository.getLikedCats();
      if (state is CatLoaded) {
        emit((state as CatLoaded).copyWith(likedCats: likedCats));
      } else if (state is CatLiked) {
        emit((state as CatLiked).copyWith(likedCats: likedCats));
      }
    } catch (e) {
      emit(CatError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
