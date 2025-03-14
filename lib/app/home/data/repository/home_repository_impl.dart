import 'package:storeappv2/app/core/data/remote/services/product_service.dart';
import 'package:storeappv2/app/core/domain/entity/product_entity.dart';
import 'package:storeappv2/app/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
 
 final ProductService productService;

  HomeRepositoryImpl({required this.productService});

  @override
 Future<bool> deleteProduct(String id) {
    // TODO: implement deletePProduct
   

    try {
       return productService.delete(id);
    } catch (e) {
      //throw UnimplementedError();
      throw(Exception(e));
    }   
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    
    final List<ProductEntity> products=[];

    try{
      final response = await productService.getAll();
      for(var element in response){
      products.add(element.toEntity());
      }
    }catch(e){
      throw(Exception(e));
    }
    return products;
    
  }
}
