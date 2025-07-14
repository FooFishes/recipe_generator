import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../application/providers/recipe_providers.dart';
import '../../domain/entities/recipe_history.dart';
import '../../domain/entities/recipe.dart';
import '../widgets/recipe_card.dart';
import '../../core/ui/responsive_utils.dart';

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
      body: ResponsiveContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHistoryInfo(context, historyItem),
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 1.5),
              _buildRecipeList(context, ref, historyItem),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryInfo(BuildContext context, RecipeHistory history) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                      mobile: 24.0,
                      tablet: 28.0,
                      desktop: 32.0,
                    ),
                  ),
                ),
                SizedBox(width: spacing * 0.75),
                Expanded(
                  child: Text(
                    '生成记录详情',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, 22),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing),
            _buildInfoRow(
              context,
              Icons.local_dining,
              '使用食材',
              history.ingredients,
            ),
            SizedBox(height: spacing * 0.75),
            _buildInfoRow(
              context,
              Icons.access_time,
              '生成时间',
              dateFormat.format(history.createdAt),
            ),
            SizedBox(height: spacing * 0.75),
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
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: ResponsiveUtils.getResponsiveValue(
            context,
            mobile: 20.0,
            tablet: 22.0,
            desktop: 24.0,
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: spacing * 0.75),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeList(BuildContext context, WidgetRef ref, RecipeHistory history) {
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '生成的菜谱',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 22),
          ),
        ),
        SizedBox(height: spacing),
        ResponsiveBuilder(
          builder: (context, deviceType) {
            if (ResponsiveUtils.isLargeScreen(context)) {
              return _buildRecipeGrid(context, ref, history);
            } else {
              return _buildRecipeColumn(context, ref, history);
            }
          },
        ),
      ],
    );
  }

  Widget _buildRecipeGrid(BuildContext context, WidgetRef ref, RecipeHistory history) {
    final columns = ResponsiveUtils.getGridColumns(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: ResponsiveUtils.getResponsiveValue(
          context,
          mobile: 1.2,
          tablet: 1.0,
          desktop: 0.9,
        ),
      ),
      itemCount: history.recipeIds.length,
      itemBuilder: (context, index) {
        final recipeId = history.recipeIds[index];
        return _buildRecipeItem(context, ref, recipeId);
      },
    );
  }

  Widget _buildRecipeColumn(BuildContext context, WidgetRef ref, RecipeHistory history) {
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    
    return Column(
      children: history.recipeIds.map((recipeId) {
        return Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: _buildRecipeItem(context, ref, recipeId),
        );
      }).toList(),
    );
  }

  Widget _buildRecipeItem(BuildContext context, WidgetRef ref, String recipeId) {
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    
    return FutureBuilder<Recipe?>(
      future: ref.read(recipeRepositoryProvider).getRecipeById(recipeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(spacing),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        
        if (snapshot.hasError || !snapshot.hasData) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(spacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: ResponsiveUtils.getResponsiveValue(
                      context,
                      mobile: 48.0,
                      tablet: 56.0,
                      desktop: 64.0,
                    ),
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: spacing * 0.5),
                  Text(
                    '菜谱加载失败',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        
        final recipe = snapshot.data!;
        return RecipeCard(
          recipe: recipe,
          onTap: () => context.push('/recipe/${recipe.id}'),
        );
      },
    );
  }
}