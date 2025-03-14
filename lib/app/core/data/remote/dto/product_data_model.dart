import 'package:storeappv2/app/core/domain/entity/product_entity.dart';

class ProductDataModel {
  final String id;
  late final String name;
  late final int price;
  late final String imageUrl;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  ProductDataModel.fromJson(String this.id, Map<String, dynamic> json) {
    name = json["name"];
    price = json["price"];
    imageUrl = json["imgUrl"];
  }

  ProductEntity toEntity() {
    return ProductEntity(id: id, name: name, image: imageUrl, price: price);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"name": name, "price": price, "imgUrl": imageUrl};
  }
}
