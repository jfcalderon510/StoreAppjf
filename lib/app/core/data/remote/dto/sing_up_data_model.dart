import 'package:storeappv2/app/core/domain/entity/sing_up_entity.dart';

class SingUpDataModel {
  final String id;
  late final String name;
  late final String document;
  late final String user;
  late final String password;
  late final String image;

  SingUpDataModel({
    required this.id,
    required this.name,
    required this.document,
    required this.user,
    required this.password,
    required this.image,
  });

  SingUpDataModel.fromJson(String this.id, Map<String, dynamic> json) {
    name = json["name"];
    document = json["price"];
    user = json["imgUrl"];
    password = json["password"];
    image = json["image"];
  }

  SingUpEntity toEntity() {
    return SingUpEntity(id: id, name: name, document: document,user: user, password: password, image: image);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"name": name, "document": document, "password": password, "image": image, "user": user};
  }
}
