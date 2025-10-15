import 'dart:convert';
import 'package:find_your_home_test/modules/auth/domain/entities/user.dart' as domain;

class UserModel {
  final String name;
  final String email;
  final String password;

  const UserModel({required this.name, required this.email, required this.password});

  factory UserModel.fromDomain(domain.User u) => UserModel(name: u.name, email: u.email, password: u.password);
  domain.User toDomain() => domain.User(name: name, email: email, password: password);

  Map<String, dynamic> toMap() => { 'name': name, 'email': email, 'password': password };
  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        name: map['name'] as String,
        email: map['email'] as String,
        password: map['password'] as String,
      );

  String toJson() => jsonEncode(toMap());
  factory UserModel.fromJson(String source) => UserModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
