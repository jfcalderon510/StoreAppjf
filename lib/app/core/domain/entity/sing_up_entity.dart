import 'package:storeappv2/app/core/data/remote/dto/sing_up_data_model.dart';
import 'package:storeappv2/app/home/presentacion/model/sing_up_model.dart';

final class SingUpEntity {
  final String id;
  final String name;
  final String document;
  final String user;
  final String password;
  final String image;

  SingUpEntity({
    required this.id,
    required this.name,
    required this.document,
    required this.user,
    required this.password,
    required this.image,
  });

  SingUpModel toSingUpModel() {
    return SingUpModel(
      id: id,
      name: name,
      document: document,
      user: user,
      password: password,
      image: image,
    );
  }

  SingUpDataModel toSingUpDataModel() {
    return SingUpDataModel(
      id: id,
      name: name,
      document: document,
      user: user,
      password: password,
      image: image,
    );
  }
}
