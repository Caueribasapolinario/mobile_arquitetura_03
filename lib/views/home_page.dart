import 'package:flutter/material.dart';
import '../viewmodels/product_viewmodel.dart';
import 'product_page.dart';

class HomePage extends StatelessWidget {
  final ProductViewModel viewModel;

  const HomePage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja Fake API'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag_outlined, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text(
              'Bem-vindo à nossa loja!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.list),
              label: const Text('Ver Produtos'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(viewModel: viewModel),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}