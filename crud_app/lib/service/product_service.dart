import 'dart:developer';

import 'package:crud_app/model/product_model.dart';
import 'package:dio/dio.dart';

class ProductService {
  static const baseUrl = 'http://10.152.174.73:4000/api/';
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 3),
      receiveTimeout: Duration(seconds: 3),
    )
  );

  Future<bool> addProduct(ProductModel prodcut) async {
    log("message");
    final response = await dio.post("${baseUrl}add_product", data: prodcut.tojson());
    try {
      if (response.statusCode == 200) {
        log('sucess');
        return true;
      }
    } on DioException catch (e) {
      log(e.toString());
    }
      log("somthing went wrog");

    return false;
  }

  Future<List<ProductModel>> getProduct()async{
    try{
      final response = await dio.get("${baseUrl}get_product");
      if(response.statusCode == 200){
        final List data = response.data['product'];
        return data.map((e)=> ProductModel.fromjson(e)).toList();
      }
    }on DioException catch (e){
      log(e.toString());
    }
    return [];
  }
}
