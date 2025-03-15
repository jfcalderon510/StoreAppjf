import 'package:dio/dio.dart';
import 'package:storeappv2/app/core/data/remote/dto/users_data_model.dart';

final class UsersService {
  final Dio dio;
  final String _baseUrl = "https://storeappdamojf-default-rtdb.firebaseio.com";

  UsersService({required this.dio});

  Future<List<UsersDataModel>> getAll() async {
    final List<UsersDataModel> products = [];

    try {
      final Response<Map> response = await dio.get("$_baseUrl/users.json");
     // print(response);
     
      if (response.data != null) {
        response.data?.forEach((key, value) {
          products.add(UsersDataModel.fromJson(key, value));
        });
      }
    } catch (e) {
      print("err:$e");
      throw Exception("Error: $e");
    }
    return products;
  }   

  Future<UsersDataModel> get(String id) async {
    late final UsersDataModel product;
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        "$_baseUrl/users/$id.json",
      );
      if (response.data != null) {
        product = UsersDataModel.fromJson(id, response.data!);
      }
    } catch (e) {
      throw (Exception(e));
    }
    return product;
  }
}
