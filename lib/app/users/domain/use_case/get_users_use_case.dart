import 'package:storeappv2/app/users/domain/repository/users_repository.dart';
import 'package:storeappv2/app/users/presentacion/model/users_model.dart';

class GetUsersUseCase {
  final UsersRepository usersRepository;

  GetUsersUseCase({required this.usersRepository});

  Future<List<UserModel>> invoke() async {
    final List<UserModel> products = [];

    try {
      final result = await usersRepository.getUsers();

      for (var element in result) {
        products.add(element.toUsersModel());
      }
    } catch (e) {
      throw (Exception(e));
    }
    return products;
  }
}
