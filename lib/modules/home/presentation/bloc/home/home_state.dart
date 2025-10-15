part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<HousePreview> houses;
  final String? errorCode;
  final Set<String> favorites; // ids

  const HomeState({
    required this.status,
    required this.houses,
    this.errorCode,
    required this.favorites,
  });

  const HomeState.initial()
      : status = HomeStatus.initial,
        houses = const [],
        errorCode = null,
        favorites = const {};

  HomeState copyWith({
    HomeStatus? status,
    List<HousePreview>? houses,
    String? errorCode,
    Set<String>? favorites,
  }) {
    return HomeState(
      status: status ?? this.status,
      houses: houses ?? this.houses,
      errorCode: errorCode,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object?> get props => [status, houses, errorCode, favorites];
}
