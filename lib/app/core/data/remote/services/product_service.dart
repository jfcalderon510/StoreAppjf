import 'package:dio/dio.dart';
//import 'package:flutter/widgets.dart';
import 'package:storeappv2/app/core/data/remote/dto/product_data_model.dart';

final class ProductService {
  final Dio dio;
  final String _baseUrl = "https://storeappdamojf-default-rtdb.firebaseio.com";

  ProductService({required this.dio});

  Future<List<ProductDataModel>> getAll() async {
    final List<ProductDataModel> products = [];

    try {
      final Response<Map> response = await dio.get("$_baseUrl/products.json");
      //   print(response);
      if (response.data != null) {
        response.data?.forEach((key, value) {
          products.add(ProductDataModel.fromJson(key, value));
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
      await dio.delete("$_baseUrl/products/$id.json");
    } catch (e) {
      throw (Exception("$e"));
      //return false;
    }
    return true;
  }

  Future<bool> add(ProductDataModel productDataModel) async {
    try {
      await dio.post("$_baseUrl/products.json", data: productDataModel.toJson());
    } catch (e) {
      throw (Exception(e));
    }
    return true;
  }

  Future<ProductDataModel> get(String id) async {
    late final ProductDataModel product;
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        "$_baseUrl/products/$id.json",
      );
      if (response.data != null) {
        product = ProductDataModel.fromJson(id, response.data!);
      }
    } catch (e) {
      throw (Exception(e));
    }
    return product;
  }

  Future<bool> update(ProductDataModel productDataModel) async{
    try {
      await dio.patch("$_baseUrl/products/${productDataModel.id}.json", data: productDataModel.toJson());
    } catch (e) {
      throw(Exception);
    }
    return true;
  }
}
