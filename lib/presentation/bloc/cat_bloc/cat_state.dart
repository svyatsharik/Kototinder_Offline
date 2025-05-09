part of 'cat_bloc.dart';

abstract class CatState extends Equatable {
  final bool isOnline;

  const CatState({this.isOnline = true});

  @override
  List<Object> get props => [isOnline];
}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final Cat cat;
  final List<LikedCat> likedCats;

  const CatLoaded({required this.cat, required this.likedCats, super.isOnline});

  CatLoaded copyWith({Cat? cat, List<LikedCat>? likedCats, bool? isOnline}) {
    return CatLoaded(
      cat: cat ?? this.cat,
      likedCats: likedCats ?? this.likedCats,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  List<Object> get props => [cat, likedCats, isOnline];
}

class CatLiked extends CatState {
  final Cat cat;
  final List<LikedCat> likedCats;

  const CatLiked({required this.cat, required this.likedCats, super.isOnline});

  CatLiked copyWith({Cat? cat, List<LikedCat>? likedCats, bool? isOnline}) {
    return CatLiked(
      cat: cat ?? this.cat,
      likedCats: likedCats ?? this.likedCats,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  List<Object> get props => [cat, likedCats, isOnline];
}

class CatError extends CatState {
  final String message;
  final Cat? cat;

  const CatError({required this.message, this.cat});

  @override
  List<Object> get props => [message];
}

class CatActionInProgress extends CatState {
  final Cat cat;

  const CatActionInProgress({required this.cat});

  @override
  List<Object> get props => [cat];
}
