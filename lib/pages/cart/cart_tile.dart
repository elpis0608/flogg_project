import 'package:flogg_project/data/cart_store.dart';
import 'package:flogg_project/widgets/qty_control.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';


class CartTile extends StatelessWidget {
  final int index;
  final CartStore store;

  const CartTile({super.key, required this.index, required this.store});

  @override
  Widget build(BuildContext context) {
    final item = store.items[index];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSub,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mainSub),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Checkbox(
            value: item.selected,
            onChanged: (_) => store.toggleSelect(index),
            activeColor: AppColors.primary,
            checkColor: Colors.white,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item.image,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.main,
                  ),
                ),
                const SizedBox(height: 2),

                Text(
                  'x${item.qty}',
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    color: AppColors.mainSub,
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: QtyControl(
                    value: item.qty,
                    onChanged: (v) => store.setQty(index, v),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatWon(item.totalPrice),
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.main,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                '원',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 12,
                  color: AppColors.mainSub,
                ),
              ),
            ],
          ),
        ],
      ),
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
