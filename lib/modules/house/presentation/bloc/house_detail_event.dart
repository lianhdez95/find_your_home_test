part of 'house_detail_bloc.dart';

abstract class HouseDetailEvent extends Equatable {
  const HouseDetailEvent();
  @override
  List<Object?> get props => [];
}

class HouseDetailLoadRequested extends HouseDetailEvent {
  final String houseId;
  final String? userEmail;
  const HouseDetailLoadRequested({required this.houseId, this.userEmail});

  @override
  List<Object?> get props => [houseId, userEmail];
}

class HouseDetailFavoriteToggled extends HouseDetailEvent {
  final String? userEmail;
  const HouseDetailFavoriteToggled({required this.userEmail});

  @override
  List<Object?> get props => [userEmail];
}
