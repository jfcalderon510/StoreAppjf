import 'package:dio/dio.dart';
import 'package:storeappv2/app/core/data/remote/dto/sing_up_data_model.dart';

final class SingUpService {
  final Dio dio;
  final String _baseUrl = "https://storeappdamojf-default-rtdb.firebaseio.com";

  SingUpService({required this.dio});

  Future<List<SingUpDataModel>> getAll() async {
    final List<SingUpDataModel> products = [];

    try {
      final Response<Map> response = await dio.get("$_baseUrl/users.json");
      //   print(response);
      if (response.data != null) {
        response.data?.forEach((key, value) {
          products.add(SingUpDataModel.fromJson(key, value));
        });
      }
    } catch (e) {
      //print("err:$e");
      throw Exception("Error: $e");
    }
    return products;
  }

  //eliminar productos
  Future<bool> delete(String id) async {
    try {
      await dio.delete("$_baseUrl/users/$id.json");
    } catch (e) {
      throw (Exception("$e"));
      //return false;
    }
    return true;
  }

  Future<bool> add(SingUpDataModel singUpDataModel) async {
    try {
      dio.post("$_baseUrl/users.json", data: singUpDataModel.toJson());
    } catch (e) {
      throw (Exception(e));
    }
    return true;
  }

  Future<SingUpDataModel> get(String id) async {
    late final SingUpDataModel product;
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        "$_baseUrl/users/$id.json",
      );
      if (response.data != null) {
        product = SingUpDataModel.fromJson(id, response.data!);
      }
    } catch (e) {
      throw (Exception(e));
    }
    return product;
  }

  Future<bool> update(SingUpDataModel singUpDataModel) async{
    try {
      await dio.patch("$_baseUrl/users/${singUpDataModel.id}.json", data: singUpDataModel.toJson());
    } catch (e) {
      throw(Exception);
    }
    return true;
  }
}
