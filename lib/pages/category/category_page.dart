import 'package:flogg_project/data/category_repository.dart';
import 'package:flogg_project/data/product_repository.dart';
import 'package:flogg_project/pages/cart/cart_page.dart';
import 'package:flogg_project/pages/category/category_chip.dart';
import 'package:flogg_project/widgets/app_bottom_nav.dart';
import 'package:flogg_project/widgets/product_grid.dart';
import 'package:flogg_project/widgets/product_search.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';


class CategoryPage extends StatefulWidget {
  final String initialCategory;
  const CategoryPage({super.key, required this.initialCategory});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late String _selected;

  final _scrollController = ScrollController();
  late final Map<String, GlobalKey> _chipKeys = {
    for (final c in kCategoryList) c: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _selected = widget.initialCategory;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollToSelected(animate: false),
    );
  }

  void _scrollToSelected({bool animate = true}) {
    final ctx = _chipKeys[_selected]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: animate ? const Duration(milliseconds: 300) : Duration.zero,
      alignment: 0.3,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ProductRepository().byCategory(_selected);
    final items = products
        .map((p) => ProductItem(name: p.name, price: p.price, asset: p.image))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.main, size: 26),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
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
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 44,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: kCategoryList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final c = kCategoryList[i];
                return Container(
                  key: _chipKeys[c],
                  child: CategoryChip(
                    label: c,
                    isSelected: _selected == c,
                    onTap: () {
                      setState(() => _selected = c);
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => _scrollToSelected(),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ProductGrid(key: ValueKey(_selected), items: items),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}
