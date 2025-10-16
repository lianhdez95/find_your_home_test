part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<HousePreview> houses;
  final String? errorCode;
  final Set<String> favorites; // ids
  final bool showOnlyFavorites;

  const HomeState({
    required this.status,
    required this.houses,
    this.errorCode,
    required this.favorites,
    this.showOnlyFavorites = false,
  });

  const HomeState.initial()
      : status = HomeStatus.initial,
        houses = const [],
        errorCode = null,
        favorites = const {},
        showOnlyFavorites = false;

  HomeState copyWith({
    HomeStatus? status,
    List<HousePreview>? houses,
    String? errorCode,
    Set<String>? favorites,
    bool? showOnlyFavorites,
  }) {
    return HomeState(
      status: status ?? this.status,
      houses: houses ?? this.houses,
      errorCode: errorCode,
      favorites: favorites ?? this.favorites,
      showOnlyFavorites: showOnlyFavorites ?? this.showOnlyFavorites,
    );
  }

  @override
  List<Object?> get props => [status, houses, errorCode, favorites, showOnlyFavorites];
}
