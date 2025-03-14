import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeappv2/app/login/domain/entity/login_entity.dart';
import 'package:storeappv2/app/login/domain/repository/login_repository.dart';

class LoginRepositoryImp implements LoginRepository {
  @override
  Future<bool> login(LoginEntity LoginEntity) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("login", true);
    return true;
  }
  
}