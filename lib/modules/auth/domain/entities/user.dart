import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String password; // Stored as hashed or plain depending on data layer policy

  const User({required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}
