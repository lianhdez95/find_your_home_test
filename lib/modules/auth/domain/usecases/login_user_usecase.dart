import 'package:find_your_home_test/modules/auth/domain/entities/user.dart';
import 'package:find_your_home_test/modules/auth/domain/repositories/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository repository;
  const LoginUserUseCase(this.repository);

  Future<User> call({required String email, required String password}) async {
    if (!_isValidEmail(email)) {
      throw ArgumentError('email_invalid');
    }
    if (password.isEmpty) {
      throw ArgumentError('password_empty');
    }
    return repository.login(email: email.trim().toLowerCase(), password: password);
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email);
  }
}
