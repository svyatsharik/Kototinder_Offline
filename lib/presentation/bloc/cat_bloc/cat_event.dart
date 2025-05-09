part of 'cat_bloc.dart';

abstract class CatEvent extends Equatable {
  const CatEvent();

  @override
  List<Object> get props => [];
}

class LoadRandomCatEvent extends CatEvent {}

class LikeCatEvent extends CatEvent {}

class DislikeCatEvent extends CatEvent {}

class LoadLikedCatsEvent extends CatEvent {}

class RemoveLikedCatEvent extends CatEvent {
  final String catId;
  const RemoveLikedCatEvent(this.catId);

  @override
  List<Object> get props => [catId];
}

class ClearAllLikedCatsEvent extends CatEvent {}

class NetworkStatusChanged extends CatEvent {
  final bool isOnline;
  const NetworkStatusChanged(this.isOnline);

  @override
  List<Object> get props => [isOnline];
}
