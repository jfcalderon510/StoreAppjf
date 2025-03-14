import 'package:storeappv2/app/core/domain/entity/product_entity.dart';

abstract class HomeRepository {

  Future<List<ProductEntity>> getProducts();
  Future<bool>  deleteProduct(String id);  
}