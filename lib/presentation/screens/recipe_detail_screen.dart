import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/recipe_providers.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/nutrition_analysis.dart';
import '../../core/ui/responsive_utils.dart';

class RecipeDetailScreen extends ConsumerWidget {
  final String recipeId;

  const RecipeDetailScreen({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeAsync = ref.watch(recipeByIdProvider(recipeId));

    return recipeAsync.when(
      data: (recipe) {
        // 如果找不到菜谱，使用默认值
        final actualRecipe = recipe ?? Recipe(
          id: recipeId,
          name: '菜谱未找到',
          description: '',
          ingredients: [],
          instructions: [],
          prepTime: 0,
          cookTime: 0,
          servings: 0,
          difficulty: '',
          cuisine: '',
          tags: [],
          nutrition: const NutritionAnalysis(
            calories: 0,
            protein: 0,
            carbs: 0,
            fat: 0,
            fiber: 0,
            sugar: 0,
            sodium: 0,
            summary: '',
            guidance: '',
          ),
          createdAt: DateTime.now(),
        );

        return _buildRecipeDetail(context, ref, actualRecipe);
      },
      loading: () => Scaffold(
        appBar: AppBar(
          title: const Text('加载中...'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          title: const Text('错误'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                '加载菜谱时出错',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('返回'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeDetail(BuildContext context, WidgetRef ref, Recipe recipe) {

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          Builder(
            builder: (context) {
              final favorites = ref.watch(favoritesProvider);
              final isFavorite = favorites.any((fav) => fav.id == recipe.id);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  ref.read(favoritesProvider.notifier).toggleFavorite(recipe);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isFavorite ? '已取消收藏' : '已添加收藏'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(context, recipe),
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
              ResponsiveBuilder(
                builder: (context, deviceType) {
                  // 在大屏幕上使用两列布局
                  if (deviceType == DeviceType.desktop) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: _buildNutritionCard(context, recipe),
                            ),
                            SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context)),
                            Expanded(
                              flex: 1,
                              child: _buildIngredientsCard(context, recipe),
                            ),
                          ],
                        ),
                        if (recipe.culturalStory != null) ...[
                          SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
                          _buildCulturalStoryCard(context, recipe),
                        ],
                        SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
                        _buildInstructionsCard(context, recipe),
                      ],
                    );
                  } else {
                    // 在移动设备和平板上使用单列布局
                    return Column(
                      children: [
                        _buildNutritionCard(context, recipe),
                        SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
                        if (recipe.culturalStory != null) ...[
                          _buildCulturalStoryCard(context, recipe),
                          SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
                        ],
                        _buildIngredientsCard(context, recipe),
                        SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
                        _buildInstructionsCard(context, recipe),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, Recipe recipe) {
    return Card(
      child: Padding(
        padding: ResponsiveUtils.getResponsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 0.5),
            Text(
              recipe.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
              ),
            ),
            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
            Wrap(
              spacing: ResponsiveUtils.getResponsiveSpacing(context) * 0.5,
              runSpacing: ResponsiveUtils.getResponsiveSpacing(context) * 0.5,
              children: [
                _buildInfoChip(context, Icons.access_time, '准备: ${recipe.prepTime}分钟'),
                _buildInfoChip(context, Icons.kitchen, '烹饪: ${recipe.cookTime}分钟'),
                _buildInfoChip(context, Icons.people, '${recipe.servings}人份'),
                _buildInfoChip(context, Icons.restaurant, recipe.cuisine),
                _buildInfoChip(
                  context, 
                  Icons.star, 
                  recipe.difficulty,
                  color: _getDifficultyColor(recipe.difficulty),
                ),
              ],
            ),
            if (recipe.tags.isNotEmpty) ...[
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 0.75),
              Wrap(
                spacing: ResponsiveUtils.getResponsiveSpacing(context) * 0.25,
                runSpacing: ResponsiveUtils.getResponsiveSpacing(context) * 0.25,
                children: recipe.tags.map((tag) => Chip(
                  label: Text(
                    tag,
                    style: const TextStyle(fontSize: 12),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionCard(BuildContext context, Recipe recipe) {
    final nutrition = recipe.nutrition;
    return Card(
      child: Padding(
        padding: ResponsiveUtils.getResponsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '营养成分',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
            if (nutrition.summary.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '营养概述',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nutrition.summary,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            if (nutrition.guidance.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '健康建议',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nutrition.guidance,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            ResponsiveGridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mobileColumns: 2,
              tabletColumns: 3,
              desktopColumns: 4,
              childAspectRatio: 2.5,
              children: [
                _buildNutritionItem('卡路里', '${nutrition.calories.toInt()}', 'kcal'),
                _buildNutritionItem('蛋白质', '${nutrition.protein.toInt()}', 'g'),
                _buildNutritionItem('碳水', '${nutrition.carbs.toInt()}', 'g'),
                _buildNutritionItem('脂肪', '${nutrition.fat.toInt()}', 'g'),
                _buildNutritionItem('纤维', '${nutrition.fiber.toInt()}', 'g'),
                _buildNutritionItem('钠', '${nutrition.sodium.toInt()}', 'mg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCulturalStoryCard(BuildContext context, Recipe recipe) {
    final story = recipe.culturalStory!;
    return Card(
      child: Padding(
        padding: ResponsiveUtils.getResponsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.auto_stories,
                  color: Colors.purple,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    story.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.purple[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple[200]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.nature_people,
                    size: 14,
                    color: Colors.purple[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '食材故事：${story.triggerIngredient}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.purple[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple[25],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple[100]!),
              ),
              child: Text(
                story.content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String label, String value, String unit) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            '$value$unit',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsCard(BuildContext context, Recipe recipe) {
    return Card(
      child: Padding(
        padding: ResponsiveUtils.getResponsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.shopping_basket,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '食材清单',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
            ...recipe.ingredients.map((ingredient) => Padding(
              padding: EdgeInsets.only(bottom: ResponsiveUtils.getResponsiveSpacing(context) * 0.5),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      ingredient.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  if (ingredient.isOptional)
                    const Text(
                      '可选',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionsCard(BuildContext context, Recipe recipe) {
    return Card(
      child: Padding(
        padding: ResponsiveUtils.getResponsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.list_alt,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '制作步骤',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
            ...recipe.instructions.asMap().entries.map((entry) {
              final index = entry.key;
              final instruction = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: ResponsiveUtils.getResponsiveSpacing(context)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        instruction,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label, {Color? color}) {
    final chipPadding = ResponsiveUtils.getResponsiveValue(
      context,
      mobile: 8.0,
      tablet: 10.0,
      desktop: 12.0,
    );
    final iconSize = ResponsiveUtils.getResponsiveValue(
      context,
      mobile: 14.0,
      tablet: 16.0,
      desktop: 18.0,
    );
    final fontSize = ResponsiveUtils.getResponsiveFontSize(context, 12);
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: chipPadding,
        vertical: chipPadding * 0.5,
      ),
      decoration: BoxDecoration(
        color: (color ?? Theme.of(context).colorScheme.primary).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: chipPadding * 0.5),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: color ?? Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case '简单':
        return Colors.green;
      case '中等':
        return Colors.orange;
      case '困难':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}