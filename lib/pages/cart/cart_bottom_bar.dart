import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

class CartBottomBar extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onPurchase;
  final bool enabled;
  final int totalPrice;

  const CartBottomBar({
    super.key,
    required this.onDelete,
    required this.onPurchase,
    required this.enabled,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        color: AppColors.background,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: AppColors.main,
                size: 26,
              ),
              onPressed: enabled ? onDelete : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: enabled ? onPurchase : null,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '구매하기${totalPrice > 0 ? ' · ${_formatWon(totalPrice)}원' : ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
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
