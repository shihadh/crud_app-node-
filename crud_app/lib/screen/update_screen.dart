import 'package:crud_app/controller/crud_controller.dart';
import 'package:crud_app/controller/home_controller.dart';
import 'package:crud_app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatelessWidget {
  final ProductModel product;

  const UpdateScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final crudController = context.read<CrudController>();

    // Initialize only once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      crudController.updatNameController.text = product.name ?? '';
      crudController.updatePrizeController.text = product.prize ?? '';
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Update Product")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<CrudController>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: value.updatNameController,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: value.updatePrizeController,
                  decoration: const InputDecoration(
                    hintText: "Price",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final (status, message) =
                        await value.updateProdect(
                      value.updatNameController.text.trim(),
                      value.updatePrizeController.text.trim(),
                      product.id!,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor:
                            status ? Colors.green : Colors.red,
                      ),
                    );
                     context.read<HomeController>().getProduct();

                  },
                  child: const Text("Update"),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
