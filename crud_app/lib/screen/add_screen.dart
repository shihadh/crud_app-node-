import 'package:crud_app/controller/add_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AddController>(
          builder: (context, value, child) =>
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: value.nameController,
                decoration: InputDecoration(
                  hint: Text("name")
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: value.prizeController,
                decoration: InputDecoration(
                  hint: Text("prize")
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: ()async{
                final (status, messege) = await value.addProdect(value.nameController.text.trim(), value.prizeController.text.trim());
                status == true ?
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messege), backgroundColor: Colors.green,)) :
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messege), backgroundColor: Colors.red,)); 
              }, child: Text("submit"))
            ],
          ),
        ),
      ),
    );
  }
}