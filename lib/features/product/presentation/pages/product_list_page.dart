import 'package:apple_market/data/models/product.dart';
import 'package:apple_market/features/product/presentation/pages/product_detail_page.dart';
import 'package:apple_market/features/product/presentation/widgets/product_card.dart';
import 'package:apple_market/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProducts = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('르탄동'),
        actions: [
          IconButton(
            onPressed: () => showNotificationSnackBar(context),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
        centerTitle: false,
      ),
      body: asyncProducts.when(
        data: (products) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                onTap: () => goToProductDetail(context, products[index]),
                product: products[index],
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('오류가 발생했습니다.')),
      ),
    );
  }

  void showNotificationSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('알림이 생성되었습니다.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void goToProductDetail(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetailPage(product: product)),
    );
  }
}
