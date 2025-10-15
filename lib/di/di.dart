import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:find_your_home_test/modules/auth/data/datasources/auth_local_datasource.dart';
import 'package:find_your_home_test/modules/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:find_your_home_test/modules/auth/domain/repositories/auth_repository.dart';
import 'package:find_your_home_test/modules/auth/domain/usecases/register_user_usecase.dart';
import 'package:find_your_home_test/modules/auth/presentation/bloc/register/register_bloc.dart';
import 'package:find_your_home_test/modules/auth/domain/usecases/login_user_usecase.dart';
import 'package:find_your_home_test/modules/auth/presentation/bloc/login/login_bloc.dart';
import 'package:dio/dio.dart';
import 'package:find_your_home_test/core/network/dio_client.dart';
import 'package:find_your_home_test/core/network/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:find_your_home_test/modules/home/data/datasources/houses_remote_datasource.dart';
import 'package:find_your_home_test/modules/home/data/datasources/houses_local_datasource.dart';
import 'package:find_your_home_test/modules/home/data/repositories_impl/houses_repository_impl.dart';
import 'package:find_your_home_test/modules/home/domain/repositories/houses_repository.dart';
import 'package:find_your_home_test/modules/home/domain/usecases/get_houses_usecase.dart';
import 'package:find_your_home_test/modules/home/domain/usecases/get_favorites_usecase.dart';
import 'package:find_your_home_test/modules/home/domain/usecases/toggle_favorite_usecase.dart';
import 'package:find_your_home_test/modules/home/presentation/bloc/home/home_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setupDependencies() async {
  // Shared Preferences
  locator.registerSingletonAsync<SharedPreferences>(() async => SharedPreferences.getInstance());
  
  //Datasources
  locator.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(locator<SharedPreferences>()));
  locator.registerLazySingleton<HousesRemoteDataSource>(() => HousesRemoteDataSourceImpl(locator<DioClient>()));
  locator.registerLazySingleton<HousesLocalDataSource>(() => HousesLocalDataSourceImpl(locator<SharedPreferences>()));
  
  //Repositories
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(local: locator<AuthLocalDataSource>()));
  locator.registerLazySingleton<HousesRepository>(() => HousesRepositoryImpl(
        locator<HousesRemoteDataSource>(),
        locator<HousesLocalDataSource>(),
        locator<SharedPreferences>(),
        locator<NetworkInfo>(),
      ));

  // Use cases
  locator.registerFactory<RegisterUserUseCase>(() => RegisterUserUseCase(locator<AuthRepository>()));
  locator.registerFactory<LoginUserUseCase>(() => LoginUserUseCase(locator<AuthRepository>()));
  locator.registerFactory<GetHousesUseCase>(() => GetHousesUseCase(locator<HousesRepository>()));
  locator.registerFactory<GetFavoritesUseCase>(() => GetFavoritesUseCase(locator<HousesRepository>()));
  locator.registerFactory<ToggleFavoriteUseCase>(() => ToggleFavoriteUseCase(locator<HousesRepository>()));

  // Blocs
  locator.registerFactory<RegisterBloc>(() => RegisterBloc(registerUser: locator<RegisterUserUseCase>()));
  locator.registerFactory<LoginBloc>(() => LoginBloc(loginUser: locator<LoginUserUseCase>()));
  locator.registerFactory<HomeBloc>(() => HomeBloc(
        getHouses: locator<GetHousesUseCase>(),
        getFavorites: locator<GetFavoritesUseCase>(),
        toggleFavorite: locator<ToggleFavoriteUseCase>(),
      ));

  // Networking
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<DioClient>(() => DioClient(dio: locator<Dio>()));
  locator.registerLazySingleton<Connectivity>(() => Connectivity());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator<Connectivity>()));

}