part of 'login_bloc.dart';

enum LoginStatus { pristine, submitting, success, failure }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String? errorCode;
  final String? userEmail; // útil para mostrar quién inició sesión
  final String? userName;  // útil para mostrar el nombre

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = LoginStatus.pristine,
    this.errorCode,
    this.userEmail,
    this.userName,
  });

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? errorCode,
    String? userEmail,
    String? userName,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorCode: errorCode,
      userEmail: userEmail ?? this.userEmail,
      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object?> get props => [email, password, status, errorCode, userEmail, userName];
}
