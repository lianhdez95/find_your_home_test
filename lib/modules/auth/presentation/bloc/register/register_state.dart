part of 'register_bloc.dart';

enum RegisterStatus { pristine, submitting, success, failure }

class RegisterState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final RegisterStatus status;
  final String? errorCode; // 'email_exists', 'email_invalid', 'password_short', 'password_mismatch', 'name_empty', 'unknown'

  const RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.status = RegisterStatus.pristine,
    this.errorCode,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    RegisterStatus? status,
    String? errorCode,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      errorCode: errorCode,
    );
  }

  @override
  List<Object?> get props => [name, email, password, confirmPassword, status, errorCode];
}
