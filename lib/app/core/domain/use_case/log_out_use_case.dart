import 'package:storeappv2/app/core/domain/repository/session_repository.dart';

final class LogOutUseCase {
  final SessionRepository sessionRepository;

  LogOutUseCase({required this.sessionRepository});

  Future<bool> invoke(){
    return sessionRepository.logout();
  }
  
}