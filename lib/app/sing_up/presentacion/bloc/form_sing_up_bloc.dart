import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeappv2/app/sing_up/domain/use_case/add_user_use_case.dart';
import 'package:storeappv2/app/sing_up/domain/use_case/get_user_use_case.dart';
import 'package:storeappv2/app/sing_up/domain/use_case/update_user_use_case.dart';
import 'package:storeappv2/app/sing_up/presentacion/bloc/form_sing_up_event.dart';
import 'package:storeappv2/app/sing_up/presentacion/bloc/form_sing_up_state.dart';

class FormSingUpBloc extends Bloc<FormSingUpEvent, FormSingUpState> {
  final AddUserUseCase addUserUseCase;
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;

  FormSingUpBloc({
    required this.addUserUseCase,
    required this.getUserUseCase,
    required this.updateUserUseCase,
  }) : super(InitialState()) {
    on<NameChangeEvent>(_nameChangedEvent);
    on<DocumentChangeEvent>(_documentChangeEvent);
    on<UserChangeEvent>(_userChangeEvent);
    on<PasswordChangeEventSignUp>(_passwordChangeEventSignUp);
    on<ImageChangeEvent>(_imageChangeEvent);
    on<SubmitEventSignUp>(_submitEventSignUp);
    on<GetUserEvent>(_getUserEvent);
  }

  void _nameChangedEvent(
    NameChangeEvent event,
    Emitter<FormSingUpState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(name: event.name),
    );

    emit(newState);
  }

  void _documentChangeEvent(
    DocumentChangeEvent event,
    Emitter<FormSingUpState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(document: event.document),
    );
    emit(newState);
  }

  void _userChangeEvent(
    UserChangeEvent event,
    Emitter<FormSingUpState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(user: event.user),
    );
    emit(newState);
  }

  void _passwordChangeEventSignUp(
    PasswordChangeEventSignUp event,
    Emitter<FormSingUpState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(password: event.password),
    );
    emit(newState);
  }

    void _imageChangeEvent(
    ImageChangeEvent event,
    Emitter<FormSingUpState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(image: event.image),
    );
    emit(newState);
  }


  void _submitEventSignUp(SubmitEventSignUp event, Emitter<FormSingUpState> emit) async {
    
    late final FormSingUpState newState;
    
    try {
      final bool result;
      if (state.model.id == "") {
        result = await addUserUseCase.invoke(state.model);
      } else {
        result = await updateUserUseCase.invoke(state.model);
      }

      if (result) {
        newState = SubmitSuccessState(model: state.model);
      } else {
        throw (Exception());
      }
    } catch (e) {
      newState = SubmitErrorState(
        model: state.model,
        message: state.model.id == ""? "Error al agregar un producto":"Error al actualizar el producto",
      );
      //print("e");
    }

    emit(newState);
  }

  void _getUserEvent(
    GetUserEvent event,
    Emitter<FormSingUpState> emit,
  ) async {
    final result = await getUserUseCase.invoke(event.id);

    final newState = DataUpdateState(model: result);

    emit(newState);
  }
}
