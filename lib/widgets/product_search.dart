import 'package:flogg_project/data/product_repository.dart';
import 'package:flogg_project/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

import 'package:flogg_project/models/product.dart';


class ProductSearchDelegate extends SearchDelegate<Product?> {
  final _repo = ProductRepository();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final base = Theme.of(context);
    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.mainSub),
        border: InputBorder.none,
      ),
      textTheme: base.textTheme,
    );
  }

  @override
  String get searchFieldLabel => '상품명 또는 카테고리 검색';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear, color: AppColors.main),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: AppColors.main),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _repo.search(query);
    return _buildGrid(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = _repo.search(query);
    if (query.isEmpty) {
      return _HintView();
    }
    if (results.isEmpty) {
      return const _EmptyView();
    }
    return _buildGrid(context, results);
  }

  Widget _buildGrid(BuildContext context, List<Product> list) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.55,
      ),
      itemCount: list.length,
      itemBuilder: (_, i) {
        final p = list[i];
        return ProductCard(name: p.name, price: p.price, asset: p.image);
      },
    );
  }
}

class _HintView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '예) “수국”, “Red”, “Best”',
        style: TextStyle(color: AppColors.mainSub, fontSize: 20),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '검색 결과가 없습니다.',
        style: TextStyle(color: AppColors.mainSub, fontSize: 14),
      ),
    );
  }
}
