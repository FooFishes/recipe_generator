import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../application/providers/recipe_providers.dart';
import '../../domain/entities/recipe_history.dart';
import '../../domain/entities/recipe.dart';
import '../widgets/recipe_card.dart';

class HistoryDetailScreen extends ConsumerWidget {
  final String historyId;
  
  const HistoryDetailScreen({super.key, required this.historyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);
    final historyItem = history.firstWhere((h) => h.id == historyId);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('历史记录详情'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHistoryInfo(context, historyItem),
            const SizedBox(height: 24),
            _buildRecipeList(context, ref, historyItem),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryInfo(BuildContext context, RecipeHistory history) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '生成记录详情',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              Icons.local_dining,
              '使用食材',
              history.ingredients,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              Icons.access_time,
              '生成时间',
              dateFormat.format(history.createdAt),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              Icons.receipt,
              '菜谱数量',
              '${history.recipeIds.length} 个',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeList(BuildContext context, WidgetRef ref, RecipeHistory history) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '生成的菜谱',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...history.recipeIds.map((recipeId) {
          return FutureBuilder<Recipe?>(
            future: ref.read(recipeRepositoryProvider).getRecipeById(recipeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
              }
              
              if (snapshot.hasError || !snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '菜谱加载失败',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              
              final recipe = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: RecipeCard(
                  recipe: recipe,
                  onTap: () => context.push('/recipe/${recipe.id}'),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}