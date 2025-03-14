import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeappv2/app/login/domain/use_case/login_use_case.dart';
import 'package:storeappv2/app/login/presentacion/bloc/login_event.dart';
import 'package:storeappv2/app/login/presentacion/bloc/login_state.dart';
//import 'package:storeappv2/app/login/presentacion/model/login_form_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(InitialState()) {
    on<EmailChangeEvent>(_emailChangedEvent);
    on<PasswordChangeEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitChangeEvent);   
  }

  void _emailChangedEvent(EmailChangeEvent event, Emitter<LoginState> emit) {
    // final oldData = state.model;
    //final newData = LoginFormModel(email: event.email, password: state.model.password);
    final newState = DataUpdateState(
      model: state.model.copyWith(email: event.email),
    );

    emit(newState);
  }

  void _passwordChangedEvent(
    PasswordChangeEvent event,
    Emitter<LoginState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(password: event.password),
    );

    emit(newState);
  }

  void _submitChangeEvent(SubmitEvent event, Emitter<LoginState> emit) async {
    final bool result = await loginUseCase.invoke(
      state.model,
    ); //aca estoy llamando mi caso de uso
    late final LoginState newState;
    if (result) {
      //GoRouter.of(context).pushNamed("sign-up")
      //Resultado true login
      newState = LoginSuccessState(model: state.model);
    } else {
      newState = LoginErrorState(
        model: state.model,
        message: "Error iniciando Sesión",
      );
    }
    //print(result);
    emit(newState);
  }
}
