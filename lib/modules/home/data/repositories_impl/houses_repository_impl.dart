import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:find_your_home_test/core/error/dio_failure_mapper.dart';
import 'package:find_your_home_test/core/error/failure.dart';
import 'package:find_your_home_test/core/result/result.dart';
import 'package:find_your_home_test/core/network/network_info.dart';
import 'package:find_your_home_test/modules/home/data/datasources/houses_remote_datasource.dart';
import 'package:find_your_home_test/modules/home/data/datasources/houses_local_datasource.dart';
import 'package:find_your_home_test/modules/home/data/models/house_preview_model.dart';
import 'package:find_your_home_test/modules/home/domain/entities/house_preview.dart';
import 'package:find_your_home_test/modules/home/domain/repositories/houses_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HousesRepositoryImpl implements HousesRepository {
  final HousesRemoteDataSource remote;
  final HousesLocalDataSource local;
  final SharedPreferences prefs;
  final NetworkInfo networkInfo;
  HousesRepositoryImpl(this.remote, this.local, this.prefs, this.networkInfo);

  @override
  Future<Result<List<HousePreview>, Failure>> getHouses({bool forceRefresh = false}) async {
    try {
      // Política: si hay conexión, siempre vamos a remoto y actualizamos caché.
      final connected = await networkInfo.isConnected;
      if (connected) {
        final List<HousePreviewModel> models = await remote.fetchHouses();
        await local.cacheHouses(models);
        final list = models
            .map<HousePreview>((m) => HousePreview(
                  id: m.id,
                  title: m.title,
                  image: m.image,
                  city: m.city,
                  price: m.price,
                ))
            .toList();
        return Ok(list);
      }

      // Sin conexión: intentamos devolver caché
      final cached = await local.getCachedHouses();
      if (cached.isNotEmpty) {
        final list = cached
            .map<HousePreview>((m) => HousePreview(
                  id: m.id,
                  title: m.title,
                  image: m.image,
                  city: m.city,
                  price: m.price,
                ))
            .toList();
        return Ok(list);
      }
      return const Err(NetworkFailure(message: 'Sin conexión y sin caché'));
    } on DioException catch (e) {
      // En error de red, devolver cache si existe
      final cached = await local.getCachedHouses();
      if (cached.isNotEmpty) {
        final list = cached
            .map<HousePreview>((m) => HousePreview(
                  id: m.id,
                  title: m.title,
                  image: m.image,
                  city: m.city,
                  price: m.price,
                ))
            .toList();
        return Ok(list);
      }
      return Err(mapDioToFailure(e));
    } catch (e) {
      return const Err(UnknownFailure());
    }
  }

  static String _favKey(String userEmail) => 'favorites_${userEmail.toLowerCase()}_v1';

  @override
  Future<Result<void, Failure>> toggleFavorite({required String userEmail, required String houseId}) async {
    try {
      final key = _favKey(userEmail);
      final raw = prefs.getString(key);
      final Set<String> favs = raw == null || raw.isEmpty
          ? <String>{}
          : (List<String>.from(jsonDecode(raw))).toSet();
      if (favs.contains(houseId)) {
        favs.remove(houseId);
      } else {
        favs.add(houseId);
      }
      await prefs.setString(key, jsonEncode(favs.toList()));
      return const Ok(null);
    } catch (e) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<Set<String>, Failure>> getFavorites({required String userEmail}) async {
    try {
      final key = _favKey(userEmail);
      final raw = prefs.getString(key);
      if (raw == null || raw.isEmpty) return Ok(<String>{});
      final list = List<String>.from(jsonDecode(raw));
      return Ok(list.toSet());
    } catch (e) {
      return const Err(UnknownFailure());
    }
  }
}
