import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeappv2/app/core/domain/use_case/log_out_use_case.dart';
import 'package:storeappv2/app/home/domain/use_case/delete_products_use_case.dart';
import 'package:storeappv2/app/home/domain/use_case/get_products_use_case.dart';
import 'package:storeappv2/app/home/presentacion/model/product_model.dart';
import 'package:storeappv2/app/home/presentacion/bloc/home_event.dart';
import 'package:storeappv2/app/home/presentacion/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final DeleteProductsUseCase deleteProductsUseCase;
  final LogOutUseCase logOutUseCase;

  HomeBloc({
    required this.getProductsUseCase,
    required this.deleteProductsUseCase,
    required this.logOutUseCase,
  }) : super(LoadingState()) {
    on<GetProductsEvent>(_getProductsEvent);
    on<DeleteProductEven>(_deleteProductEvent);
    on<LogOutEvent>(_logOutEvent);
  }

  void _getProductsEvent(
    GetProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    late HomeState newState;

    try {
      newState = LoadingState();
      emit(newState);

      final List<ProductModel> result = await getProductsUseCase.invoke();

      if (result.isEmpty) {
        newState = EmptyState();
      } else {
        newState = LoadDataState(model: state.model.copyWith(products: result));
      }
    } catch (e) {
      newState = HomeErrorState(
        model: state.model,
        message: "Error al obtener los productos",
      );
    }

    emit(newState);
  }

  void _deleteProductEvent(
    DeleteProductEven event,
    Emitter<HomeState> emit,
  ) async {
    late HomeState newState;

    try {
      // newState = LoadingState();
      // emit(newState);

      final bool result = await deleteProductsUseCase.invoke(event.id);

      if (result) {
        newState = LoadingState();
        emit(newState);

        final List<ProductModel> result = await getProductsUseCase.invoke();

        if (result.isEmpty) {
          newState = EmptyState();
        } else {
          newState = LoadDataState(
            model: state.model.copyWith(products: result),
          );
        }
      } else {
        throw (Exception());
      }
    } catch (e) {
      newState = HomeErrorState(
        model: state.model,
        message: "Error al eliminar el producto",
      );
      print("😡 $e");
    }
    emit(newState);
  }

  void _logOutEvent(LogOutEvent event, Emitter<HomeState> emit) async {
    logOutUseCase.invoke();
    emit(LogOutState());

   // emit(LoadDataState());
  }
}
