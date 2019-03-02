import 'package:flutter/material.dart';

import '../widgets/helpers/ensure_visible.dart';
import '../models/product.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int productIndex;

  ProductEditPage({
    this.addProduct,
    this.updateProduct,
    this.product,
    this.productIndex,
  });

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();

  Widget _buildTitleTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        initialValue: widget.product == null ? '' : widget.product.title,
        decoration: InputDecoration(labelText: 'Product Title'),
        validator: (String value) {
          return (value.isEmpty || value.length < 5)
              ? 'Title is required and should be 5+ characters long'
              : null;
        },
        onSaved: (String value) => _formData['title'] = value,
      ),
    );
  }

  Widget _buildDescriptionTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        initialValue: widget.product == null ? '' : widget.product.description,
        decoration: InputDecoration(labelText: 'Product Description'),
        maxLines: 4,
        validator: (String value) {
          return (value.isEmpty || value.length < 10)
              ? 'Title is required and should be 10+ characters long'
              : null;
        },
        onSaved: (String value) => _formData['description'] = value,
      ),
    );
  }

  Widget _buildPriceTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        initialValue:
            widget.product == null ? '' : widget.product.price.toString(),
        decoration: InputDecoration(labelText: 'Product Price'),
        keyboardType: TextInputType.number,
        validator: (String value) {
          return (!RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value))
              ? 'Price is required and should be a number'
              : null;
        },
        onSaved: (String value) => _formData['price'] = double.parse(value),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    if (widget.product == null) {
      widget.addProduct(Product(
        title: _formData['title'],
        description: _formData['description'],
        price: _formData['price'],
        image: _formData['image'],
      ));
    } else {
      widget.updateProduct(
          widget.productIndex,
          Product(
            title: _formData['title'],
            description: _formData['description'],
            price: _formData['price'],
            image: _formData['image'],
          ));
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildPageContent() {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.95;
    final targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        width: targetWidth,
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(height: 10.0),
              RaisedButton(
                textColor: Colors.white,
                child: Text('Submit'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.product == null
        ? _buildPageContent()
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: _buildPageContent(),
          );
  }
}
