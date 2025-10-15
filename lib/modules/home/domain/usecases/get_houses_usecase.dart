import 'package:find_your_home_test/core/error/failure.dart';
import 'package:find_your_home_test/core/result/result.dart';
import 'package:find_your_home_test/modules/home/domain/entities/house_preview.dart';
import 'package:find_your_home_test/modules/home/domain/repositories/houses_repository.dart';

class GetHousesUseCase {
  final HousesRepository repository;
  GetHousesUseCase(this.repository);

  Future<Result<List<HousePreview>, Failure>> call({bool forceRefresh = false}) async => repository.getHouses(forceRefresh: forceRefresh);
}
