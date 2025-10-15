import 'package:find_your_home_test/modules/auth/data/datasources/auth_local_datasource.dart';
import 'package:find_your_home_test/modules/auth/data/models/user_model.dart';
import 'package:find_your_home_test/modules/auth/domain/entities/user.dart' as domain;
import 'package:find_your_home_test/modules/auth/domain/repositories/auth_repository.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource local;
  AuthRepositoryImpl({required this.local});

  @override
  Future<void> registerUser(domain.User user) async {
    final existing = await local.getUserByEmail(user.email);
    if (existing != null) {
      throw EmailAlreadyExistsException();
    }
    // Hash de contraseña antes de persistir
    final hashed = sha256.convert(utf8.encode(user.password)).toString();
    final model = UserModel(name: user.name, email: user.email, password: hashed);
    await local.saveUser(model);
  }

  @override
  Future<domain.User> login({required String email, required String password}) async {
    final stored = await local.getUserByEmail(email.trim().toLowerCase());
    if (stored == null) {
      throw UserNotFoundException();
    }
    final providedHash = sha256.convert(utf8.encode(password)).toString();
    if (stored.password != providedHash) {
      throw InvalidCredentialsException();
    }
    return domain.User(name: stored.name, email: stored.email, password: stored.password);
  }
}

class UserNotFoundException implements Exception {}
class InvalidCredentialsException implements Exception {}
