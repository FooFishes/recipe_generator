import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_generator/data/services/network/network_service.dart';
import 'package:recipe_generator/data/services/storage/settings_service.dart';

/// 网络诊断界面
/// 
/// 提供详细的网络连接诊断功能，特别针对release模式下的网络问题
class NetworkDiagnosticsScreen extends ConsumerStatefulWidget {
  const NetworkDiagnosticsScreen({super.key});

  @override
  ConsumerState<NetworkDiagnosticsScreen> createState() => _NetworkDiagnosticsScreenState();
}

class _NetworkDiagnosticsScreenState extends ConsumerState<NetworkDiagnosticsScreen> {
  Map<String, dynamic>? _diagnosticsResult;
  bool _isRunningDiagnostics = false;
  final SettingsService _settingsService = SettingsService();

  @override
  void initState() {
    super.initState();
    // 自动运行一次诊断
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runDiagnostics();
    });
  }

  Future<void> _runDiagnostics() async {
    setState(() {
      _isRunningDiagnostics = true;
      _diagnosticsResult = null;
    });

    try {
      // 获取配置的baseUrl进行测试
      final baseUrl = await _settingsService.getBaseUrl();
      
      final result = await NetworkService.performNetworkDiagnostics(
        apiUrl: baseUrl,
      );
      
      setState(() {
        _diagnosticsResult = result;
      });
    } catch (e) {
      setState(() {
        _diagnosticsResult = {
          'error': e.toString(),
          'diagnostics_summary': '诊断过程中发生错误: $e',
        };
      });
    } finally {
      setState(() {
        _isRunningDiagnostics = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网络诊断'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isRunningDiagnostics ? null : _runDiagnostics,
            tooltip: '重新诊断',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 诊断状态卡片
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
                          '网络连接诊断',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (_isRunningDiagnostics)
                      const Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 12),
                          Text('正在进行网络诊断...'),
                        ],
                      )
                    else if (_diagnosticsResult != null)
                      _buildDiagnosticsResult()
                    else
                      const Text('点击刷新按钮开始诊断'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 帮助信息
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.help_outline,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '常见问题解决方案',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('• 确保设备已连接到互联网'),
                    const SizedBox(height: 4),
                    const Text('• 检查防火墙或代理设置'),
                    const SizedBox(height: 4),
                    const Text('• 验证API服务器地址是否正确'),
                    const SizedBox(height: 4),
                    const Text('• 尝试切换网络环境（WiFi/移动数据）'),
                    const SizedBox(height: 4),
                    const Text('• 确认设备时间设置正确'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosticsResult() {
    final result = _diagnosticsResult!;
    final summary = result['diagnostics_summary'] as String? ?? '无诊断信息';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 诊断摘要
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            summary,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // 详细测试结果
        Text(
          '详细测试结果:',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        
        _buildTestResultItem('基础网络连接', result['basic_connection']),
        _buildTestResultItem('DNS解析', result['dns_resolution']),
        _buildTestResultItem('SSL证书验证', result['ssl_verification']),
        if (result['api_connection'] != null)
          _buildTestResultItem('API服务器连接', result['api_connection']),
        
        const SizedBox(height: 8),
        Text(
          '诊断时间: ${result['timestamp'] ?? '未知'}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildTestResultItem(String testName, dynamic result) {
    final isSuccess = result == true;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: isSuccess ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(testName),
          const Spacer(),
          Text(
            isSuccess ? '通过' : '失败',
            style: TextStyle(
              color: isSuccess ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
