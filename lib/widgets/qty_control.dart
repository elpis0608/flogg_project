import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

class QtyControl extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const QtyControl({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mainSub),
      ),
      child: Row(
        children: [
          _IconBtn(
            icon: Icons.remove,
            onTap: () {
              if (value > 1) onChanged(value - 1);
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                '$value',
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.main,
                ),
              ),
            ),
          ),
          _IconBtn(icon: Icons.add, onTap: () => onChanged(value + 1)),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 48,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(child: Icon(icon, size: 24, color: AppColors.mainSub)),
      ),
    );
  }
}
