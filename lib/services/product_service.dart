import 'package:http/http.dart' as http;
import 'package:prueba_json/models/product.dart';

class ProductService {
  Future<Products> searchProducts(String query) async {
    var url = Uri.parse('https://dummyjson.com/products/search?q=$query');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return productsFromJson(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
