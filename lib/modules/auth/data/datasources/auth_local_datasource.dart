import 'dart:convert';
import 'package:find_your_home_test/modules/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUserByEmail(String email);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _usersKey = 'auth_users_json'; // JSON con Map<String, String> (email -> userJson)
  final SharedPreferences prefs;
  AuthLocalDataSourceImpl(this.prefs);

  @override
  Future<void> saveUser(UserModel user) async {
    final map = _readUsersMap();
    map[user.email] = user.toJson();
    final json = jsonEncode(map);
    await prefs.setString(_usersKey, json);
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    final map = _readUsersMap();
    final jsonStr = map[email];
    if (jsonStr == null) return null;
    return UserModel.fromJson(jsonStr);
  }

  Map<String, String> _readUsersMap() {
    final raw = prefs.getString(_usersKey);
    if (raw == null || raw.isEmpty) return <String, String>{};
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return decoded.map((key, value) => MapEntry(key, value as String));
    } catch (_) {
      return <String, String>{};
    }
  }
}

class EmailAlreadyExistsException implements Exception {}
