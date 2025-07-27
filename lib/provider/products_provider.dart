import 'package:apple_market/util/load_products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsProvider = FutureProvider((ref) async {
  return await loadProducts();
});
