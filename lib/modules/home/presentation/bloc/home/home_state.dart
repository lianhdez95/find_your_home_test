part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<HousePreview> houses;
  final String? errorCode;

  const HomeState({
    required this.status,
    required this.houses,
    this.errorCode,
  });

  const HomeState.initial()
      : status = HomeStatus.initial,
        houses = const [],
        errorCode = null;

  HomeState copyWith({
    HomeStatus? status,
    List<HousePreview>? houses,
    String? errorCode,
  }) {
    return HomeState(
      status: status ?? this.status,
      houses: houses ?? this.houses,
      errorCode: errorCode,
    );
  }

  @override
  List<Object?> get props => [status, houses, errorCode];
}
