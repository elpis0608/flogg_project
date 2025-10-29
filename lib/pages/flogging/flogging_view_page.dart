import 'package:flogg_project/widgets/flogging_image.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';
import 'package:flogg_project/pages/flogging/flogging_store.dart';

class FloggingViewPage extends StatelessWidget {
  final FloggingPost post;
  const FloggingViewPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final hasImage = (post.imagePath ?? '').isNotEmpty;
    final title = post.title;
    final body = post.body;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.main),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        children: [
          if (hasImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FloggingImage(
                path: post.imagePath!,
                height: 480,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundSub,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.mainSub),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.main,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundSub,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.mainSub),
            ),
            child: Text(
              body,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                height: 1.5,
                color: AppColors.main,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
