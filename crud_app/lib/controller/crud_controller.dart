import 'dart:developer';

import 'package:crud_app/model/product_model.dart';
import 'package:crud_app/service/product_service.dart';
import 'package:flutter/material.dart';

class CrudController extends ChangeNotifier{

  ProductService productService = ProductService();
  TextEditingController nameController = TextEditingController();
  TextEditingController prizeController = TextEditingController();
  TextEditingController updatNameController = TextEditingController();
  TextEditingController updatePrizeController = TextEditingController();

  Future<(bool,String)> addProdect(String name, String prize)async{

    if(name.isNotEmpty || prize.isNotEmpty){
      final product = ProductModel(name: name, prize: prize);
      final status = await productService.addProduct(product);
      clear();
      return (status,'sucess');
    }
    log("empty");
    clear();
    notifyListeners();

    return (false, 'name or prize is empty');
  }

  Future<(bool,String)> updateProdect(String name, String prize , int id)async{

    if(name.isNotEmpty || prize.isNotEmpty){
      final product = ProductModel(id: id, name: name, prize: prize);
      final status = await productService.uopdateProduct(product, id.toString());
      return (status,'sucess');
    }
    log("empty");
    return (false, 'name or prize is empty');

  }

  Future<(bool,String)> deleteProdect(String id)async{

      final status = await productService.dalateProduct(id.toString());
      return (status,'sucess');
    
  }

  void clear(){
    nameController.clear();
    prizeController.clear();
  }

  @override
  void dispose(){
    nameController.dispose();
    prizeController.dispose();
    updatNameController.dispose();
    updatePrizeController.dispose();
    super.dispose();
  
    
  }
}