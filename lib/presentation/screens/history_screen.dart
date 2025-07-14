import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../application/providers/recipe_providers.dart';
import '../../domain/entities/recipe_history.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('生成历史'),
        centerTitle: true,
        actions: [
          if (history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () => _showClearDialog(context, ref),
              tooltip: '清空历史',
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(historyProvider.notifier).loadHistory();
        },
        child: _buildContent(context, ref, history),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, List<RecipeHistory> history) {
    if (history.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 24),
              Text(
                '暂无生成记录',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '在首页生成菜谱后，历史记录将显示在这里',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => context.go('/home'),
                icon: const Icon(Icons.home),
                label: const Text('去生成菜谱'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final historyItem = history[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Dismissible(
            key: Key(historyItem.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '删除',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            confirmDismiss: (direction) => _showDeleteDialog(context, historyItem.ingredients),
            onDismissed: (direction) {
              ref.read(historyProvider.notifier).deleteHistory(historyItem.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('已删除历史记录'),
                  action: SnackBarAction(
                    label: '撤销',
                    onPressed: () {
                      // TODO: Implement undo functionality
                    },
                  ),
                ),
              );
            },
            child: _buildHistoryCard(context, historyItem),
          ),
        );
      },
    );
  }

  Widget _buildHistoryCard(BuildContext context, RecipeHistory history) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => context.push('/history/${history.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.restaurant,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '食材：${history.ingredients}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '生成时间：${dateFormat.format(history.createdAt)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '生成了 ${history.recipeIds.length} 个菜谱',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context, String ingredients) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除历史记录'),
        content: Text('确定要删除「$ingredients」的生成记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清空历史记录'),
        content: const Text('确定要清空所有历史记录吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(historyProvider.notifier).clearAllHistory();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('已清空所有历史记录'),
                  ),
                );
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('清空'),
          ),
        ],
      ),
    );
  }
}