import 'package:flogg_project/data/cart_store.dart';
import 'package:flogg_project/pages/detail/detail_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

class DetailPage extends StatefulWidget {
  final String name;
  final int price;
  final String image;
  const DetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _qty = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.main),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: widget.image,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: _NamePriceBox(name: widget.name, price: widget.price),
            ),
          ),
        ],
      ),
      bottomNavigationBar: DetailBottomBar(
        qty: _qty,
        onQtyChanged: (v) => setState(() => _qty = v),
        onAdd: () {
          CartStore().addItem(
            name: widget.name,
            price: widget.price,
            image: widget.image,
            qty: _qty,
          );
        },
      ),
    );
  }
}

class _NamePriceBox extends StatelessWidget {
  final String name;
  final int price;
  const _NamePriceBox({required this.name, required this.price});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.main,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _formatWon(price),
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.main,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '원',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 20,
                  color: AppColors.mainSub,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatWon(int v) {
    final s = v.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      final left = s.length - i;
      buf.write(s[i]);
      if (left > 1 && left % 3 == 1) buf.write(',');
    }
    return buf.toString();
  }
}
