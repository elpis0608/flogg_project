import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

class NamePriceRow extends StatelessWidget {
  final String name;
  final int price;
  const NamePriceRow({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.main,
          ),
        ),
        const SizedBox(height: 4),

        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _formatWon(price),
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.main,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '원',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 20,
                  color: AppColors.mainSub,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatWon(int v) {
    final s = v.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      final left = s.length - i;
      buf.write(s[i]);
      if (left > 1 && left % 3 == 1) buf.write(',');
    }
    return buf.toString();
  }
}
