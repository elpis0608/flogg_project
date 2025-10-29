import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '장바구니가 비어있습니다.',
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.main,
        ),
      ),
    );
  }
}
