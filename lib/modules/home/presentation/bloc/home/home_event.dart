part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class HomeLoadRequested extends HomeEvent {
  const HomeLoadRequested();
}

class HomeRefreshRequested extends HomeEvent {
  const HomeRefreshRequested();
}

class HomeFavoritesLoadRequested extends HomeEvent {
  final String userEmail;
  const HomeFavoritesLoadRequested(this.userEmail);

  @override
  List<Object?> get props => [userEmail];
}

class HomeFavoriteToggled extends HomeEvent {
  final String userEmail;
  final String houseId;
  const HomeFavoriteToggled({required this.userEmail, required this.houseId});

  @override
  List<Object?> get props => [userEmail, houseId];
}
