import 'package:crud_app/controller/home_controller.dart';
import 'package:crud_app/screen/add_screen.dart';
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
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<HomeController>(
        builder: (context, value, child) {
          if (value.product.isEmpty) {
            return const Center(
              child: Text("Product is empty"),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: value.product.length,
            itemBuilder: (context, index) {
              final product = value.product[index];
              return Card(
                child: ListTile(
                  title: Text(product.name ?? ''),
                  subtitle: Text(product.prize ?? ''),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
