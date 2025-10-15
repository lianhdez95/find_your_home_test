import 'package:find_your_home_test/core/error/failure.dart';
import 'package:find_your_home_test/core/result/result.dart';
import 'package:find_your_home_test/modules/home/domain/repositories/houses_repository.dart';

class GetFavoritesUseCase {
  final HousesRepository repository;
  GetFavoritesUseCase(this.repository);

  Future<Result<Set<String>, Failure>> call({required String userEmail}) {
    return repository.getFavorites(userEmail: userEmail);
  }
}
