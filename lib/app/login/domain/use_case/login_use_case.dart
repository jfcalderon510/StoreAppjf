import 'package:storeappv2/app/login/data/repository/login_repository_imp.dart';
import 'package:storeappv2/app/login/domain/entity/login_entity.dart';
import 'package:storeappv2/app/login/domain/repository/login_repository.dart';
import 'package:storeappv2/app/login/presentacion/model/login_form_model.dart';

class LoginUseCase {

  
  LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository}); 

  Future<bool> invoke(LoginFormModel loginFormModel) {
    final LoginEntity data = loginFormModel.toEntity();
    return loginRepository.login(data);
  }
}
