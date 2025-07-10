// ignore_for_file: avoid_print

import 'lib/data/services/storage/settings_service.dart';

/// 测试无默认值配置逻辑
/// 
/// 验证模型名称和baseUrl的配置逻辑与API密钥完全一致：
/// - 未配置时返回null
/// - 删除后返回null
/// - 不提供任何默认值
/// - 用户必须自己配置所有项目
void main() async {
  print('开始测试无默认值配置逻辑...\n');
  
  final settingsService = SettingsService();
  
  // 测试模型配置
  print('=== 测试模型配置逻辑 ===');
  
  // 1. 测试初始状态（未配置）
  final initialModel = await settingsService.getModel();
  print('初始模型配置: $initialModel');
  print('初始状态应为null: ${initialModel == null ? "✅ 通过" : "❌ 失败"}');
  
  // 2. 测试设置自定义模型
  const customModel = 'gpt-4o-mini';
  await settingsService.setModel(customModel);
  final savedModel = await settingsService.getModel();
  print('保存的模型: $savedModel');
  print('模型设置测试: ${savedModel == customModel ? "✅ 通过" : "❌ 失败"}');
  
  // 3. 测试hasModel
  final hasModel = await settingsService.hasModel();
  print('是否有模型配置: $hasModel');
  print('hasModel测试: ${hasModel ? "✅ 通过" : "❌ 失败"}');
  
  // 4. 测试删除模型
  await settingsService.deleteModel();
  final modelAfterDelete = await settingsService.getModel();
  print('删除后的模型: $modelAfterDelete');
  print('删除后应为null: ${modelAfterDelete == null ? "✅ 通过" : "❌ 失败"}');
  
  // 5. 测试删除后hasModel
  final hasModelAfterDelete = await settingsService.hasModel();
  print('删除后hasModel: ${hasModelAfterDelete ? "❌ 失败" : "✅ 通过"}');
  
  print('\n=== 测试BaseURL配置逻辑 ===');
  
  // 1. 测试初始状态（未配置）
  final initialBaseUrl = await settingsService.getBaseUrl();
  print('初始BaseURL配置: $initialBaseUrl');
  print('初始状态应为null: ${initialBaseUrl == null ? "✅ 通过" : "❌ 失败"}');
  
  // 2. 测试设置自定义BaseURL
  const customBaseUrl = 'https://api.openai.com/v1/chat/completions';
  await settingsService.setBaseUrl(customBaseUrl);
  final savedBaseUrl = await settingsService.getBaseUrl();
  print('保存的BaseURL: $savedBaseUrl');
  print('BaseURL设置测试: ${savedBaseUrl == customBaseUrl ? "✅ 通过" : "❌ 失败"}');
  
  // 3. 测试hasBaseUrl
  final hasBaseUrl = await settingsService.hasBaseUrl();
  print('是否有BaseURL配置: $hasBaseUrl');
  print('hasBaseUrl测试: ${hasBaseUrl ? "✅ 通过" : "❌ 失败"}');
  
  // 4. 测试删除BaseURL
  await settingsService.deleteBaseUrl();
  final baseUrlAfterDelete = await settingsService.getBaseUrl();
  print('删除后的BaseURL: $baseUrlAfterDelete');
  print('删除后应为null: ${baseUrlAfterDelete == null ? "✅ 通过" : "❌ 失败"}');
  
  // 5. 测试删除后hasBaseUrl
  final hasBaseUrlAfterDelete = await settingsService.hasBaseUrl();
  print('删除后hasBaseUrl: ${hasBaseUrlAfterDelete ? "❌ 失败" : "✅ 通过"}');
  
  print('\n=== 测试配置验证逻辑 ===');
  
  // 模拟Repository中的验证逻辑
  print('测试未配置时的验证...');
  
  final currentModel = await settingsService.getModel();
  final currentBaseUrl = await settingsService.getBaseUrl();
  
  print('当前模型配置: $currentModel');
  print('当前BaseURL配置: $currentBaseUrl');
  
  // 验证逻辑
  if (currentModel == null || currentModel.isEmpty) {
    print('✅ 模型验证：正确检测到未配置');
  } else {
    print('❌ 模型验证：应该检测到未配置');
  }
  
  if (currentBaseUrl == null || currentBaseUrl.isEmpty) {
    print('✅ BaseURL验证：正确检测到未配置');
  } else {
    print('❌ BaseURL验证：应该检测到未配置');
  }
  
  print('\n=== 测试完成 ===');
  print('配置逻辑已完全统一：所有配置项都必须由用户自己设置！');
  print('没有默认值，就像API密钥一样。');
}
