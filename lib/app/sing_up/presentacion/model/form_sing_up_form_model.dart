import 'package:storeappv2/app/core/domain/entity/sing_up_entity.dart';

final class SingUpFormModel {
  final String id;
  final String name;
  final String document;
  final String user;
  final String password;
  final String image;
  // SingUpFormModel({required this.id, required this.name, required this.price, required this.urlImage});
  SingUpFormModel({
    required this.id,
    required this.name,
    required this.document,
    required this.user,
    required this.password,
    required this.image,
  });

  SingUpFormModel copyWith({
    String? id,
    String? name,
    String? document,
    String? user,
    String? password,
    String? image,
  }) {
    return SingUpFormModel(
      id: id ?? this.id,
      name: name ?? this.name,
      document: document ?? this.document,
      user: user ?? this.user,
      password: password ?? this.password,
      image: image ?? this.image,
    );
  }

  SingUpEntity toEntity() => SingUpEntity(
    id:id,
    name: name,
    document: document,
    user: user,
    password: password,
    image: image,
  );
}
