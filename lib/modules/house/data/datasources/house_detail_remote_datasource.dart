import 'package:dio/dio.dart';
import 'package:find_your_home_test/core/network/dio_client.dart';
import 'package:find_your_home_test/core/env/strings.dart';
import 'package:find_your_home_test/modules/house/data/models/house_detail_model.dart';

abstract class HouseDetailRemoteDataSource {
  Future<HouseDetailModel> getHouseDetail(String id);
}

class HouseDetailRemoteDataSourceImpl implements HouseDetailRemoteDataSource {
  final DioClient _client;
  HouseDetailRemoteDataSourceImpl(this._client);

  @override
  Future<HouseDetailModel> getHouseDetail(String id) async {
    final path = '${housesUrl ?? '/houses'}/$id';
    final Response res = await _client.get(path);
    final body = res.data;
    Map<String, dynamic> map;
    if (body is Map<String, dynamic>) {
      map = body;
    } else if (body is List && body.isNotEmpty && body.first is Map<String, dynamic>) {
      map = body.first as Map<String, dynamic>;
    } else if (body is Map && body['data'] is Map<String, dynamic>) {
      map = body['data'] as Map<String, dynamic>;
    } else {
      throw DioException(
        requestOptions: res.requestOptions,
        error: 'Formato de respuesta inválido para house detail',
        type: DioExceptionType.unknown,
      );
    }
    return HouseDetailModel.fromJson(map);
  }
}
