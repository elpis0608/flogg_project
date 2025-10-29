import 'package:flogg_project/pages/flogging/flogging_store.dart';
import 'package:flogg_project/widgets/flogging_image.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';
import 'package:flogg_project/widgets/app_bottom_nav.dart';
import 'package:flogg_project/pages/flogging/flogging_write_page.dart';
import 'package:flogg_project/pages/flogging/flogging_view_page.dart';

class FloggingPage extends StatefulWidget {
  const FloggingPage({super.key});

  @override
  State<FloggingPage> createState() => _FloggingPageState();
}

class _FloggingPageState extends State<FloggingPage> {
  final store = FloggingStore();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: SizedBox(
          height: 40,
          child: Image.asset('assets/image/logo.png', fit: BoxFit.contain),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
        itemCount: store.posts.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final p = store.posts[i];
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FloggingViewPage(post: p)),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundSub,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.mainSub),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (p.imagePath != null)
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: FloggingImage(
                        path: p.imagePath!,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      p.title.isEmpty ? '(제목 없음)' : p.title,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.main,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _Fab(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FloggingWritePage()),
          );
        },
      ),
    );
  }
}

class _Fab extends StatelessWidget {
  final VoidCallback onTap;
  const _Fab({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add, color: AppColors.background, size: 20),
              SizedBox(width: 4),
              Text(
                'Flogging',
                style: TextStyle(
                  color: AppColors.background,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
