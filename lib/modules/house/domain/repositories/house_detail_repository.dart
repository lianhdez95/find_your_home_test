import 'package:find_your_home_test/core/error/failure.dart';
import 'package:find_your_home_test/core/result/result.dart';
import 'package:find_your_home_test/modules/house/domain/entities/house_detail.dart';

abstract class HouseDetailRepository {
  Future<Result<HouseDetail, Failure>> getHouseDetail(String id);
}
