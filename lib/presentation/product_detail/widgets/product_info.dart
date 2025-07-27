import 'package:apple_market/data/models/product.dart';
import 'package:apple_market/util/format_description.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 12),
        Text(
          formatDescription(product.description),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
