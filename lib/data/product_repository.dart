import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flogg_project/models/product.dart';

class ProductRepository {
  ProductRepository._();
  static final ProductRepository _i = ProductRepository._();
  factory ProductRepository() => _i;

  bool _loaded = false;
  late final List<String> categories;
  late final List<Product> _products;

  Future<void> load() async {
    if (_loaded) return;
    final raw = await rootBundle.loadString('assets/data/products.json');
    final Map<String, dynamic> json = jsonDecode(raw);
    categories = (json['categories'] as List).cast<String>();
    _products = (json['products'] as List)
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
    _loaded = true;
  }

  List<Product> byCategory(String category) {
    final key = category.toLowerCase().trim();
    return _products
        .where((p) => p.category.toLowerCase().trim() == key)
        .toList();
  }

  List<Product> search(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return [];
    return _products.where((p) {
      final name = p.name.toLowerCase();
      final cat = p.category.toLowerCase();
      return name.contains(q) || cat.contains(q);
    }).toList();
  }
}
