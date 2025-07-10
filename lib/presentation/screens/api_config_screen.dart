import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/recipe_providers.dart';

/// API配置页面
/// 
/// 专门用于管理API相关的配置，包括API密钥、模型名称和基础URL。
/// 从主设置页面分离出来，提供更专注的配置体验。
class ApiConfigScreen extends ConsumerStatefulWidget {
  const ApiConfigScreen({super.key});

  @override
  ConsumerState<ApiConfigScreen> createState() => _ApiConfigScreenState();
}

class _ApiConfigScreenState extends ConsumerState<ApiConfigScreen> {
  /// API密钥输入控制器
  final _apiKeyController = TextEditingController();
  /// 模型名字输入控制器
  final _modelController = TextEditingController();
  /// BaseURL输入控制器
  final _baseUrlController = TextEditingController();
  /// 控制API密钥是否以密码形式显示
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    // 在widget构建完成后加载已保存的配置
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final apiKey = ref.read(apiKeyProvider);
      if (apiKey != null) {
        _apiKeyController.text = apiKey;
      }
      final model = ref.read(modelProvider);
      _modelController.text = model ?? '';

      final baseUrl = ref.read(baseUrlProvider);
      _baseUrlController.text = baseUrl ?? '';
    });
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    _modelController.dispose();
    _baseUrlController.dispose();
    super.dispose();
  }

  /// 保存API密钥到安全存储
  void _saveApiKey() async {
    final apiKey = _apiKeyController.text.trim();
    if (apiKey.isNotEmpty) {
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

  void _saveModel() async {
    final model = _modelController.text.trim();
    if (model.isNotEmpty) {
      await ref.read(modelProvider.notifier).setModel(model);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('模型名称已保存'),
            backgroundColor: Colors.green,
          )
        );
      }
    }
  }

  void _saveBaseUrl() async {
    final baseUrl = _baseUrlController.text.trim();
    if (baseUrl.isNotEmpty) {
      await ref.read(baseUrlProvider.notifier).setBaseUrl(baseUrl);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('基础URL已保存'),
            backgroundColor: Colors.green,
          )
        );
      }
    }
  }

  /// 删除已保存的API密钥
  void _deleteApiKey() async {
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

    if (confirmed == true) {
      await ref.read(apiKeyProvider.notifier).deleteApiKey();
      _apiKeyController.clear();
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

  void _deleteModel() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除模型名称'),
        content: const Text('确定要删除已保存的模型名称吗？'),
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

    if (confirmed == true) {
      await ref.read(settingsServiceProvider).deleteModel();
      _modelController.clear();
      // 重新加载状态，现在会返回null
      await ref.read(modelProvider.notifier).loadModel();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('模型名称已删除'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  void _deleteBaseUrl() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除基础URL'),
        content: const Text('确定要删除已保存的基础URL吗？'),
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

    if (confirmed == true) {
      await ref.read(settingsServiceProvider).deleteBaseUrl();
      _baseUrlController.clear();
      // 重新加载状态，现在会返回null
      await ref.read(baseUrlProvider.notifier).loadBaseUrl();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('基础URL已删除'),
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
    final model = ref.watch(modelProvider);
    final hasModel = model != null && model.isNotEmpty;
    final baseUrl = ref.watch(baseUrlProvider);
    final hasBaseUrl = baseUrl != null && baseUrl.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('API配置'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // API密钥配置卡片
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
                          'API密钥',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _apiKeyController,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        labelText: 'API密钥',
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
            // 基础URL配置卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.link,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '基础URL配置',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _baseUrlController,
                      decoration: const InputDecoration(
                        labelText: '基础URL',
                        hintText: '请输入API的基础URL',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _saveBaseUrl,
                            icon: const Icon(Icons.save),
                            label: const Text('保存'),
                          ),
                        ),
                        if (hasBaseUrl) ...[
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: _deleteBaseUrl,
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
            // 模型配置卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.psychology,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '模型配置',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _modelController,
                      decoration: const InputDecoration(
                        labelText: '模型名称',
                        hintText: '请输入要使用的模型名称',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _saveModel,
                            icon: const Icon(Icons.save),
                            label: const Text('保存'),
                          ),
                        ),
                        if (hasModel) ...[
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: _deleteModel,
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
            // 配置说明卡片
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
                          '配置说明',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('• API密钥：用于身份验证的密钥，请妥善保管'),
                    const SizedBox(height: 4),
                    const Text('• 模型名称：指定要使用的AI模型（如：gpt-4, gemini-pro等）'),
                    const SizedBox(height: 4),
                    const Text('• 基础URL：API服务的基础地址'),
                    const SizedBox(height: 4),
                    const Text('• 所有配置项都是必需的，请确保全部填写'),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '安全提示：',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('• API密钥使用安全存储技术加密保存'),
                          const SizedBox(height: 2),
                          const Text('• 请不要与他人分享您的API密钥'),
                          const SizedBox(height: 2),
                          const Text('• 配置数据仅存储在本地设备'),
                        ],
                      ),
                    ),
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
