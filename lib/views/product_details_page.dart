import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../viewmodels/product_viewmodel.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title),
          backgroundColor: const Color(0xFF9E007E),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(product.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Image.network(product.thumbnail),
              const SizedBox(height: 20),
              Text(product.description, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Text('USD${product.price}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Consumer<ProductViewModel>(
                builder: (context, viewModel, child) => Text('Stock: ${product.stock}', style: const TextStyle(fontSize: 20)),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9E007E), // Set the color of the button to purple
                  ),
                  onPressed: () {
                    Provider.of<ProductViewModel>(context, listen: false).decreaseStock(product);
                  },
                  child: const Text('Add to Cart'),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

