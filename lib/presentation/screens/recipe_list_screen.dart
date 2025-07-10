import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/recipe_providers.dart';
import '../widgets/recipe_card.dart';

class RecipeListScreen extends ConsumerStatefulWidget {
  final String ingredients;
  final bool forceCulturalStory;

  const RecipeListScreen({
    super.key,
    required this.ingredients,
    this.forceCulturalStory = false,
  });

  @override
  ConsumerState<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends ConsumerState<RecipeListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(recipesProvider.notifier).generateRecipes(
        widget.ingredients,
        forceCulturalStory: widget.forceCulturalStory,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipesState = ref.watch(recipesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('菜谱推荐'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '食材：',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.ingredients,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildContent(recipesState),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(RecipesState state) {
    if (state.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(widget.forceCulturalStory ? '正在生成带文化故事的菜谱...' : '正在生成菜谱...'),
            const SizedBox(height: 8),
            Text(
              widget.forceCulturalStory ? '文化故事生成需要1-2分钟，请耐心等待' : '这可能需要几秒钟时间',
              style: TextStyle(
                fontSize: 12, 
                color: widget.forceCulturalStory ? Colors.purple[600] : Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    if (state.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                '生成失败',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.error!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(recipesProvider.notifier).generateRecipes(widget.ingredients);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('重试'),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () => context.go('/home'),
                    child: const Text('返回首页'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    if (state.recipes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.no_meals,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                '暂无菜谱',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text(
                '请尝试输入其他食材组合',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('重新输入'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: state.recipes.length,
      itemBuilder: (context, index) {
        final recipe = state.recipes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: RecipeCard(
            recipe: recipe,
            onTap: () => context.push('/recipe/${recipe.id}'),
          ),
        );
      },
    );
  }
}