import 'package:equatable/equatable.dart';
import 'package:find_your_home_test/core/logging/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_your_home_test/modules/home/domain/entities/house_preview.dart';
import 'package:find_your_home_test/modules/home/domain/usecases/get_houses_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHousesUseCase getHouses;
  HomeBloc({required this.getHouses}) : super(const HomeState.initial()) {
    on<HomeLoadRequested>(_onLoad);
    on<HomeRefreshRequested>(_onRefresh);
  }

  Future<void> _onLoad(HomeLoadRequested event, Emitter<HomeState> emit) async {
    logInfo('HomeBloc: load requested');
    emit(state.copyWith(status: HomeStatus.loading, errorCode: null));
    try {
      final result = await getHouses();
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
      final result = await getHouses();
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
}
