import 'package:flogg_project/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  bool _showButton = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _showButton = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double kRadius = 12;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: SizedBox(
          height: 40,
          child: Image.asset('assets/image/logo.png', fit: BoxFit.contain),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(kRadius),
              child: AspectRatio(
                aspectRatio: 3.2 / 4,
                child: Image.asset(
                  'assets/image/image1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: Image.asset(
                    'assets/image/image2.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: _showButton ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRadius),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: const Text(
                      'ENTER',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
