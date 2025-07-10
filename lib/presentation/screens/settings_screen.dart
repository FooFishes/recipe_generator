import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_generator/presentation/screens/network_diagnostics_screen.dart';
import '../../application/providers/recipe_providers.dart';
import 'api_config_screen.dart';

/// 设置页面
///
/// 提供应用的主要配置功能，包括API配置导航、文化故事开关、
/// 网络诊断工具和应用相关信息。使用Riverpod进行状态管理。
///
/// 主要功能：
/// - API配置页面的导航入口
/// - 文化故事功能的开关控制
/// - 网络连接状态诊断
/// - 用户隐私和安全信息展示
/// - 获取API密钥的引导信息
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {



  @override
  Widget build(BuildContext context) {
    final culturalStoryEnabled = ref.watch(culturalStoryProvider);
    final apiKey = ref.watch(apiKeyProvider);
    final hasApiKey = apiKey != null && apiKey.isNotEmpty;
    final model = ref.watch(modelProvider);
    final hasModel = model != null && model.isNotEmpty;
    final baseUrl = ref.watch(baseUrlProvider);
    final hasBaseUrl = baseUrl != null && baseUrl.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // API配置导航卡片
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.api,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('API配置'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hasApiKey ? '✓ 已配置API密钥' : '  未配置API密钥',
                      style: TextStyle(
                        color: hasApiKey ? Colors.lightGreen : Colors.red.shade300,
                        fontWeight: hasApiKey ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    Text(
                      hasModel ? '✓ 已配置模型' : '  未配置模型',
                      style: TextStyle(
                        color: hasModel ? Colors.lightGreen : Colors.red.shade300,
                        fontWeight: hasModel ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    Text(
                      hasBaseUrl ? '✓ 已配置基础URL' : '  未配置基础URL',
                      style: TextStyle(
                        color: hasBaseUrl ? Colors.lightGreen : Colors.red.shade300,
                        fontWeight: hasBaseUrl ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasApiKey && hasModel && hasBaseUrl)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      )
                    else
                      const Icon(
                        Icons.warning,
                        color: Colors.orange,
                        size: 20,
                      ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ApiConfigScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // 文化故事设置卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                        Text(
                          '文化故事设置',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('强制生成文化故事'),
                      subtitle: const Text('开启后，每个菜谱都会包含相关的文化背景故事'),
                      value: culturalStoryEnabled,
                      onChanged: (value) {
                        ref.read(culturalStoryProvider.notifier).setEnabled(value);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(value ? '已开启文化故事功能' : '已关闭文化故事功能'),
                            backgroundColor: value ? Colors.green : Colors.orange,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      secondary: Icon(
                        culturalStoryEnabled ? Icons.book : Icons.book_outlined,
                        color: culturalStoryEnabled ? Colors.purple : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.purple[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.purple[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '功能说明：',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('• 开启：每个菜谱都会包含食材的历史背景和文化故事'),
                          const SizedBox(height: 2),
                          const Text('• 关闭：AI会根据食材特色自行判断是否添加文化故事'),
                          const SizedBox(height: 2),
                          const Text('• 注意：开启后生成时间会延长至1-2分钟'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '获取API密钥',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('1. 访问服务提供商官网'),
                    const SizedBox(height: 4),
                    const Text('2. 注册并登录账户'),
                    const SizedBox(height: 4),
                    const Text('3. 在控制台中创建API密钥'),
                    const SizedBox(height: 4),
                    const Text('4. 复制密钥并粘贴到上方输入框'),
                    const SizedBox(height: 12),
                    const Text(
                      '注意：请妥善保管您的API密钥，不要与他人分享',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.network_check,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '网络诊断',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('如果遇到网络连接问题，可以使用网络诊断工具进行排查'),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NetworkDiagnosticsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.network_check),
                        label: const Text('开始网络诊断'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '隐私与安全',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('• API密钥使用安全存储技术加密保存'),
                    const SizedBox(height: 4),
                    const Text('• 菜谱数据仅存储在本地设备'),
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}