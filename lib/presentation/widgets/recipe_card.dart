import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/recipe.dart';
import '../../application/providers/recipe_providers.dart';
import '../../core/ui/responsive_utils.dart';

class RecipeCard extends ConsumerWidget {
  final Recipe recipe;
  final VoidCallback? onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsivePadding = ResponsiveUtils.getResponsiveSpacing(context);
    final isLargeScreen = ResponsiveUtils.isLargeScreen(context);
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: ResponsiveUtils.getResponsivePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                          ),
                          maxLines: isLargeScreen ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: responsivePadding * 0.25),
                        Text(
                          recipe.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                          ),
                          maxLines: isLargeScreen ? 3 : 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final favorites = ref.watch(favoritesProvider);
                      final isFavorite = favorites.any((fav) => fav.id == recipe.id);
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                          size: ResponsiveUtils.getResponsiveValue(
                            context,
                            mobile: 24.0,
                            tablet: 28.0,
                            desktop: 32.0,
                          ),
                        ),
                        onPressed: () {
                          ref.read(favoritesProvider.notifier).toggleFavorite(recipe);
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: responsivePadding * 0.75),
              Wrap(
                spacing: ResponsiveUtils.getResponsiveValue(
                  context,
                  mobile: 8.0,
                  tablet: 10.0,
                  desktop: 12.0,
                ),
                runSpacing: ResponsiveUtils.getResponsiveValue(
                  context,
                  mobile: 4.0,
                  tablet: 6.0,
                  desktop: 8.0,
                ),
                children: [
                  _buildInfoChip(
                    context,
                    Icons.access_time,
                    '${recipe.totalTime}分钟',
                  ),
                  _buildInfoChip(
                    context,
                    Icons.people,
                    '${recipe.servings}人份',
                  ),
                  _buildInfoChip(
                    context,
                    Icons.restaurant,
                    recipe.cuisine,
                  ),
                  _buildInfoChip(
                    context,
                    Icons.star,
                    recipe.difficulty,
                    color: _getDifficultyColor(recipe.difficulty),
                  ),
                  if (recipe.culturalStory != null)
                    _buildInfoChip(
                      context,
                      Icons.auto_stories,
                      '文化故事',
                      color: Colors.purple,
                    ),
                ],
              ),
              SizedBox(height: responsivePadding * 0.75),
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    size: ResponsiveUtils.getResponsiveValue(
                      context,
                      mobile: 16.0,
                      tablet: 18.0,
                      desktop: 20.0,
                    ),
                    color: Colors.orange,
                  ),
                  SizedBox(width: responsivePadding * 0.25),
                  Text(
                    '${recipe.nutrition.calories.toInt()}卡路里',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                      color: Colors.grey[600],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '蛋白质${recipe.nutrition.protein.toInt()}g',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context,
    IconData icon,
    String label, {
    Color? color,
  }) {
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