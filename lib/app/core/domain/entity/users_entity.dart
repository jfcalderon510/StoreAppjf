import 'package:storeappv2/app/core/data/remote/dto/users_data_model.dart';
import 'package:storeappv2/app/users/presentacion/model/users_model.dart';

final class UsersEntity {
  final String id;
  final String name;
  final String document;
  final String user;
  final String password;
  final String image;

  UsersEntity({
    required this.id,
    required this.name,
    required this.document,
    required this.user,
    required this.password,
    required this.image,
  });

   UserModel toUsersModel() {
    return UserModel(
      id: id,
      name: name,
      document: document,
      user: user,
      password: password,
      image: image,
    );
  }

  UsersDataModel toUsersDataModel() {
    return UsersDataModel(
      id: id,
      name: name,
      document: document,
      user: user,
      image: image,
      password: password
    );
  }
}
