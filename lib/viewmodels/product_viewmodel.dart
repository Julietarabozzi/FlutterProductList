import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ValueNotifier<bool> hasSearched = ValueNotifier<bool>(false);

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    var url = Uri.parse('https://dummyjson.com/products');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var productsData = jsonDecode(response.body);
      if (productsData is Map<String, dynamic> && productsData.containsKey('products')) {
        _products = List<Product>.from((productsData['products'] as List).map((product) => Product.fromJson(product)));
      }
    } else {
      throw Exception('Failed to load products');
    }

    _isLoading = false;
    hasSearched.value = false; // Agregamos esta línea
    notifyListeners();
  }

  Future<void> searchProducts(String searchTerm) async {
    _isLoading = true;
    notifyListeners();

    var url = Uri.parse('https://dummyjson.com/products/search?q=$searchTerm');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var productsData = jsonDecode(response.body);
      if (productsData is Map<String, dynamic> && productsData.containsKey('products')) {
        _products = List<Product>.from((productsData['products'] as List).map((product) => Product.fromJson(product)));
      }
    } else {
      throw Exception('Failed to load products');
    }

    _isLoading = false;
    hasSearched.value = true; // Agregamos esta línea
    notifyListeners();
  }

  Future<Product?> fetchProductById(int id) async {
    _isLoading = true;
    notifyListeners();

    var url = Uri.parse('https://dummyjson.com/products/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        var productData = Product.fromJson(jsonDecode(response.body));
        _isLoading = false;
        notifyListeners();
        return productData;
      } catch (e) {
        print(e);
        _isLoading = false;
        notifyListeners();
        return null;
      }
    } else {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load product');
    }
  }

  ProductViewModel() {
    fetchProducts();
  }
}
