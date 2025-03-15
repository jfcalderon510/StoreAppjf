import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:storeappv2/app/core/data/remote/services/product_service.dart';
import 'package:storeappv2/app/core/data/remote/services/sing_up_service.dart';
import 'package:storeappv2/app/core/data/remote/services/users_service.dart';
import 'package:storeappv2/app/core/data/repository/session_repository_impl.dart';
import 'package:storeappv2/app/core/domain/repository/session_repository.dart';
import 'package:storeappv2/app/core/domain/use_case/log_out_use_case.dart';
import 'package:storeappv2/app/form_product/data/repository/form_product_repository_imp.dart';
import 'package:storeappv2/app/form_product/domain/repository/form_product_repository.dart';
import 'package:storeappv2/app/form_product/domain/use_case/add_product_use_case.dart';
import 'package:storeappv2/app/form_product/domain/use_case/get_product_use_case.dart';
import 'package:storeappv2/app/form_product/domain/use_case/update_product_use_case.dart';
import 'package:storeappv2/app/form_product/presentacion/bloc/form_product_bloc.dart';
import 'package:storeappv2/app/home/data/repository/home_repository_impl.dart';
import 'package:storeappv2/app/home/domain/repository/home_repository.dart';
import 'package:storeappv2/app/home/domain/use_case/delete_products_use_case.dart';
import 'package:storeappv2/app/home/domain/use_case/get_products_use_case.dart';
import 'package:storeappv2/app/home/presentacion/bloc/home_bloc.dart';
import 'package:storeappv2/app/login/data/repository/login_repository_imp.dart';
import 'package:storeappv2/app/login/domain/repository/login_repository.dart';
import 'package:storeappv2/app/login/domain/use_case/login_use_case.dart';
import 'package:storeappv2/app/login/presentacion/bloc/login_bloc.dart';
import 'package:storeappv2/app/sing_up/data/repository/form_sing_up_repository_imp.dart';
import 'package:storeappv2/app/sing_up/domain/repository/form_sing_up_repository.dart';
import 'package:storeappv2/app/sing_up/domain/use_case/add_user_use_case.dart';
import 'package:storeappv2/app/sing_up/domain/use_case/get_user_use_case.dart';
import 'package:storeappv2/app/sing_up/domain/use_case/update_user_use_case.dart';
import 'package:storeappv2/app/sing_up/presentacion/bloc/form_sing_up_bloc.dart';
import 'package:storeappv2/app/users/data/repository/users_repository_impl.dart';
import 'package:storeappv2/app/users/domain/repository/users_repository.dart';
import 'package:storeappv2/app/users/domain/use_case/get_users_use_case.dart';
import 'package:storeappv2/app/users/presentacion/bloc/users_bloc.dart';

final class DependecyInjection {
  DependecyInjection._();

  static final serviceLocator = GetIt.instance;

  static setup() {
    serviceLocator.registerSingleton<Dio>(Dio());
    serviceLocator.registerFactory<ProductService>(
      () => ProductService(dio: serviceLocator.get()),
    );
    serviceLocator.registerFactory<LoginRepository>(() => LoginRepositoryImp());
    serviceLocator.registerFactory<LoginUseCase>(
      () => LoginUseCase(loginRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<LoginBloc>(
      () => LoginBloc(loginUseCase: serviceLocator.get()),
    );

    serviceLocator.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(productService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<GetProductsUseCase>(
      () => GetProductsUseCase(homeRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<DeleteProductsUseCase>(
      () => DeleteProductsUseCase(homeRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<HomeBloc>(
      () => HomeBloc(
        getProductsUseCase: serviceLocator.get(),
        deleteProductsUseCase: serviceLocator.get(),
        logOutUseCase: serviceLocator.get(),
      ),
    );
    ////logout
    serviceLocator.registerFactory<SessionRepository>(
      () => SessionRepositoryImpl(),
    );
    serviceLocator.registerFactory<LogOutUseCase>(
      () => LogOutUseCase(sessionRepository: serviceLocator.get()),
    );

    serviceLocator.registerFactory<FormProductRepository>(
      () => FormProductRepositoryImpl(productService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<AddProductUseCase>(
      () => AddProductUseCase(formProductRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<GetProductUseCase>(
      () => GetProductUseCase(formProductRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<UpdateProductUseCase>(
      () => UpdateProductUseCase(formProductRepository: serviceLocator.get()),
    );

    //SING UP
    serviceLocator.registerFactory<SingUpService>(
      () => SingUpService(dio: serviceLocator.get()),
    );
    serviceLocator.registerFactory<FormSingUpRepository>(
      () => FormSingUpRepositoryImp(singUpService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<AddUserUseCase>(
      () => AddUserUseCase(formSingUpRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<GetUserUseCase>(
      () => GetUserUseCase(formSingUpRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<UpdateUserUseCase>(
      () => UpdateUserUseCase(formSingUpRepository: serviceLocator.get()),
    );

    serviceLocator.registerFactory<FormProductBloc>(
      () => FormProductBloc(
        addProductUseCase: serviceLocator.get(),
        getProductUseCase: serviceLocator.get(),
        updateProductUseCase: serviceLocator.get(),
      ),
    );

    //SING UP
    serviceLocator.registerFactory<FormSingUpBloc>(
      () => FormSingUpBloc(
        addUserUseCase: serviceLocator.get(),
        getUserUseCase: serviceLocator.get(),
        updateUserUseCase: serviceLocator.get(),
      ),
    );
    //USeRS
    serviceLocator.registerFactory<UsersService>(
      () => UsersService(dio: serviceLocator.get()),
    );
    serviceLocator.registerFactory<UsersRepository>(
      () => UsersRepositoryImpl(usersService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<GetUsersUseCase>(
      () => GetUsersUseCase(usersRepository: serviceLocator.get()),
    );

    serviceLocator.registerFactory<UsersBloc>(
      () => UsersBloc(
        getUsersUseCase: serviceLocator.get(),      
      ),
    );
  }
}
