import 'package:storeappv2/app/core/domain/entity/sing_up_entity.dart';
import 'package:storeappv2/app/sing_up/domain/repository/form_sing_up_repository.dart';
import 'package:storeappv2/app/sing_up/presentacion/model/form_sing_up_form_model.dart';

class GetUserUseCase {
  final FormSingUpRepository formSingUpRepository;
  
  GetUserUseCase({required this.formSingUpRepository});

  Future<SingUpFormModel> invoke(String id) async{
    try {

final SingUpEntity data= await formSingUpRepository.getUser(id);

      return SingUpFormModel(id: data.id, name: data.name, document: data.document,user: data.user, password: data.password, image: data.image);
    } catch (e) {
      throw (Exception());
    }
  }
}
