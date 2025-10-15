import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_your_home_test/modules/auth/domain/usecases/login_user_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUseCase loginUser;
  LoginBloc({required this.loginUser}) : super(const LoginState()) {
    on<LoginEmailChanged>((e, emit) => emit(state.copyWith(email: e.email, errorCode: null)));
    on<LoginPasswordChanged>((e, emit) => emit(state.copyWith(password: e.password, errorCode: null)));
    on<LoginSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.submitting, errorCode: null));
    try {
  final user = await loginUser(email: state.email, password: state.password);
  emit(state.copyWith(status: LoginStatus.success, userEmail: user.email, userName: user.name));
    } on ArgumentError catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, errorCode: e.message.toString()));
    } catch (e) {
      final type = e.runtimeType.toString();
      final code = type == 'UserNotFoundException'
          ? 'user_not_found'
          : (type == 'InvalidCredentialsException' ? 'invalid_credentials' : 'unknown');
      emit(state.copyWith(status: LoginStatus.failure, errorCode: code));
    }
  }
}
