import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/repositories/product_repository.dart';

enum AppState { loading, success, error }

class ProductViewModel extends ChangeNotifier {
  final ProductRepository repository;

  ProductViewModel(this.repository);

  AppState state = AppState.loading;
  List<Product> products = [];
  String errorMessage = '';

  Future<void> loadProducts() async {
    state = AppState.loading;
    notifyListeners();

    try {
      products = await repository.getProducts();
      state = AppState.success;
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
      state = AppState.error;
    } finally {
      notifyListeners();
    }
  }
}