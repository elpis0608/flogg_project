import 'package:flutter/material.dart';

class DetailImage extends StatelessWidget {
  final String heroTag;
  final String image;
  const DetailImage({super.key, required this.heroTag, required this.image});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Expanded(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
