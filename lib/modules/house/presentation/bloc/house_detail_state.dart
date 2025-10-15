part of 'house_detail_bloc.dart';

enum HouseDetailStatus { initial, loading, loaded, failure }

class HouseDetailState extends Equatable {
  final HouseDetailStatus status;
  final HouseDetail? detail;
  final bool isFavorite;
  final String? error;
  final String? userEmail;

  const HouseDetailState({
    this.status = HouseDetailStatus.initial,
    this.detail,
    this.isFavorite = false,
    this.error,
    this.userEmail,
  });

  HouseDetailState copyWith({
    HouseDetailStatus? status,
    HouseDetail? detail,
    bool? isFavorite,
    String? error,
    String? userEmail,
  }) {
    return HouseDetailState(
      status: status ?? this.status,
      detail: detail ?? this.detail,
      isFavorite: isFavorite ?? this.isFavorite,
      error: error ?? this.error,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  @override
  List<Object?> get props => [status, detail, isFavorite, error, userEmail];
}
