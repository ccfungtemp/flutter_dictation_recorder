import 'package:flutter/material.dart';
import '../../application/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final dictationsAsync = ref.watch(dictationsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的聽寫'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: DropdownButton<String?>(
                value: _selectedCategory,
                hint: const Text(
                  '全部類別',
                  style: TextStyle(fontSize: 12),
                ),
                items: [
                  const DropdownMenuItem(
                    child: Text(
                      '全部類別',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ...(dictationsAsync.maybeWhen(
                    data: (dictations) => dictations
                        .map((d) => d.categoryName)
                        .toSet()
                        .toList()
                        ..sort(),
                    orElse: () => <String>[],
                  ))
                      .map(
                    (category) => DropdownMenuItem<String?>(
                      value: category,
                      child: Text(
                        category,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.go('/settings');
            },
          ),
        ],
      ),
      body: dictationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('發生錯誤: $err')),
        data: (dictations) {
          if (dictations.isEmpty) {
            return const Center(child: Text('目前沒有聽寫紀錄。'));
          }

          // 篩選 dictations
          final filteredDictations = _selectedCategory == null
              ? dictations
              : dictations
                    .where((d) => d.categoryName == _selectedCategory)
                    .toList();

          return filteredDictations.isEmpty
              ? const Center(child: Text('沒有符合的聽寫紀錄。'))
              : ListView.builder(
                  itemCount: filteredDictations.length,
                  itemBuilder: (context, index) {
                    final dictation = filteredDictations[index];
                    return ListTile(
                      title: Text(
                        dictation.textbookName,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dictation.categoryName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFFD8A9E8),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '建立於 ${dictation.createdAt.year}-${dictation.createdAt.month.toString().padLeft(2, '0')}-${dictation.createdAt.day.toString().padLeft(2, '0')} ${dictation.createdAt.hour.toString().padLeft(2, '0')}:${dictation.createdAt.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        context.go('/dictation/${dictation.id}');
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          context.go('/edit/${dictation.id}');
                        },
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/add');
        },
        backgroundColor: const Color(0xFFD8A9E8),
        child: const Icon(Icons.mic, color: Colors.black, size: 32),
      ),
    );
  }
}