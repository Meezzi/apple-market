import 'package:apple_market/data/models/product.dart';
import 'package:apple_market/presentation/product_detail/product_detail_view_model.dart';
import 'package:apple_market/presentation/product_list/product_list_view_model.dart';
import 'package:apple_market/util/load_products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsProvider = FutureProvider((ref) async {
  return await loadProducts();
});

final productListViewModelProvider =
    AsyncNotifierProvider<ProductListViewModel, List<Product>>(() {
      return ProductListViewModel();
    });

final productDetailViewModelProvider =
    StateNotifierProvider.family<ProductDetailViewModel, Product, Product>(
      (ref, product) => ProductDetailViewModel(product),
    );
