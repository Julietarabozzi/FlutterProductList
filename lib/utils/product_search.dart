import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_json/viewmodels/product_viewmodel.dart';

class ProductSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) {
        final suggestions = viewModel.products.where((product) {
          return product.title.toLowerCase().contains(query.toLowerCase());
        }).toList();

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: SizedBox(
                width: 100.0,
                height: 100.0,
                child: Image.network(
                  suggestions[index].thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text('${suggestions[index].title} ${suggestions[index].description}'),
              subtitle: Text(suggestions[index].description),
              onTap: () {
                query = suggestions[index].title;
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}
