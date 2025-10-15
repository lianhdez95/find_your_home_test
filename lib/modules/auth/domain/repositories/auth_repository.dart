import 'package:find_your_home_test/modules/auth/domain/entities/user.dart';

abstract class AuthRepository {
  /// Registra un usuario localmente. Si el email ya existe, debe lanzar una excepción específica.
  Future<void> registerUser(User user);

  /// Realiza login con email y password en texto plano.
  /// Debe validar contra el storage (password hasheada con SHA-256) y devolver el User si es correcto.
  /// Errores esperados:
  /// - 'user_not_found' si el email no existe
  /// - 'invalid_credentials' si la contraseña no coincide
  Future<User> login({required String email, required String password});
}
