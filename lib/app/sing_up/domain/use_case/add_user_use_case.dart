import 'package:storeappv2/app/core/domain/entity/sing_up_entity.dart';
import 'package:storeappv2/app/sing_up/domain/repository/form_sing_up_repository.dart';
import 'package:storeappv2/app/sing_up/presentacion/model/form_sing_up_form_model.dart';

class AddUserUseCase {


final FormSingUpRepository formSingUpRepository;
  AddUserUseCase({required this.formSingUpRepository});

  Future<bool> invoke(SingUpFormModel singUpFormModel){
try {
  
    final SingUpEntity data = singUpFormModel.toEntity();

    return formSingUpRepository.addUser(data);
} catch (e) {
  throw(Exception());
}

  }

}