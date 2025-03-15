
class UsersModel {
  final List<UserModel> products;

  UsersModel({required this.products});

  UsersModel copyWith({List<UserModel>? products}) {
    return UsersModel(products: products ?? this.products);
  }
}

class UserModel {
  final String id;
  final String name;
  final String document;
  final String user;
  final String password;
  final String image;

  UserModel({
    required this.id,
    required this.name,
    required this.document,
    required this.user,
    required this.password,
     required this.image,
  });
  
}

