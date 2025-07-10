import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// 网络连接测试和诊断服务
///
/// 提供网络连接状态检测、DNS解析测试和请求重试机制。
/// 主要用于诊断和解决Android release版本中的网络连接问题。
///
/// 主要功能：
/// - 基本网络连接测试
/// - API服务器连接测试
/// - DNS解析能力检测
/// - 带重试机制的网络请求包装器
/// - 详细的网络诊断信息收集
class NetworkService {
  /// 内部使用的HTTP客户端，配置较短的超时时间用于快速测试
  static final Dio _dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 15)
    ..options.receiveTimeout = const Duration(seconds: 15)
    ..options.followRedirects = true
    ..options.maxRedirects = 3
    ..options.headers['User-Agent'] = 'RecipeGenerator/1.0.0 (${kReleaseMode ? "Release" : "Debug"})';
  
  /// 网络重试配置
  static const int _defaultMaxRetries = 3;
  static const Duration _defaultRetryDelay = Duration(seconds: 2);

  /// 测试API服务器连接
  /// 
  /// 直接访问API服务器来检测是否能正常建立连接。
  /// 这是检测DNS解析和服务器可达性的关键测试。
  /// 
  /// 参数：
  /// - [apiUrl] API服务器地址
  /// 
  /// 返回：
  /// - [Future<bool>] true表示API服务器可访问，false表示无法连接
  static Future<bool> testApiConnection(String apiUrl) async {
    try {
      
      // 直接访问API服务器根路径，检测连通性
      final response = await _dio.get(apiUrl);
      
      return response.statusCode != null && response.statusCode! < 500;
    } catch (e) {
      return false;
    }
  }
  
  /// 测试基础网络连接
  ///
  /// 使用可靠的公共服务测试基础网络连接能力。
  ///
  /// 返回：
  /// - [Future<bool>] true表示网络连接正常，false表示网络不可用
  static Future<bool> testBasicConnection() async {
    // 尝试多个可靠的测试端点
    final testUrls = [
      'https://www.google.com/generate_204',  // Google连通性检测
      'https://httpbin.org/status/200',       // HTTP测试服务
      'https://www.baidu.com',                // 国内网络测试
    ];

    for (final url in testUrls) {
      try {
        final response = await _dio.get(url);
        if (response.statusCode != null && response.statusCode! < 400) {
          return true;
        }
      } catch (e) {
        // 继续尝试下一个URL
        continue;
      }
    }

    return false;
  }


  /// 带重试机制的网络请求包装器
  /// 
  /// 为网络请求提供自动重试功能，可以有效处理临时的网络波动和DNS解析失败。
  /// 适用于提高关键网络请求的成功率，如API调用。
  /// 
  /// 参数：
  /// - [request] 要执行的网络请求函数
  /// - [maxRetries] 最大重试次数，默认3次
  /// - [delay] 重试间隔时间，默认2秒
  /// 
  /// 返回：
  /// - [Future<T>] 请求成功时返回结果
  /// 
  /// 异常：
  /// - [Exception] 所有重试都失败时抛出最后一次的异常
  static Future<T> retryRequest<T>(
    Future<T> Function() request, {
    int maxRetries = _defaultMaxRetries,
    Duration delay = _defaultRetryDelay,
  }) async {
    int attempts = 0;
    Exception? lastException;

    while (attempts < maxRetries) {
      try {
        attempts++;
        
        // 执行实际的网络请求
        final result = await request();
        return result;
      } catch (e) {
        lastException = e is Exception ? e : Exception(e.toString());
        
        // 如果还有重试机会，等待一段时间后继续
        if (attempts < maxRetries) {
          await Future.delayed(delay);
        }
      }
    }

    // 所有重试都失败，抛出最后一次的异常
    throw lastException ?? Exception('网络请求失败');
  }
  
  /// 执行网络诊断
  ///
  /// 执行一系列网络连接测试，返回详细的诊断信息。
  ///
  /// 参数：
  /// - [apiUrl] 要测试的API服务器地址
  ///
  /// 返回：
  /// - [Future<Map<String, dynamic>>] 包含诊断结果的映射
  static Future<Map<String, dynamic>> performNetworkDiagnostics({
    String? apiUrl,
  }) async {

    final diagnostics = <String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'build_mode': kReleaseMode ? 'release' : 'debug',
      'basic_connection': false,
      'api_connection': false,
      'dns_resolution': false,
      'ssl_verification': false,
      'diagnostics_summary': '',
      'detailed_errors': <String>[],
    };

    try {
      // 测试基础网络连接
      diagnostics['basic_connection'] = await testBasicConnection();

      // 测试DNS解析
      diagnostics['dns_resolution'] = await _testDnsResolution();

      // 测试SSL证书验证
      diagnostics['ssl_verification'] = await _testSslVerification();

      // 测试API连接（如果提供了URL）
      if (apiUrl != null) {
        final apiResult = await _testApiConnectionDetailed(apiUrl);
        diagnostics['api_connection'] = apiResult['success'];
        if (apiResult['error'] != null) {
          diagnostics['detailed_errors'].add('API连接: ${apiResult['error']}');
        }
      }

      // 生成诊断摘要
      diagnostics['diagnostics_summary'] = _generateDiagnosticsSummary(diagnostics);

      return diagnostics;
    } catch (e) {
      diagnostics['error'] = e.toString();
      diagnostics['diagnostics_summary'] = '网络诊断失败: $e';
      return diagnostics;
    }
  }

  /// 测试DNS解析能力
  static Future<bool> _testDnsResolution() async {
    try {
      // 尝试解析一个已知的域名
      final response = await _dio.get('https://www.google.com/generate_204');
      return response.statusCode == 204;
    } catch (e) {
      return false;
    }
  }

  /// 测试SSL证书验证
  static Future<bool> _testSslVerification() async {
    try {
      // 测试HTTPS连接
      final response = await _dio.get('https://httpbin.org/status/200');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// 详细的API连接测试
  static Future<Map<String, dynamic>> _testApiConnectionDetailed(String apiUrl) async {
    try {
      final response = await _dio.get(apiUrl);
      return {
        'success': response.statusCode != null && response.statusCode! < 500,
        'status_code': response.statusCode,
        'error': null,
      };
    } catch (e) {
      return {
        'success': false,
        'status_code': null,
        'error': e.toString(),
      };
    }
  }
  
  /// 生成诊断摘要
  static String _generateDiagnosticsSummary(Map<String, dynamic> diagnostics) {
    final basicConnection = diagnostics['basic_connection'] as bool;
    final apiConnection = diagnostics['api_connection'] as bool?;
    final dnsResolution = diagnostics['dns_resolution'] as bool? ?? false;
    final sslVerification = diagnostics['ssl_verification'] as bool? ?? false;
    final buildMode = diagnostics['build_mode'] as String? ?? 'unknown';
    final errors = diagnostics['detailed_errors'] as List<String>? ?? [];

    final summary = StringBuffer();
    summary.writeln('构建模式: $buildMode');

    if (basicConnection && dnsResolution && sslVerification && (apiConnection ?? true)) {
      summary.writeln('✅ 网络连接完全正常');
    } else {
      summary.writeln('❌ 检测到网络问题:');

      if (!basicConnection) {
        summary.writeln('• 基础网络连接失败');
      }
      if (!dnsResolution) {
        summary.writeln('• DNS解析失败');
      }
      if (!sslVerification) {
        summary.writeln('• SSL证书验证失败');
      }
      if (apiConnection == false) {
        summary.writeln('• API服务器不可达');
      }

      if (errors.isNotEmpty) {
        summary.writeln('\n详细错误信息:');
        for (final error in errors) {
          summary.writeln('• $error');
        }
      }

      summary.writeln('\n建议解决方案:');
      if (!basicConnection || !dnsResolution) {
        summary.writeln('• 检查网络连接和DNS设置');
        summary.writeln('• 尝试切换网络环境（WiFi/移动数据）');
      }
      if (!sslVerification) {
        summary.writeln('• 检查设备时间设置是否正确');
        summary.writeln('• 确认网络环境支持HTTPS连接');
      }
      if (apiConnection == false) {
        summary.writeln('• 验证API服务器地址是否正确');
        summary.writeln('• 检查API服务器是否正常运行');
      }
    }

    return summary.toString().trim();
  }
}