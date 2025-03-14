sealed class FormSingUpEvent {}

final class NameChangeEvent extends FormSingUpEvent {
  final String name;
  NameChangeEvent({required this.name});
}

final class DocumentChangeEvent extends FormSingUpEvent {
  final String document;
  DocumentChangeEvent({required this.document});
}

final class UserChangeEvent extends FormSingUpEvent {
  final String user;
  UserChangeEvent({required this.user});
}

final class PasswordChangeEventSignUp extends FormSingUpEvent {
  final String password;
  PasswordChangeEventSignUp({required this.password});
}

final class ImageChangeEvent extends FormSingUpEvent {
  final String image;
  ImageChangeEvent({required this.image});
}


final class SubmitEventSignUp extends FormSingUpEvent {
  SubmitEventSignUp();
}

final class GetUserEvent extends FormSingUpEvent {
  final String id;
  GetUserEvent(this.id);
  //SubmitEvent();
}

