
import 'package:flogg_project/pages/detail/detail_page.dart';
import 'package:flogg_project/widgets/product_card.dart';
import 'package:flutter/material.dart';


class ProductItem {
  final String name;
  final int price;
  final String asset;
  final List<dynamic> meanings;

  const ProductItem({
    required this.name,
    required this.price,
    required this.asset,
    this.meanings = const [],
  });
}

class ProductGrid extends StatelessWidget {
  final List<ProductItem> items;
  final EdgeInsets padding;

  const ProductGrid({
    super.key,
    required this.items,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.55,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final p = items[i];
        return ProductCard(
          name: p.name,
          price: p.price,
          asset: p.asset,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailPage(name: p.name,
          price: p.price,
          image: p.asset,)),
            );
          },
        );
      },
    );
  }
}
