import 'dart:developer';

import 'package:crud_app/model/product_model.dart';
import 'package:crud_app/service/product_service.dart';
import 'package:flutter/material.dart';

class AddController extends ChangeNotifier{
  ProductService productService = ProductService();
  TextEditingController nameController = TextEditingController();
  TextEditingController prizeController = TextEditingController();

  Future<(bool,String)> addProdect(String name, String prize)async{

    if(name.isNotEmpty || prize.isNotEmpty){
      final product = ProductModel(name: name, prize: prize);
      final status = await productService.addProduct(product);
      return (status,'sucess');
    };
    log("empty");
    return (false, 'name or prize is empty');

  }
}