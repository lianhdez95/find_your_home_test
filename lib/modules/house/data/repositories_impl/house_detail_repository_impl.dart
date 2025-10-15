import 'package:dio/dio.dart';
import 'package:find_your_home_test/core/error/dio_failure_mapper.dart';
import 'package:find_your_home_test/core/error/failure.dart';
import 'package:find_your_home_test/core/result/result.dart';
import 'package:find_your_home_test/modules/house/data/datasources/house_detail_remote_datasource.dart';
import 'package:find_your_home_test/modules/house/data/models/house_detail_model.dart';
import 'package:find_your_home_test/modules/house/domain/entities/house_detail.dart';
import 'package:find_your_home_test/modules/house/domain/repositories/house_detail_repository.dart';

class HouseDetailRepositoryImpl implements HouseDetailRepository {
  final HouseDetailRemoteDataSource _remote;
  HouseDetailRepositoryImpl(this._remote);

  @override
  Future<Result<HouseDetail, Failure>> getHouseDetail(String id) async {
    if (id.isEmpty) {
      return Err(BadRequestFailure(message: 'id vacío'));
    }
    try {
      final HouseDetailModel model = await _remote.getHouseDetail(id);
      return Ok<HouseDetail, Failure>(model);
    } on DioException catch (e) {
      return Err(mapDioToFailure(e));
    } catch (e) {
      return Err(UnknownFailure(message: e.toString()));
    }
  }
}
