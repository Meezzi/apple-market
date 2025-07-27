import 'package:apple_market/data/models/product.dart';
import 'package:apple_market/features/product/presentation/view_models/product_detail_view_model.dart';
import 'package:apple_market/util/load_products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsProvider = FutureProvider((ref) async {
  return await loadProducts();
});

final productDetailViewModelProvider = StateNotifierProvider.autoDispose
    .family<ProductDetailViewModel, Product, Product>(
      (ref, product) => ProductDetailViewModel(product),
    );
