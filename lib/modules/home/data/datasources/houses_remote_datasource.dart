import 'package:dio/dio.dart';
import 'package:find_your_home_test/core/env/strings.dart';
import 'package:find_your_home_test/core/logging/logger.dart';
import 'package:find_your_home_test/core/network/dio_client.dart';
import 'package:find_your_home_test/modules/home/data/models/house_preview_model.dart';

abstract class HousesRemoteDataSource {
  Future<List<HousePreviewModel>> fetchHouses();
}

class HousesRemoteDataSourceImpl implements HousesRemoteDataSource {
  final DioClient api;
  HousesRemoteDataSourceImpl(this.api);

  @override
  Future<List<HousePreviewModel>> fetchHouses() async {
  // normaliza para evitar 'baseUrlhouses' si falta la barra
  final String raw = (housesUrl?.isNotEmpty ?? false) ? housesUrl! : 'houses';
  final String path = raw.startsWith('/') ? raw : '/$raw';
    final base = api.raw.options.baseUrl;
    logInfo('GET houses -> baseUrl=$base path=$path');
    try {
      final Response<dynamic> res = await api.get<dynamic>(path);
      logDebug('GET houses <- status=${res.statusCode} type=${res.data.runtimeType}');

      List<dynamic> extractList(dynamic data) {
        if (data == null) return const [];
        if (data is List) return data;
        if (data is Map<String, dynamic>) {
          // Intenta claves comunes
          final dynamic v = data['data'] ?? data['items'] ?? data['results'] ?? data['list'];
          if (v is List) return v;
        }
        return const [];
      }

      final list = extractList(res.data);
      logInfo('GET houses -> parsed count=${list.length}');
      final models = list
          .whereType<Map<String, dynamic>>()
          .map((e) => HousePreviewModel.fromJson(e))
          .toList();
      return models;
    } on DioException catch (e, st) {
      logError('GET houses failed (dio)', error: e, stackTrace: st);
      rethrow;
    } catch (e, st) {
      logError('GET houses failed (unknown)', error: e, stackTrace: st);
      rethrow;
    }
  }
}
