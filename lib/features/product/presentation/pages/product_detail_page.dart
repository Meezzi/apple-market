import 'package:apple_market/data/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('상품 상세')),
      body: Column(
        children: [
          Image.asset(
            'assets/product_images/${product.imageFile}.png',
            width: double.infinity,
            height: 260,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
