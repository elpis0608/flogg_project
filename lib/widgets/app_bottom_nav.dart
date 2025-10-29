import 'package:flogg_project/pages/home/home_page.dart';
import 'package:flogg_project/pages/purchase/purchase_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';
import 'package:flogg_project/pages/flogging/flogging_page.dart';


class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  const AppBottomNav({super.key, required this.currentIndex});

  void _handleTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0: // 홈
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const FloggingPage()),
          (route) => false,
        );
        break;

      case 2:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const PurchaseHistoryPage()),
          (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.main,
      unselectedItemColor: AppColors.mainSub,
      backgroundColor: AppColors.background,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      currentIndex: currentIndex,
      onTap: (i) => _handleTap(context, i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(
          icon: Icon(Icons.feed_outlined),
          label: 'Flogging',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: '구매내역'),
      ],
    );
  }
}
