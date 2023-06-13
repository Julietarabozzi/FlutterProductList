import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_json/viewmodels/product_viewmodel.dart';
import 'package:prueba_json/views/product_details_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  void _searchProduct(BuildContext context, ProductViewModel viewModel) {
    String searchTerm = _searchController.text;
    if (searchTerm.isNotEmpty) {
      viewModel.searchProducts(searchTerm);
    } else {
      viewModel.fetchProducts(); // This will fetch all products when search field is empty
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Challenge'),
        backgroundColor: const Color(0xFF9E007E),
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => _searchProduct(context, viewModel),
                  decoration: const InputDecoration(
                    labelText: "Search",
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(viewModel.products[index].title),
                            ),
                            Text('USD${viewModel.products[index].price}')
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              viewModel.products[index].brand,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(viewModel.products[index].description),
                            Text('Stock: ${viewModel.products[index].stock}')
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                product: viewModel.products[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
