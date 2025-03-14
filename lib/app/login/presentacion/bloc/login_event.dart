sealed class LoginEvent {}

final class EmailChangeEvent extends LoginEvent {
  final String email;
  EmailChangeEvent({required this.email});
}

final class PasswordChangeEvent extends LoginEvent {
  final String password;
  PasswordChangeEvent({required this.password});
}

final class SubmitEvent extends LoginEvent {
  SubmitEvent();
}

