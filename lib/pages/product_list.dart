import 'package:flutter/material.dart';

import './product_edit.dart';
import '../models/product.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> _products;
  final Function _updateProduct;
  final Function _deleteProduct;

  ProductListPage(this._products, this._updateProduct, this._deleteProduct);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage(
                product: _products[index],
                updateProduct: _updateProduct,
                productIndex: index,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(_products[index].title),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) _deleteProduct(index);
          },
          background: Container(color: Colors.red),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    _products[index].image,
                  ),
                ),
                title: Text(_products[index].title),
                subtitle: Text('\$${_products[index].price.toString()}'),
                trailing: _buildEditButton(context, index),
              ),
              Divider(),
            ],
          ),
        );
      },
      itemCount: _products.length,
    );
  }
}
