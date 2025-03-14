import 'package:storeappv2/app/core/domain/entity/product_entity.dart';
import 'package:storeappv2/app/form_product/domain/repository/form_product_repository.dart';
import 'package:storeappv2/app/form_product/presentacion/model/form_product_form_model.dart';

class GetProductUseCase {
  final FormProductRepository formProductRepository;
  
  GetProductUseCase({required this.formProductRepository});

  Future<ProductFormModel> invoke(String id) async{
    try {

final ProductEntity data= await formProductRepository.getProduct(id);

      return ProductFormModel(id: data.id, name: data.name, price: data.price.toString(), urlImage: data.image);
    } catch (e) {
      throw (Exception());
    }
  }
}
