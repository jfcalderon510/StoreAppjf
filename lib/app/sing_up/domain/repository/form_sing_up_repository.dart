import 'package:storeappv2/app/core/domain/entity/sing_up_entity.dart';

abstract class FormSingUpRepository {

  Future<bool> addUser(SingUpEntity singUpEntity);
  Future<SingUpEntity> getUser(String id);
  Future<bool> updateUser(SingUpEntity data);
  
}