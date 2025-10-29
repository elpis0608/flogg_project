import 'package:flogg_project/pages/cart/cart_page.dart';
import 'package:flogg_project/pages/category/build_category.dart';
import 'package:flogg_project/pages/category/category_page.dart';
import 'package:flogg_project/widgets/app_bottom_nav.dart';
import 'package:flogg_project/widgets/product_search.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';
import 'package:flogg_project/widgets/auto_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      CategoryItem(name: 'Best', asset: 'assets/image/Best.jpg'),
      CategoryItem(name: 'Red', asset: 'assets/image/Red.jpg'),
      CategoryItem(name: 'White', asset: 'assets/image/White.jpg'),
      CategoryItem(name: 'Green', asset: 'assets/image/Green.jpg'),
      CategoryItem(name: 'Blue', asset: 'assets/image/Blue.jpg'),
      CategoryItem(name: 'Yellow', asset: 'assets/image/Yellow.jpg'),
      CategoryItem(name: 'Pink', asset: 'assets/image/Pink.jpg'),
      CategoryItem(name: 'Purple', asset: 'assets/image/Purple.jpg'),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: SizedBox(
          height: 40,
          child: Image.asset('assets/image/logo.png', fit: BoxFit.contain),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.search, color: AppColors.main, size: 26),
                  onPressed: () async {
                    await showSearch(
                      context: context,
                      delegate: ProductSearchDelegate(),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColors.main,
                    size: 26,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: AutoCarousel(
                    images: const [
                      'assets/image/main1.jpg',
                      'assets/image/main2.jpg',
                      'assets/image/main3.jpg',
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CategoryGrid(
                items: items,
                onTap: (name) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryPage(initialCategory: name),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}
