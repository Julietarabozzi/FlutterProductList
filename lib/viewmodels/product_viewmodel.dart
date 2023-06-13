import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ValueNotifier<bool> hasSearched = ValueNotifier<bool>(false);

  final ProductService _productService = ProductService();

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productService.fetchProducts();
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    hasSearched.value = false; 
    notifyListeners();
  }

  Future<void> searchProducts(String searchTerm) async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productService.searchProducts(searchTerm);
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    hasSearched.value = true;
    notifyListeners();
  }

  Future<Product?> fetchProductById(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      var product = await _productService.fetchProductById(id);
      _isLoading = false;
      notifyListeners();
      return product;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e);
      return null;
    }
  }

  void decreaseStock(Product product) {
    product.stock--;
    notifyListeners();
  }

  ProductViewModel() {
    fetchProducts();
  }
}
