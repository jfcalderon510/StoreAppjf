import 'package:storeappv2/app/core/data/remote/services/sing_up_service.dart';
import 'package:storeappv2/app/core/domain/entity/sing_up_entity.dart';
import 'package:storeappv2/app/sing_up/domain/repository/form_sing_up_repository.dart';

class FormSingUpRepositoryImp implements FormSingUpRepository {
  final SingUpService singUpService;

  FormSingUpRepositoryImp({required this.singUpService});

  @override
  Future<bool> addUser(SingUpEntity singUpEntity) {
    try {
      return singUpService.add(singUpEntity.toSingUpDataModel());
    } catch (e) {
      throw (Exception());
    }
  }

  @override
  Future<SingUpEntity> getUser(String id) async {
    try {
      final response = await singUpService.get(id);
      return response.toEntity();
    } catch (e) {
      throw (Exception);
    }
    // throw UnimplementedError();
  }

  @override
  Future<bool> updateUser(SingUpEntity data) {
   
    try {
      return singUpService.update(data.toSingUpDataModel());
    } catch (e) {
      throw (Exception());
    }
  }
}
