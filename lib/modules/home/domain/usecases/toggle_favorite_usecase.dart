import 'package:find_your_home_test/core/error/failure.dart';
import 'package:find_your_home_test/core/result/result.dart';
import 'package:find_your_home_test/modules/home/domain/repositories/houses_repository.dart';

class ToggleFavoriteUseCase {
  final HousesRepository repository;
  ToggleFavoriteUseCase(this.repository);

  Future<Result<void, Failure>> call({required String userEmail, required String houseId}) {
    return repository.toggleFavorite(userEmail: userEmail, houseId: houseId);
  }
}
