import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/repositories/product_repository.dart';

// Representa os estados possíveis da interface
enum AppState { loading, success, error }

class ProductViewModel extends ChangeNotifier {
  final ProductRepository repository;

  ProductViewModel(this.repository);

  AppState state = AppState.loading;
  List<Product> products = [];
  String errorMessage = '';

  Future<void> loadProducts() async {
    state = AppState.loading;
    notifyListeners(); // Avisa a UI que está carregando

    try {
      products = await repository.getProducts();
      state = AppState.success;
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
      state = AppState.error;
    } finally {
      notifyListeners(); // Avisa a UI para se reconstruir com sucesso ou erro
    }
  }
}