import 'package:apple_market/data/models/product.dart';
import 'package:apple_market/features/product/presentation/pages/product_detail_page.dart';
import 'package:apple_market/features/product/presentation/widgets/floating_button.dart';
import 'package:apple_market/features/product/presentation/widgets/product_card.dart';
import 'package:apple_market/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingButton(
        showScrollToTopButton: _showScrollToTopButton,
        scrollController: _scrollController,
      ),
      body: asyncProducts.when(
        data: (products) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.separated(
            controller: _scrollController,
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

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final shouldShow = _scrollController.offset > 0;
    if (_showScrollToTopButton != shouldShow) {
      setState(() => _showScrollToTopButton = shouldShow);
    }
  }

  void showNotificationSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
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
