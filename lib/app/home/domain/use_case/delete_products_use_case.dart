import 'package:storeappv2/app/home/domain/repository/home_repository.dart';

class DeleteProductsUseCase {
  final HomeRepository homeRepository;

  DeleteProductsUseCase({required this.homeRepository});

 Future<bool> invoke(String id) async {
    
    try {
      return await homeRepository.deleteProduct(id);
    } catch (e) {
      throw(Exception());
    }
  }
}
