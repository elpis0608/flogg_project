import 'package:flogg_project/pages/detail/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final String asset;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.asset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(
                  name: name,
                  price: price,
                  image: asset
                ),
              ),
            );
          },
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Hero(
                tag: asset,
                child: Image.asset(
                  asset,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),

          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.main,
            ),
          ),
          const SizedBox(height: 4),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _formatWon(price),
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.main,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '원',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mainSub,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
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
