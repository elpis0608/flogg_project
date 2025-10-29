import 'package:flogg_project/data/cart_store.dart';
import 'package:flogg_project/data/purchase_store.dart';
import 'package:flogg_project/pages/cart/cart_bottom_bar.dart';
import 'package:flogg_project/pages/cart/cart_empty_view.dart';
import 'package:flogg_project/pages/purchase/purchase_history_page.dart';
import 'package:flogg_project/pages/purchase/purchase_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

import 'package:flogg_project/pages/cart/cart_tile.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final store = CartStore();

  @override
  void initState() {
    super.initState();
    store.addListener(_onChange);
  }

  @override
  void dispose() {
    store.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() => setState(() {});

  void _requireSelectionOr(VoidCallback action) {
    if (store.selectedCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            '선택된 제품이 없습니다.',
            style: TextStyle(color: AppColors.main, fontSize: 14),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.background,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }
    action();
  }

  @override
  Widget build(BuildContext context) {
    final allSelected =
        store.items.isNotEmpty && store.items.every((item) => item.selected);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.main),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              allSelected
                  ? Icons.select_all_outlined
                  : Icons.check_box_outline_blank,
              color: AppColors.main,
            ),
            onPressed: () {
              setState(() {
                if (allSelected) {
                  store.clearSelection();
                } else {
                  store.selectAll();
                }
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: store.isEmpty
          ? const EmptyCart()
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
              itemBuilder: (_, i) => CartTile(index: i, store: store),
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemCount: store.items.length,
            ),
      bottomNavigationBar: CartBottomBar(
        onDelete: () => _requireSelectionOr(() => store.removeSelected()),
        onPurchase: () => _requireSelectionOr(() async {
          final sum = store.selectedTotalPrice;
          await showPurchaseConfirmSheet(
            context,
            totalPrice: sum,
            onConfirm: () async {
              final snapshot = store.selectedItems
                  .map(
                    (e) => PurchaseItem(
                      name: e.name,
                      unitPrice: e.unitPrice,
                      qty: e.qty,
                      image: e.image,
                    ),
                  )
                  .toList();

              PurchaseStore().addOrder(snapshot);
              store.removeSelected();

              await showPurchaseDoneSheet(
                context,
                onGoHistory: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PurchaseHistoryPage(),
                    ),
                  );
                },
                onContinue: () {
                  Navigator.pop(context);
                },
              );
            },
          );
        }),
        enabled: !store.isEmpty,
        totalPrice: store.selectedTotalPrice,
      ),
    );
  }
}
