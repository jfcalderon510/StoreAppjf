import 'package:storeappv2/app/login/domain/entity/login_entity.dart';

abstract class LoginRepository {
  Future<bool> login(LoginEntity LoginEntity);
}
