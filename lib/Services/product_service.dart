import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
Future<List<Product>> fetchProducts() async {
  var url = Uri.parse('https://dummyjson.com/products');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var productsData = jsonDecode(response.body);
    if (productsData is Map<String, dynamic> && productsData.containsKey('products')) {
      return List<Product>.from((productsData['products'] as List).map((product) => Product.fromJson(product)));
    } else {
      throw Exception('Failed to parse products');
    }
  } else {
    throw Exception('Failed to load products');
  }
}


  Future<List<Product>> searchProducts(String searchTerm) async {
    var url = Uri.parse('https://dummyjson.com/products/search?q=$searchTerm');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var productsData = jsonDecode(response.body);
      if (productsData is Map<String, dynamic> && productsData.containsKey('products')) {
        return List<Product>.from((productsData['products'] as List).map((product) => Product.fromJson(product)));
    } else {
      throw Exception('Failed to load products');
    } 
  } else {
    throw Exception('Failed to load products');
  }
  }

  Future<Product?> fetchProductById(int id) async {
    var url = Uri.parse('https://dummyjson.com/products/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        var productData = Product.fromJson(jsonDecode(response.body));
        return productData;
      } catch (e) {
        print(e);
        return null;
      }
    } else {
      throw Exception('Failed to load product');
    }
  }
}