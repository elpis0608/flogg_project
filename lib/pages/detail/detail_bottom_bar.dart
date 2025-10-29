import 'package:flogg_project/widgets/qty_control.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';
import 'package:flogg_project/widgets/added_cart_sheet.dart'; 

class DetailBottomBar extends StatelessWidget {
  final int qty;
  final ValueChanged<int> onQtyChanged;
  final VoidCallback onAdd;

  const DetailBottomBar({
    super.key,
    required this.qty,
    required this.onQtyChanged,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            QtyControl(value: qty, onChanged: onQtyChanged),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  onAdd();
                  await showAddedToCartSheet(context);
                },
                child: const Text(
                  '장바구니에 담기',
                  style: TextStyle(
                    color: AppColors.background,
                    fontFamily: 'Pretendard',
                    fontSize: 16,
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
}
