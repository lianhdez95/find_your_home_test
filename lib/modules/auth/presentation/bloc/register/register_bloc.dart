import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_your_home_test/modules/auth/domain/usecases/register_user_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUseCase registerUser;
  RegisterBloc({required this.registerUser}) : super(const RegisterState()) {
    on<RegisterNameChanged>((e, emit) => emit(state.copyWith(name: e.name, errorCode: null)));
    on<RegisterEmailChanged>((e, emit) => emit(state.copyWith(email: e.email, errorCode: null)));
    on<RegisterPasswordChanged>((e, emit) => emit(state.copyWith(password: e.password, errorCode: null)));
    on<RegisterConfirmPasswordChanged>((e, emit) => emit(state.copyWith(confirmPassword: e.confirmPassword, errorCode: null)));
    on<RegisterSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    if (state.password != state.confirmPassword) {
      emit(state.copyWith(status: RegisterStatus.failure, errorCode: 'password_mismatch'));
      return;
    }
    emit(state.copyWith(status: RegisterStatus.submitting, errorCode: null));
    try {
      await registerUser(name: state.name, email: state.email, password: state.password);
      emit(state.copyWith(status: RegisterStatus.success));
    } on ArgumentError catch (e) {
      emit(state.copyWith(status: RegisterStatus.failure, errorCode: e.message.toString()));
    } catch (e) {
      final code = e.runtimeType.toString() == 'EmailAlreadyExistsException' ? 'email_exists' : 'unknown';
      emit(state.copyWith(status: RegisterStatus.failure, errorCode: code));
    }
  }
}
