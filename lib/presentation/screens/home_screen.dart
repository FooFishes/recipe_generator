import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/recipe_providers.dart';
import '../../core/logging/app_logger.dart';
import '../../core/ui/responsive_utils.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _ingredientsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    AppLogger.info('HomeScreen初始化');
  }

  @override
  void dispose() {
    _ingredientsController.dispose();
    super.dispose();
  }

  void _generateRecipes() {
    if (_formKey.currentState!.validate()) {
      final ingredients = _ingredientsController.text.trim();
      final culturalStoryEnabled = ref.read(culturalStoryProvider);
      
      AppLogger.logUserAction('生成菜谱', {
        'ingredients': ingredients,
        'culturalStoryEnabled': culturalStoryEnabled,
      });
      
      context.push('/recipes', extra: {
        'ingredients': ingredients,
        'forceCulturalStory': culturalStoryEnabled,
      });
    } else {
      AppLogger.warning('表单验证失败，无法生成菜谱');
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiKey = ref.watch(apiKeyProvider);
    final hasApiKey = apiKey != null && apiKey.isNotEmpty;
    final model = ref.watch(modelProvider);
    final hasModel = model != null && model.isNotEmpty;
    final baseUrl = ref.watch(baseUrlProvider);
    final hasBaseUrl = baseUrl != null && baseUrl.isNotEmpty;
    final culturalStoryEnabled = ref.watch(culturalStoryProvider);

    // 检查是否所有配置都完成
    final isFullyConfigured = hasApiKey && hasModel && hasBaseUrl;

    return Scaffold(
      appBar: AppBar(
        title: const Text('智能菜谱助手'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.push('/favorites'),
            tooltip: '我的收藏',
          ),
        ],
      ),
      body: ResponsiveContainer(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              if (!isFullyConfigured) ...[
                ResponsiveCard(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.warning,
                            color: Theme.of(context).colorScheme.error,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '配置未完成',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!hasApiKey)
                                Text(
                                  '• 未配置API密钥',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (!hasModel)
                                Text(
                                  '• 未配置模型名称',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (!hasBaseUrl)
                                Text(
                                  '• 未配置基础URL',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '请先在设置中完成所有配置',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () => context.go('/settings'),
                            child: const Text('前往设置'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
              ],
              ResponsiveCard(
                maxWidth: ResponsiveUtils.getFormMaxWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '食材输入',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _ingredientsController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: '请输入您拥有的食材，用逗号分隔\n例如：鸡胸肉, 胡萝卜, 洋葱, 大蒜',
                        border: OutlineInputBorder(),
                        helperText: '越详细的食材描述，生成的菜谱越精准',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '请输入至少一种食材';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: isFullyConfigured ? _generateRecipes : null,
                        icon: const Icon(Icons.auto_awesome),
                        label: Text(culturalStoryEnabled ? '生成菜谱（含文化故事）' : '生成菜谱'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    if (culturalStoryEnabled) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.purple[50],
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.purple[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, 
                              size: 16, 
                              color: Colors.purple[600]
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '文化故事模式已开启，生成时间可能稍长（1-2分钟）',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.purple[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
              ResponsiveCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.tips_and_updates,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '使用小贴士',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('• 详细描述食材可获得更准确的菜谱推荐'),
                    const SizedBox(height: 4),
                    const Text('• 包含调料信息有助于生成完整菜谱'),
                    const SizedBox(height: 4),
                    const Text('• 可以标注食材数量，如：鸡胸肉200g'),
                    const SizedBox(height: 4),
                    const Text('• 生成的菜谱可以收藏，方便下次查看'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}