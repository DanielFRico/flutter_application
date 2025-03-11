import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/app/login/domain/use_case/login_usecase.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final LoginUseCase loginUseCase;
  LoginBloc({required this.loginUseCase}) : super(InitialState()) {
    on<EmailChangedEvent>((emailChangedEvent, emit) {
      final newState = DataUpdateState(
          model: state.model.copyWith(email: emailChangedEvent.email));
      emit(newState);
    });

    on<PasswordChangedEvent>((passwordChangeEvent, emit) {
      final newState = DataUpdateState(
          model: state.model.copyWith(password: passwordChangeEvent.password));
      emit(newState);
    });

    on<SubmittedEvent>((submitEvent, emit) async {
      final result = await loginUseCase.invoke(state.model);
      if (result) {
        emit(LoginSuccessState(model: state.model, message: "Login Success"));
        return;
      }
      emit(LoginErrorState(model: state.model, message: "Login Failed"));
    });
  }
}
