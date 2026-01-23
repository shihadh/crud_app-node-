import 'package:crud_app/controller/crud_controller.dart';
import 'package:crud_app/controller/home_controller.dart';
import 'package:crud_app/screen/add_screen.dart';
import 'package:crud_app/screen/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().getProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product List")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddScreen()),
          );

          if (result == true) {
            context.read<HomeController>().getProduct();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<HomeController>(
        builder: (context, value, child) {
       

          if (value.product.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => value.getProduct(),
              child: ListView(
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text("No products found")),
                ],
              ),
            );
          }


          return RefreshIndicator(
            onRefresh: () => value.getProduct(),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: value.product.length,
              itemBuilder: (context, index) {
                final product = value.product[index];

                return Card(
                  child: ListTile(
                    title: Text(product.name ?? ''),
                    subtitle: Text(product.prize ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UpdateScreen(product: product),
                              ),
                            );

                            if (result == true) {
                              context.read<HomeController>().getProduct();
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _confirmDelete(context, product.id.toString());
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Product"),
        content: const Text("Are you sure you want to delete this product?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await context.read<CrudController>().deleteProdect(id);
              context.read<HomeController>().getProduct();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
