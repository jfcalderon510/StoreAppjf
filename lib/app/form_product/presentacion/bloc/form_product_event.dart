sealed class FormProductEvent {}

final class NameChangeEvent extends FormProductEvent {
  final String name;
  NameChangeEvent({required this.name});
}

final class PriceChangeEvent extends FormProductEvent {
  final String price;
  PriceChangeEvent({required this.price});
}

final class UrlImageChangeEvent extends FormProductEvent {
  final String urlImage;
  UrlImageChangeEvent({required this.urlImage});
}

final class SubmitEvent extends FormProductEvent {
  SubmitEvent();
}

final class GetProductEvent extends FormProductEvent {
  final String id;
  GetProductEvent(this.id);
  //SubmitEvent();
}

