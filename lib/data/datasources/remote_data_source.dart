import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product.dart';

class RemoteDataSource {
  final String apiUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao buscar produtos da API');
    }
  }
}