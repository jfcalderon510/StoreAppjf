import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeappv2/app/users/presentacion/model/users_model.dart';
import 'package:storeappv2/app/users/domain/use_case/get_users_use_case.dart';
import 'package:storeappv2/app/users/presentacion/bloc/users_event.dart';
import 'package:storeappv2/app/users/presentacion/bloc/users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase getUsersUseCase;

  UsersBloc({
    required this.getUsersUseCase,

  }) : super(LoadingState()) {
    on<GetUsersEvent>(_getUsersEvent);   
  }

  void _getUsersEvent(
    GetUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    late UsersState newState;

    try {
      newState = LoadingState();
      emit(newState);

      final List<UserModel> result = await getUsersUseCase.invoke();

      if (result.isEmpty) {
        newState = EmptyState();
      } else {
        newState = LoadDataState(model: state.model.copyWith(products: result));
      }
    } catch (e) {
      newState = UsersErrorState(
        model: state.model,
        message: "Error al obtener los Usuarios",
      );
    }
    emit(newState);
  }
}
