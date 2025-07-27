import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apple_market/data/models/product.dart';
import 'package:apple_market/util/load_products.dart';

class ProductListViewModel extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    final products = await loadProducts();
    return products;
  }

  void toggleLike(int index) {
    final current = state.value ?? [];
    final updated = [...current];
    final product = updated[index];
    updated[index] = product.copyWith(
      isLiked: !product.isLiked,
      likes: product.isLiked ? product.likes - 1 : product.likes + 1,
    );
    state = AsyncData(updated);
  }

  void removeAt(int index) {
    final current = state.value ?? [];
    final updated = [...current]..removeAt(index);
    state = AsyncData(updated);
  }

  void toggleLikeByProduct(Product product) {
    final current = state.value ?? [];
    final index = current.indexWhere((p) => p.title == product.title);
    if (index != -1) toggleLike(index);
  }
}
