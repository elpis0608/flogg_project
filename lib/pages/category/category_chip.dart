import 'package:flogg_project/theme/category_color.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = kCategoryColors[label] ?? AppColors.primary;
    final bg = isSelected ? accent : AppColors.background;
    final fg = isSelected
        ? (label == 'White' ? AppColors.mainSub : Colors.white)
        : AppColors.mainSub;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? accent : AppColors.mainSub),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: fg,
            ),
          ),
        ),
      ),
    );
  }
}
