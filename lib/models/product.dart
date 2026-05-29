import 'dart:convert';

class Product {
  final int id;
  final String title;
  final double price;

  Product({required this.id, required this.title, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
    };
  }

  static String encodeList(List<Product> products) => json.encode(
        products.map<Map<String, dynamic>>((product) => product.toJson()).toList(),
      );

  static List<Product> decodeList(String productsStr) =>
      (json.decode(productsStr) as List<dynamic>)
          .map<Product>((item) => Product.fromJson(item))
          .toList();
}