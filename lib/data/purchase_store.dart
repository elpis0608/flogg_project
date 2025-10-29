import 'package:flutter/foundation.dart';

class PurchaseItem {
  final String name;
  final int unitPrice;
  final int qty;
  final String image;

  const PurchaseItem({
    required this.name,
    required this.unitPrice,
    required this.qty,
    required this.image,
  });

  int get lineTotal => unitPrice * qty;
}

class PurchaseRecord {
  final DateTime createdAt;
  final List<PurchaseItem> items;

  PurchaseRecord({
    required this.createdAt,
    required this.items,
  });

  int get total => items.fold(0, (s, e) => s + e.lineTotal);
}

class PurchaseStore extends ChangeNotifier {
  PurchaseStore._();
  static final PurchaseStore _i = PurchaseStore._();
  factory PurchaseStore() => _i;

  final List<PurchaseRecord> _records = [];

  bool get isEmpty => _records.isEmpty; 

  void clearAll() {                    
    _records.clear();
    notifyListeners();
  }

  List<PurchaseRecord> get records => List.unmodifiable(_records);

  void addOrder(List<PurchaseItem> items) {
    if (items.isEmpty) return;
    _records.insert(
      0,
      PurchaseRecord(createdAt: DateTime.now(), items: items),
    );
    notifyListeners();
  }
}
