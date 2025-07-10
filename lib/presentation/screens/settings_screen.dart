import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/recipe_providers.dart';

/// 设置页面
/// 
/// 提供应用的主要配置功能，包括API密钥管理、文化故事开关、
/// 网络诊断工具和应用相关信息。使用Riverpod进行状态管理。
/// 
/// 主要功能：
/// - API密钥的输入、保存和删除
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
  /// API密钥输入控制器
  final _apiKeyController = TextEditingController();
  
  /// 控制API密钥是否以密码形式显示
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    // 在widget构建完成后加载已保存的API密钥
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final apiKey = ref.read(apiKeyProvider);
      if (apiKey != null) {
        _apiKeyController.text = apiKey;
      }
    });
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  /// 保存API密钥到安全存储
  /// 
  /// 验证用户输入的API密钥非空后，通过ApiKeyNotifier保存到设备的安全存储中。
  /// 保存成功后显示确认消息。
  void _saveApiKey() async {
    final apiKey = _apiKeyController.text.trim();
    if (apiKey.isNotEmpty) {
      // 通过Riverpod provider保存API密钥
      await ref.read(apiKeyProvider.notifier).saveApiKey(apiKey);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('API密钥已保存'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  /// 删除已保存的API密钥
  /// 
  /// 显示确认对话框，用户确认后删除本地存储的API密钥，
  /// 并清空输入框内容，显示删除成功消息。
  void _deleteApiKey() async {
    // 显示确认对话框，防止误删
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除API密钥'),
        content: const Text('确定要删除已保存的API密钥吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    // 用户确认删除后执行删除操作
    if (confirmed == true) {
      await ref.read(apiKeyProvider.notifier).deleteApiKey();
      _apiKeyController.clear();  // 清空输入框
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('API密钥已删除'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiKey = ref.watch(apiKeyProvider);
    final hasApiKey = apiKey != null && apiKey.isNotEmpty;
    final culturalStoryEnabled = ref.watch(culturalStoryProvider);

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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.key,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'API密钥配置',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _apiKeyController,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        labelText: '硅基流动API密钥',
                        hintText: '请输入您的API密钥',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _isObscured = !_isObscured),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _saveApiKey,
                            icon: const Icon(Icons.save),
                            label: const Text('保存'),
                          ),
                        ),
                        if (hasApiKey) ...[
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: _deleteApiKey,
                            icon: const Icon(Icons.delete),
                            label: const Text('删除'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.error,
                              foregroundColor: Theme.of(context).colorScheme.onError,
                            ),
                          ),
                        ],
                      ],
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
                    const Text('1. 访问硅基流动官网: siliconflow.cn'),
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
                    const SizedBox(height: 4),
                    const Text('• 不会收集或上传您的个人信息'),
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