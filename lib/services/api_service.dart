import 'dart:convert';
import 'package:http/http.dart' as http;
import '../product/producto.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  /// Lab 1: GET /products?limit=XX
  Future<List<Product>> fetchProducts({int limit = 20}) async {
    final uri = Uri.parse('$_baseUrl/products?limit=$limit');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> list = data['products'];
      return list.map((jsonProd) => Product.fromJson(jsonProd)).toList();
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  /// Lab 2: GET /products/:id
  Future<Product> fetchProductById(int id) async {
    final uri = Uri.parse('$_baseUrl/products/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return Product.fromJson(data);
    } else {
      throw Exception('Producto no encontrado');
    }
  }

  /// Lab 3: GET /products/search?q=<query>
  Future<List<Product>> searchProducts(String query) async {
    final uri = Uri.parse('$_baseUrl/products/search?q=$query');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> list = data['products'];
      return list.map((jsonProd) => Product.fromJson(jsonProd)).toList();
    } else {
      throw Exception('Error en búsqueda');
    }
  }
}
