import 'package:apple_market/data/models/product.dart';
import 'package:apple_market/features/product/presentation/widgets/product_bottom_bar.dart';
import 'package:apple_market/features/product/presentation/widgets/product_info.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('상품 상세')),
      bottomNavigationBar: ProductBottomBar(
        price: product.price,
        onChatTap: () {
          showNotificationSnackBar(context, '준비 중입니다.');
        },
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/product_images/${product.imageFile}.png',
            width: double.infinity,
            height: 260,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SellerInfo(product: product),
                Divider(height: 2, thickness: 2, color: Colors.grey[500]),
                SizedBox(height: 8),
                ProductInfo(product: product),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showNotificationSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(content), duration: Duration(seconds: 2)),
      );
  }
}

class SellerInfo extends StatelessWidget {
  const SellerInfo({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.deepOrangeAccent,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.seller,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.address,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '39.3 ℃',
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '매너온도',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
