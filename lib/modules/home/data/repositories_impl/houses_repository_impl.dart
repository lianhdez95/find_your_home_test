import 'package:dio/dio.dart';
import 'package:find_your_home_test/core/error/dio_failure_mapper.dart';
import 'package:find_your_home_test/core/error/failure.dart';
import 'package:find_your_home_test/core/result/result.dart';
import 'package:find_your_home_test/modules/home/data/datasources/houses_remote_datasource.dart';
import 'package:find_your_home_test/modules/home/data/models/house_preview_model.dart';
import 'package:find_your_home_test/modules/home/domain/entities/house_preview.dart';
import 'package:find_your_home_test/modules/home/domain/repositories/houses_repository.dart';

class HousesRepositoryImpl implements HousesRepository {
  final HousesRemoteDataSource remote;
  HousesRepositoryImpl(this.remote);

  @override
  Future<Result<List<HousePreview>, Failure>> getHouses() async {
    try {
      final List<HousePreviewModel> models = await remote.fetchHouses();
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
    } on DioException catch (e) {
      return Err(mapDioToFailure(e));
    } catch (e) {
      return const Err(UnknownFailure());
    }
  }
}
