import 'package:flogg_project/data/purchase_store.dart';
import 'package:flogg_project/pages/home/home_page.dart';
import 'package:flogg_project/widgets/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flogg_project/theme/colors.dart';

class PurchaseHistoryPage extends StatefulWidget {
  const PurchaseHistoryPage({super.key});

  @override
  State<PurchaseHistoryPage> createState() => _PurchaseHistoryPageState();
}

class _PurchaseHistoryPageState extends State<PurchaseHistoryPage> {
  final store = PurchaseStore();

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
    final records = store.records;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.main),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false,
            );
          },
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: AppColors.main),
            onPressed: () {
              if (store.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('구매내역이 없습니다.'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: AppColors.background,
                  title: const Text(
                    '구매내역 비우기',
                    style: TextStyle(color: AppColors.main),
                  ),
                  content: const Text(
                    '모든 구매내역을 삭제하시겠습니까?',
                    style: TextStyle(color: AppColors.mainSub),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text(
                        '취소',
                        style: TextStyle(color: AppColors.mainSub),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        store.clearAll();
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('모든 구매내역이 삭제되었습니다.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Text(
                        '삭제',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: records.isEmpty
          ? const _EmptyHistory()
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              itemBuilder: (_, i) => _PurchaseCard(record: records[i]),
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemCount: records.length,
            ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '구매내역이 없습니다',
        style: TextStyle(
          fontFamily: 'Pretendard',
          color: AppColors.mainSub,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _PurchaseCard extends StatelessWidget {
  final PurchaseRecord record;
  const _PurchaseCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final summary = _buildSummary(record);
    final total = _formatWon(record.total);
    final dateStr = _formatDate(record.createdAt);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSub,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mainSub),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateStr,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14,
              color: AppColors.mainSub,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              color: AppColors.main,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  total,
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.main,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  '원',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    color: AppColors.mainSub,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildSummary(PurchaseRecord r) {
    final parts = r.items.map((e) => '${e.name} x${e.qty}').toList();
    return parts.join(', ');
  }

  String _formatWon(int v) {
    final neg = v < 0;
    final s = v.abs().toString();
    final withCommas = s.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return neg ? '-$withCommas' : withCommas;
  }

  String _formatDate(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${dt.year}.${two(dt.month)}.${two(dt.day)}  ${two(dt.hour)}:${two(dt.minute)}';
  }
}
