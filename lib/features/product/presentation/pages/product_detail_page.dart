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
    final asyncProducts = ref.watch(productListViewModelProvider);

    return asyncProducts.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(body: Center(child: Text('에러 발생: $error'))),
      data: (products) {
        final currentProduct = products.firstWhere(
          (p) => p.title == product.title,
        );

        return Scaffold(
          appBar: AppBar(title: Text('상품 상세')),
          bottomNavigationBar: ProductBottomBar(
            price: currentProduct.price,
            isLiked: currentProduct.isLiked,
            onLikedTap: () {
              ref
                  .read(productListViewModelProvider.notifier)
                  .toggleLikeByProduct(currentProduct);
            },
            onChatTap: () {
              showNotificationSnackBar(context, '준비 중입니다.');
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/product_images/${currentProduct.imageFile}.png',
                  width: double.infinity,
                  height: 260,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SellerInfo(product: currentProduct),
                      Divider(height: 2, thickness: 2, color: Colors.grey[500]),
                      SizedBox(height: 8),
                      ProductInfo(product: currentProduct),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
