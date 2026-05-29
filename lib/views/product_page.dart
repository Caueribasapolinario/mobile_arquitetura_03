import 'package:flutter/material.dart';
import '../viewmodels/product_viewmodel.dart';
import 'product_details_page.dart';

class ProductPage extends StatefulWidget {
  final ProductViewModel viewModel;

  const ProductPage({super.key, required this.viewModel});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          if (widget.viewModel.state == AppState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.viewModel.state == AppState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text(widget.viewModel.errorMessage, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: widget.viewModel.loadProducts,
                    child: const Text('Tentar Novamente'),
                  )
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: widget.viewModel.products.length,
            itemBuilder: (context, index) {
              final product = widget.viewModel.products[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: product.image.isNotEmpty
                      ? Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover)
                      : const Icon(Icons.image),
                  title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}