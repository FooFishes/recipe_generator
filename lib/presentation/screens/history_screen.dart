import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../application/providers/recipe_providers.dart';
import '../../domain/entities/recipe_history.dart';
import '../../core/ui/responsive_utils.dart';

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
        child: ResponsiveContainer(
          child: _buildContent(context, ref, history),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, List<RecipeHistory> history) {
    if (history.isEmpty) {
      return Center(
        child: Padding(
          padding: ResponsiveUtils.getResponsivePadding(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history,
                size: ResponsiveUtils.getResponsiveValue(
                  context,
                  mobile: 80.0,
                  tablet: 100.0,
                  desktop: 120.0,
                ),
                color: Colors.grey[400],
              ),
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
              Text(
                '暂无生成记录',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 24),
                ),
              ),
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 0.5),
              Text(
                '在首页生成菜谱后，历史记录将显示在这里',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                ),
              ),
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 1.5),
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

    return ResponsiveBuilder(
      builder: (context, deviceType) {
        if (ResponsiveUtils.isLargeScreen(context)) {
          // 大屏幕使用网格布局
          return _buildGridLayout(context, ref, history);
        } else {
          // 小屏幕使用列表布局
          return _buildListLayout(context, ref, history);
        }
      },
    );
  }

  Widget _buildListLayout(BuildContext context, WidgetRef ref, List<RecipeHistory> history) {
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    
    return ListView.builder(
      padding: ResponsiveUtils.getResponsivePadding(context),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final historyItem = history[index];
        return Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: Dismissible(
            key: Key(historyItem.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: spacing),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: ResponsiveUtils.getResponsiveValue(
                      context,
                      mobile: 32.0,
                      tablet: 36.0,
                      desktop: 40.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '删除',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
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
                  content: const Text('已删除历史记录'),
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

  Widget _buildGridLayout(BuildContext context, WidgetRef ref, List<RecipeHistory> history) {
    final columns = ResponsiveUtils.getGridColumns(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    
    return Padding(
      padding: ResponsiveUtils.getResponsivePadding(context),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: ResponsiveUtils.getResponsiveValue(
            context,
            mobile: 1.2,
            tablet: 1.1,
            desktop: 1.0,
          ),
        ),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final historyItem = history[index];
          return _buildHistoryCard(context, historyItem);
        },
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, RecipeHistory history) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => context.push('/history/${history.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(spacing * 0.5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.restaurant,
                      color: Theme.of(context).colorScheme.primary,
                      size: ResponsiveUtils.getResponsiveValue(
                        context,
                        mobile: 20.0,
                        tablet: 22.0,
                        desktop: 24.0,
                      ),
                    ),
                  ),
                  SizedBox(width: spacing * 0.75),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '食材：${history.ingredients}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spacing * 0.25),
                        Text(
                          '生成时间：${dateFormat.format(history.createdAt)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing * 0.75),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spacing * 0.75,
                  vertical: spacing * 0.375,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '生成了 ${history.recipeIds.length} 个菜谱',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
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