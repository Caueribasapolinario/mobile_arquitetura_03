import 'package:flutter/material.dart';
import '../viewmodels/product_viewmodel.dart';

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
    widget.viewModel.loadProducts(); // Inicia a busca ao abrir a tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos (Arquitetura)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: widget.viewModel.loadProducts, // Força recarregamento
          )
        ],
      ),
      // ListenableBuilder escuta as mudanças de estado no ViewModel
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          // 1. Estado de Carregamento
          if (widget.viewModel.state == AppState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Estado de Erro
          if (widget.viewModel.state == AppState.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 60),
                    const SizedBox(height: 16),
                    Text(
                      widget.viewModel.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: widget.viewModel.loadProducts,
                      child: const Text('Tentar Novamente'),
                    )
                  ],
                ),
              ),
            );
          }

          // 3. Estado de Sucesso
          return ListView.builder(
            itemCount: widget.viewModel.products.length,
            itemBuilder: (context, index) {
              final product = widget.viewModel.products[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(product.id.toString()),
                ),
                title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}