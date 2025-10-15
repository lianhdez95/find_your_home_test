import 'package:find_your_home_test/core/error/failure.dart';
import 'package:find_your_home_test/core/result/result.dart';
import 'package:find_your_home_test/modules/house/domain/entities/house_detail.dart';
import 'package:find_your_home_test/modules/house/domain/repositories/house_detail_repository.dart';

class GetHouseDetailUseCase {
  final HouseDetailRepository _repo;
  GetHouseDetailUseCase(this._repo);

  Future<Result<HouseDetail, Failure>> call(String id) {
    return _repo.getHouseDetail(id);
  }
}
