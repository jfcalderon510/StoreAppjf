import 'package:storeappv2/app/core/data/remote/services/users_service.dart';
import 'package:storeappv2/app/core/domain/entity/users_entity.dart';
import 'package:storeappv2/app/users/domain/repository/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
 
 final UsersService usersService;

  UsersRepositoryImpl({required this.usersService});

  @override
  Future<List<UsersEntity>> getUsers() async {
    
    final List<UsersEntity> products=[];

    try{
      final response = await usersService.getAll();
      for(var element in response){
      products.add(element.toEntity());
      }
    }catch(e){
      throw(Exception(e));
    }
    return products;
    
  }
}
