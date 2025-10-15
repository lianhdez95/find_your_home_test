import 'package:find_your_home_test/core/error/failure.dart';
import 'package:find_your_home_test/core/result/result.dart';
import 'package:find_your_home_test/modules/home/domain/entities/house_preview.dart';

abstract class HousesRepository {
  /// Obtiene las casas preferiblemente desde caché.
  /// Si [forceRefresh] es true, va a red y actualiza caché.
  Future<Result<List<HousePreview>, Failure>> getHouses({bool forceRefresh = false});

  /// Favoritos por usuario (persistentes entre sesiones)
  Future<Result<void, Failure>> toggleFavorite({required String userEmail, required String houseId});
  Future<Result<Set<String>, Failure>> getFavorites({required String userEmail});
}
