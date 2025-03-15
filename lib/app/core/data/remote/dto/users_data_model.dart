import 'package:storeappv2/app/core/domain/entity/users_entity.dart';

class UsersDataModel {
  final String id;
  late final String name;
  late final String document;
  late final String user;  
  late final String image;
  late final String password;

  UsersDataModel({
    required this.id,
    required this.name,
    required this.document,
    required this.user,
    required this.image,
    required this.password
  });

  UsersDataModel.fromJson(String this.id, Map<String, dynamic> json) {
    name = json["name"];
    document = json["document"];
    password = json["password"];
    image = json["image"];
    user = json["user"];
  }

  UsersEntity toEntity() {
    return UsersEntity(id: id, name: name,document:document, user:user, password: password, image: image);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"name": name, "document": document, "image": image, user: user};
  }
}
