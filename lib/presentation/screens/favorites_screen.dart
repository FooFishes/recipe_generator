import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/recipe_providers.dart';
import '../../core/ui/responsive_utils.dart';
import '../widgets/recipe_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('收藏菜谱'),
        centerTitle: true,
        actions: [
          if (favorites.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () => _showClearDialog(context, ref),
              tooltip: '清空收藏',
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(favoritesProvider.notifier).loadFavorites();
        },
        child: _buildContent(context, ref, favorites),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, List favorites) {
    if (favorites.isEmpty) {
      return ResponsiveContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
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
                '暂无收藏菜谱',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 24),
                ),
              ),
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 0.5),
              Text(
                '在菜谱详情页点击❤️即可收藏喜欢的菜谱',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                ),
              ),
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 1.5),
              ElevatedButton.icon(
                onPressed: () => context.go('/home'),
                icon: const Icon(Icons.home),
                label: const Text('去发现菜谱'),
              ),
            ],
          ),
        ),
      );
    }

    return ResponsiveContainer(
      child: ResponsiveBuilder(
        builder: (context, deviceType) {
          // 创建卡片列表
          final cards = favorites.map<Widget>((recipe) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: ResponsiveUtils.getResponsiveSpacing(context),
              ),
              child: Dismissible(
                key: Key(recipe.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                    right: ResponsiveUtils.getResponsiveSpacing(context),
                  ),
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
                confirmDismiss: (direction) => _showDeleteDialog(context, recipe.name),
                onDismissed: (direction) {
                  ref.read(favoritesProvider.notifier).toggleFavorite(recipe);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('已取消收藏 ${recipe.name}'),
                      action: SnackBarAction(
                        label: '撤销',
                        onPressed: () {
                          ref.read(favoritesProvider.notifier).toggleFavorite(recipe);
                        },
                      ),
                    ),
                  );
                },
                child: RecipeCard(
                  recipe: recipe,
                  onTap: () => context.push('/recipe/${recipe.id}'),
                ),
              ),
            );
          }).toList();

          // 根据设备类型选择布局
          if (deviceType == DeviceType.mobile) {
            // 移动设备使用列表布局
            return ListView(
              children: cards,
            );
          } else {
            // 平板和桌面使用网格布局
            return ResponsiveGridView(
              mobileColumns: 1,
              tabletColumns: 2,
              desktopColumns: 3,
              childAspectRatio: 1.2,
              children: cards,
            );
          }
        },
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context, String recipeName) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('取消收藏'),
        content: Text('确定要取消收藏「$recipeName」吗？'),
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
        title: const Text('清空收藏'),
        content: const Text('确定要清空所有收藏的菜谱吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(favoritesProvider.notifier).clearAll();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('已清空所有收藏'),
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