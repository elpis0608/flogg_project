import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final int unitPrice;
  final String image;
  int qty;
  bool selected;

  CartItem({
    required this.name,
    required this.unitPrice,
    required this.image,
    this.qty = 1,
    this.selected = false,
  });

  int get totalPrice => unitPrice * qty;
}

class CartStore extends ChangeNotifier {
  CartStore._();
  static final CartStore _i = CartStore._();
  factory CartStore() => _i;

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  bool get isEmpty => _items.isEmpty;

  void addItem({
    required String name,
    required int price,
    required String image,
    int qty = 1,
  }) {
    final idx = _items.indexWhere((e) => e.name == name && e.image == image);
    if (idx >= 0) {
      _items[idx].qty += qty;
    } else {
      _items.add(
        CartItem(
          name: name,
          unitPrice: price,
          image: image,
          qty: qty,
          selected: true,
        ),
      );
    }
    notifyListeners();
  }

  void toggleSelect(int index) {
    _items[index].selected = !_items[index].selected;
    notifyListeners();
  }

  void setQty(int index, int qty) {
    if (qty < 1) return;
    _items[index].qty = qty;
    notifyListeners();
  }

  void removeSelected() {
    _items.removeWhere((e) => e.selected);
    notifyListeners();
  }

  void selectAll() {
    for (final item in _items) {
      item.selected = true;
    }
    notifyListeners();
  }

  void clearSelection() {
    for (final item in _items) {
      item.selected = false;
    }
    notifyListeners();
  }

  int get selectedCount => _items.where((e) => e.selected).length;

  int get selectedTotalPrice =>
      _items.where((e) => e.selected).fold(0, (sum, e) => sum + e.totalPrice);
  List<CartItem> get selectedItems =>
      _items.where((e) => e.selected).toList(growable: false);
}
