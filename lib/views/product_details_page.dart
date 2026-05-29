import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: product.image.isNotEmpty
                  ? Image.network(product.image, height: 250, fit: BoxFit.contain)
                  : const Icon(Icons.image_not_supported, size: 150),
            ),
            const SizedBox(height: 24),
            Text(
              product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'R\$ ${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            const Text(
              'Descrição do Produto',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}