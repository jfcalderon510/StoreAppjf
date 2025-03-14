sealed class HomeEvent {
  
}

final class GetProductsEvent extends HomeEvent {
 GetProductsEvent();
}

final class DeleteProductEven extends HomeEvent {
  final String id;
 DeleteProductEven({required this.id});
}

final class LogOutEvent extends HomeEvent {  
 LogOutEvent();
}



