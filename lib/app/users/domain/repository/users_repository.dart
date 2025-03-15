import 'package:storeappv2/app/core/domain/entity/users_entity.dart';

abstract class UsersRepository {

  Future<List<UsersEntity>> getUsers(); 
}