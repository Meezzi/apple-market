import 'package:apple_market/data/models/product.dart';
import 'package:apple_market/util/format_price.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onLongPress,
  });

  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/product_images/${product.imageFile}.png',
                width: 100,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${formatPrice(product.price)} 원',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ProductStatus(
                        iconData: Icons.chat_bubble_outline_rounded,
                        content: '${product.chats}',
                      ),

                      const SizedBox(width: 8),

                      ProductStatus(
                        iconData: Icons.favorite_border,
                        content: '${product.likes}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class ProductStatus extends StatelessWidget {
  const ProductStatus({
    super.key,
    required this.iconData,
    required this.content,
  });

  final IconData iconData;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, size: 16),
        const SizedBox(width: 4),
        Text(content),
      ],
    );
  }
}
