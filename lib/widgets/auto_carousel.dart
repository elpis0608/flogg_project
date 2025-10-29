import 'dart:async';
import 'package:flutter/material.dart';

class AutoCarousel extends StatefulWidget {
  final List<String> images;
  final double height;
  final double borderRadius;
  final Duration interval;
  final BoxFit fit;

  const AutoCarousel({
    super.key,
    required this.images,
    this.height = 240,
    this.borderRadius = 12,
    this.interval = const Duration(seconds: 3),
    this.fit = BoxFit.cover,
  });

  @override
  State<AutoCarousel> createState() => _AutoCarouselState();
}

class _AutoCarouselState extends State<AutoCarousel> {
  late final PageController _pc;
  late Timer _timer;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pc = PageController(initialPage: 1000 * widget.images.length);
    _page = _pc.initialPage;
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted) return;
      _page++;
      _pc.animateToPage(
        _page,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.images.length;
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: double.infinity,
            child: PageView.builder(
              controller: _pc,
              onPageChanged: (i) => setState(() => _page = i),
              itemBuilder: (_, i) {
                final img = widget.images[i % total];
                return Image.asset(img, fit: widget.fit);
              },
            ),
          ),
          Positioned(
            bottom: 10,
            child: Row(
              children: List.generate(total, (i) {
                final active = (_page % total) == i;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
