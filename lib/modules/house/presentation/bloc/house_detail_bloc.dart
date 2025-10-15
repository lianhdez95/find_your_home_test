import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_your_home_test/modules/house/domain/entities/house_detail.dart';
import 'package:find_your_home_test/modules/house/domain/usecases/get_house_detail_usecase.dart';
import 'package:find_your_home_test/modules/home/domain/usecases/get_favorites_usecase.dart';
import 'package:find_your_home_test/modules/home/domain/usecases/toggle_favorite_usecase.dart';

part 'house_detail_event.dart';
part 'house_detail_state.dart';

class HouseDetailBloc extends Bloc<HouseDetailEvent, HouseDetailState> {
  final GetHouseDetailUseCase _getDetail;
  final GetFavoritesUseCase _getFavorites;
  final ToggleFavoriteUseCase _toggleFavorite;

  HouseDetailBloc({
    required GetHouseDetailUseCase getDetail,
    required GetFavoritesUseCase getFavorites,
    required ToggleFavoriteUseCase toggleFavorite,
  })  : _getDetail = getDetail,
        _getFavorites = getFavorites,
        _toggleFavorite = toggleFavorite,
        super(const HouseDetailState()) {
    on<HouseDetailLoadRequested>(_onLoad);
    on<HouseDetailFavoriteToggled>(_onToggleFavorite);
  }

  Future<void> _onLoad(
      HouseDetailLoadRequested event, Emitter<HouseDetailState> emit) async {
    emit(state.copyWith(status: HouseDetailStatus.loading));
  final result = await _getDetail(event.houseId);
    HouseDetail? detail;
    String? errorCode;
    result.fold(
      onErr: (e) {
        errorCode = e.code;
        return null;
      },
      onOk: (d) {
        detail = d;
        return null;
      },
    );

    if (detail == null) {
      emit(state.copyWith(status: HouseDetailStatus.failure, error: errorCode));
      return;
    }

    bool isFav = false;
    if (event.userEmail != null && detail!.id != null) {
      final favsRes = await _getFavorites(userEmail: event.userEmail!);
      final favSet = favsRes.fold<Set<String>>(
        onErr: (_) => <String>{},
        onOk: (s) => s,
      );
      isFav = favSet.contains(detail!.id!);
    }

    emit(state.copyWith(
      status: HouseDetailStatus.loaded,
      detail: detail,
      isFavorite: isFav,
      userEmail: event.userEmail ?? state.userEmail,
    ));
  }

  Future<void> _onToggleFavorite(HouseDetailFavoriteToggled event,
      Emitter<HouseDetailState> emit) async {
    final email = event.userEmail ?? state.userEmail;
    if (state.detail?.id == null || email == null) return;
    final id = state.detail!.id!;
    final prev = state.isFavorite;
    emit(state.copyWith(isFavorite: !prev));
    final res = await _toggleFavorite(userEmail: email, houseId: id);
    final shouldRollback = res.fold<bool>(
      onErr: (_) => true,
      onOk: (_) => false,
    );
    if (shouldRollback) {
      // rollback si falla
      emit(state.copyWith(isFavorite: prev));
    }
  }
}
