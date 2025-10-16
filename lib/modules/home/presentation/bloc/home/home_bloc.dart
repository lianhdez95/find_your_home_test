import 'package:equatable/equatable.dart';
import 'package:find_your_home_test/core/logging/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_your_home_test/modules/home/domain/entities/house_preview.dart';
import 'package:find_your_home_test/modules/home/domain/usecases/get_houses_usecase.dart';
import 'package:find_your_home_test/modules/home/domain/usecases/get_favorites_usecase.dart';
import 'package:find_your_home_test/modules/home/domain/usecases/toggle_favorite_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHousesUseCase getHouses;
  final GetFavoritesUseCase getFavorites;
  final ToggleFavoriteUseCase toggleFavorite;
  HomeBloc({required this.getHouses, required this.getFavorites, required this.toggleFavorite}) : super(const HomeState.initial()) {
    on<HomeLoadRequested>(_onLoad);
    on<HomeRefreshRequested>(_onRefresh);
    on<HomeFavoritesLoadRequested>(_onFavoritesLoad);
    on<HomeFavoriteToggled>(_onFavoriteToggled);
    on<HomeFilterFavoritesToggled>(_onFilterFavoritesToggled);
  }

  Future<void> _onLoad(HomeLoadRequested event, Emitter<HomeState> emit) async {
    logInfo('HomeBloc: load requested');
    emit(state.copyWith(status: HomeStatus.loading, errorCode: null));
    try {
  final result = await getHouses(forceRefresh: false);
      result.fold(
        onErr: (f) {
          logError('HomeBloc: load failure code=${f.code}');
          emit(state.copyWith(status: HomeStatus.failure, errorCode: f.code));
        },
        onOk: (items) {
          logInfo('HomeBloc: load success items=${items.length}');
          emit(state.copyWith(status: HomeStatus.loaded, houses: items));
        },
      );
    } catch (e) {
      logError('HomeBloc: load exception', error: e);
      emit(state.copyWith(status: HomeStatus.failure, errorCode: 'fetch_error'));
    }
  }

  Future<void> _onRefresh(HomeRefreshRequested event, Emitter<HomeState> emit) async {
    try {
      final result = await getHouses(forceRefresh: true);
      result.fold(
        onErr: (f) {
          logError('HomeBloc: refresh failure code=${f.code}');
          emit(state.copyWith(status: HomeStatus.failure, errorCode: f.code));
        },
        onOk: (items) {
          logInfo('HomeBloc: refresh success items=${items.length}');
          emit(state.copyWith(status: HomeStatus.loaded, houses: items));
        },
      );
    } catch (e) {
      logError('HomeBloc: refresh exception', error: e);
      emit(state.copyWith(status: HomeStatus.failure, errorCode: 'fetch_error'));
    }
  }

  Future<void> _onFavoritesLoad(HomeFavoritesLoadRequested event, Emitter<HomeState> emit) async {
    final res = await getFavorites(userEmail: event.userEmail);
    res.fold(
      onErr: (f) => logError('HomeBloc: favorites load failure code=${f.code}'),
      onOk: (setIds) {
        logInfo('HomeBloc: favorites loaded count=${setIds.length}');
        emit(state.copyWith(favorites: setIds));
      },
    );
  }

  Future<void> _onFavoriteToggled(HomeFavoriteToggled event, Emitter<HomeState> emit) async {
    // Actualización optimista
    final current = Set<String>.from(state.favorites);
    if (current.contains(event.houseId)) {
      current.remove(event.houseId);
    } else {
      current.add(event.houseId);
    }
    emit(state.copyWith(favorites: current));

    final res = await toggleFavorite(userEmail: event.userEmail, houseId: event.houseId);
    res.fold(
      onErr: (f) {
        logError('HomeBloc: toggle favorite failed code=${f.code}');
        // revertir en caso de fallo
        final revert = Set<String>.from(current);
        if (revert.contains(event.houseId)) {
          revert.remove(event.houseId);
        } else {
          revert.add(event.houseId);
        }
        emit(state.copyWith(favorites: revert));
      },
      onOk: (_) => logInfo('HomeBloc: toggle favorite success'),
    );
  }

  void _onFilterFavoritesToggled(HomeFilterFavoritesToggled event, Emitter<HomeState> emit) {
    emit(state.copyWith(showOnlyFavorites: !state.showOnlyFavorites));
  }
}
