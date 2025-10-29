import 'dart:io';
import 'package:flutter/material.dart';

class FloggingImage extends StatelessWidget {
  final String path;
  final double? height;
  final BoxFit fit;
  const FloggingImage({
    super.key,
    required this.path,
    this.height,
    this.fit = BoxFit.cover,
  });

  bool get _isAsset => path.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    final img = _isAsset
        ? Image.asset(path, fit: fit)
        : Image.file(File(path), fit: fit);

    if (height == null) return img;
    return SizedBox(height: height, width: double.infinity, child: img);
  }
}
