import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apple_market/data/models/product.dart';

class ProductDetailViewModel extends StateNotifier<Product> {
  ProductDetailViewModel(super.product);

  void toggleLike() {
    final updated = state.copyWith(isLiked: !state.isLiked);
    state = updated;
  }
}
