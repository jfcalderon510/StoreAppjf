
import 'package:storeappv2/app/core/data/remote/services/product_service.dart';
import 'package:storeappv2/app/core/domain/entity/product_entity.dart';
import 'package:storeappv2/app/form_product/domain/repository/form_product_repository.dart';


class FormProductRepositoryImpl implements FormProductRepository {
  final ProductService productService;


  FormProductRepositoryImpl({required this.productService});

  @override
  Future<bool> addProduct(ProductEntity productEntity) {
    try {
      
    return productService.add(productEntity.toProductDataModel());
    } catch (e) {
      throw(Exception());
    }
  }

  @override
  Future<ProductEntity> getProduct(String id) async {
   try {
     final response = await productService.get(id);
     return response.toEntity();
   } catch (e) {
     throw(Exception);
   }
 // throw UnimplementedError();
  }
  
  @override
  Future<bool> updateProduct(ProductEntity data) {
    // TODO: implement updateProduct   
    try {
      
    return productService.update(data.toProductDataModel());
    } catch (e) {
      throw(Exception());
    }
  }
}