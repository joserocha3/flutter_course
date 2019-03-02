import 'package:flutter/material.dart';

import './product_card.dart';
import '../../models/product.dart';

class Products extends StatelessWidget {
  final List<Product> products;

  Products(this.products);

  Widget _buildProductList() {
    Widget result = Container();
    if (products.length > 0) {
      result = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(products[index], index);
        },
        itemCount: products.length,
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}
