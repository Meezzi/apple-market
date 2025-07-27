import 'package:apple_market/data/models/product.dart';
import 'package:apple_market/features/product/presentation/widgets/product_bottom_bar.dart';
import 'package:apple_market/features/product/presentation/widgets/product_info.dart';
import 'package:apple_market/features/product/presentation/widgets/seller_info.dart';
import 'package:apple_market/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productDetailViewModelProvider(product));
    final viewModel = ref.read(
      productDetailViewModelProvider(product).notifier,
    );

    return Scaffold(
      appBar: AppBar(title: Text('상품 상세')),
      bottomNavigationBar: ProductBottomBar(
        price: productState.price,
        isLiked: productState.isLiked,
        onLikedTap: viewModel.toggleLike,
        onChatTap: () {
          showNotificationSnackBar(context, '준비 중입니다.');
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/product_images/${productState.imageFile}.png',
              width: double.infinity,
              height: 260,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SellerInfo(product: productState),
                  Divider(height: 2, thickness: 2, color: Colors.grey[500]),
                  SizedBox(height: 8),
                  ProductInfo(product: productState),
                ],
              ),
            ),
          ],
        ),
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
