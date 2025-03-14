import 'package:storeappv2/app/core/domain/entity/product_entity.dart';
import 'package:storeappv2/app/form_product/domain/repository/form_product_repository.dart';
import 'package:storeappv2/app/form_product/presentacion/model/form_product_form_model.dart';

class AddProductUseCase {


final FormProductRepository formProductRepository;
  AddProductUseCase({required this.formProductRepository});

  Future<bool> invoke(ProductFormModel productFormModel){
try {
  
    final ProductEntity data = productFormModel.toEntity();

    return formProductRepository.addProduct(data);
} catch (e) {
  throw(Exception());
}

  }

}