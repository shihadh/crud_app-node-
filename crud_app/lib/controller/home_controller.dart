import 'package:crud_app/model/product_model.dart';
import 'package:crud_app/service/product_service.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier{

  ProductService productService = ProductService();

  List<ProductModel> product = [];

  Future<void>getProduct()async{
    product = await productService.getProduct();
  }
}