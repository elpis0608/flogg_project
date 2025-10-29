import 'package:flutter/foundation.dart';

class FloggingPost {
  final String id;
  final String title;
  final String body;
  final String? imagePath;

  FloggingPost({
    required this.id,
    required this.title,
    required this.body,
    required this.imagePath,
  });
}

class FloggingStore extends ChangeNotifier {
  FloggingStore._() {
    _posts.addAll([
      FloggingPost(
        id: 'seed1',
        title: 'with flowers',
        body:
            '꽃을 너무 좋아해서 오늘은 꽃을 활용한 드로잉 체험을 하고 왔어요!\n'
            '분위기도 너무 좋고 제가 그린 그림에 꽃을 추가하니 생동감이 살아나서 행복했어요',
        imagePath: 'assets/image/sample1.jpg',
      ),
      FloggingPost(
        id: 'seed2',
        title: '아기와 함께',
        body:
            '아기와 함께 노란 유채꽃밭에 다녀왔어요 \n'
            '햇살이 따뜻하고 아기의 웃음소리가 들려서 정말 행복한 하루였어요.',
        imagePath: 'assets/image/sample2.jpg',
      ),
      FloggingPost(
        id: 'seed3',
        title: '오늘의 플로깅',
        body:
            '오늘 아침엔 동네 공원에서 플로깅을 했어요!\n'
            '쓰레기를 주우면서 걷다 보니 기분이 상쾌하고 하루가 더 의미 있게 느껴졌어요.',
        imagePath: 'assets/image/sample3.jpg',
      ),
    ]);
  }

  static final FloggingStore _i = FloggingStore._();
  factory FloggingStore() => _i;

  final List<FloggingPost> _posts = [];
  List<FloggingPost> get posts => List.unmodifiable(_posts);

  void add({required String title, required String body, String? imagePath}) {
    _posts.insert(
      0,
      FloggingPost(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title.trim(),
        body: body.trim(),
        imagePath: imagePath,
      ),
    );
    notifyListeners();
  }
}
