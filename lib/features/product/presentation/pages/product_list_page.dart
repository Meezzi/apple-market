import 'package:apple_market/data/models/product.dart';
import 'package:apple_market/features/product/presentation/pages/product_detail_page.dart';
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

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required bool showScrollToTopButton,
    required ScrollController scrollController,
  }) : _showScrollToTopButton = showScrollToTopButton,
       _scrollController = scrollController;

  final bool _showScrollToTopButton;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _showScrollToTopButton ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!, width: 2),
        ),
        child: FloatingActionButton(
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          },
          backgroundColor: Colors.white,
          elevation: 2,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_upward, color: Colors.grey),
        ),
      ),
    );
  }
}
