import 'package:find_your_home_test/core/error/failure.dart';
import 'package:find_your_home_test/core/result/result.dart';
import 'package:find_your_home_test/modules/home/domain/entities/house_preview.dart';

abstract class HousesRepository {
  Future<Result<List<HousePreview>, Failure>> getHouses();
}
