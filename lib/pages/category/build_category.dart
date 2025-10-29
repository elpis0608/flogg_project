import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

class CategoryItem {
  final String name;
  final String asset;

  const CategoryItem({required this.name, required this.asset});
}

class CategoryGrid extends StatelessWidget {
  final List<CategoryItem> items;
  final void Function(String name) onTap;

  const CategoryGrid({super.key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 5,
      crossAxisSpacing: 10,
      childAspectRatio: 0.78,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: items
          .map((item) => _CategoryTile(item: item, onTap: onTap))
          .toList(),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final CategoryItem item;
  final void Function(String name) onTap;

  const _CategoryTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(item.name),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(item.asset, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.main,
            ),
          ),
        ],
      ),
    );
  }
}
