import 'package:shared_preferences/shared_preferences.dart';
import '../../models/product.dart';

class LocalDataSource {
  static const String cacheKey = 'CACHED_PRODUCTS_V2';

  Future<void> cacheProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = Product.encodeList(products);
    await prefs.setString(cacheKey, jsonString);
  }

  Future<List<Product>> getCachedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(cacheKey);
    
    if (jsonString != null) {
      return Product.decodeList(jsonString);
    } else {
      throw Exception('Nenhum cache disponível');
    }
  }
}