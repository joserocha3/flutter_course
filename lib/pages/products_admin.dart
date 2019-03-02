import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';
import '../models/product.dart';

class ProductsAdminPage extends StatelessWidget {
  final Function _addProduct;
  final Function _deleteProduct;
  final Function _updateProduct;
  final List<Product> _products;

  ProductsAdminPage(
    this._addProduct,
    this._updateProduct,
    this._deleteProduct,
    this._products,
  );

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('All Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.list), text: 'Create Product'),
              Tab(icon: Icon(Icons.list), text: 'My Products'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductEditPage(addProduct: _addProduct),
            ProductListPage(_products, _updateProduct, _deleteProduct),
          ],
        ),
      ),
    );
  }
}
