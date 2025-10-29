import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flogg_project/theme/colors.dart';
import 'package:flogg_project/pages/flogging/flogging_store.dart';

class FloggingWritePage extends StatefulWidget {
  const FloggingWritePage({super.key});

  @override
  State<FloggingWritePage> createState() => _FloggingWritePageState();
}

class _FloggingWritePageState extends State<FloggingWritePage> {
  final _titleC = TextEditingController();
  final _bodyC = TextEditingController();
  String? _imagePath;
  bool _submitting = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final x = await picker.pickImage(source: ImageSource.gallery);
    if (x != null) {
      setState(() => _imagePath = x.path);
    }
  }

  void _submit() {
    if (_submitting) return;

    final title = _titleC.text.trim();
    final body = _bodyC.text.trim();

    if (_imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('사진을 업로드 해주세요.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('제목을 입력해주세요.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('내용을 입력해주세요.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() => _submitting = true);
    FloggingStore().add(title: title, body: body, imagePath: _imagePath);
    Navigator.pop(context);
  }

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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        children: [
          InkWell(
            onTap: _pickImage,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.backgroundSub,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.mainSub),
              ),
              child: _imagePath == null
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            color: AppColors.main,
                            size: 28,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '사진을 업로드 해 주세요',
                            style: TextStyle(
                              color: AppColors.main,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        File(_imagePath!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleC,
            textInputAction: TextInputAction.next,
            decoration: _inputDecoration('제목을 입력하세요'),
            maxLength: 20,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _bodyC,
            maxLines: 10,
            decoration: _inputDecoration('내용을 입력하세요'),
          ),
          const SizedBox(height: 8),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: SizedBox(
            height: 52,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _submitting ? null : _submit,
              child: const Text(
                'Flogging',
                style: TextStyle(
                  color: AppColors.background,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.background,
      hintStyle: const TextStyle(color: AppColors.mainSub),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.mainSub),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.mainSub),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }
}
