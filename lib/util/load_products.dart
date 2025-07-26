import 'package:apple_market/data/models/product.dart';
import 'package:flutter/services.dart';

/// CSV 파일을 읽고 Product 리스트로 변환
Future<List<Product>> loadProducts() async {
  final csvString = await rootBundle.loadString(
    'assets/data/dummy_products_data.csv',
  );
  final lines = csvString.split('\n');
  final List<Product> products = [];

  for (var i = 1; i < lines.length; i++) {
    final line = lines[i].trim();
    if (line.isEmpty) continue;

    // 쉼표로 나누고 따옴표 처리
    final values = _parseCsvLine(line);
    if (values.length >= 9) {
      products.add(Product.fromCsv(values));
    }
  }

  return products;
}

/// 한 줄의 CSV 문자열을 문자열 리스트로 파싱
List<String> _parseCsvLine(String line) {
  final List<String> result = [];
  final buffer = StringBuffer();
  bool inQuotes = false;

  for (int i = 0; i < line.length; i++) {
    final char = line[i];
    if (char == '"') {
      inQuotes = !inQuotes;
    } else if (char == ',' && !inQuotes) {
      result.add(buffer.toString());
      buffer.clear();
    } else {
      buffer.write(char);
    }
  }

  result.add(buffer.toString());
  return result;
}
