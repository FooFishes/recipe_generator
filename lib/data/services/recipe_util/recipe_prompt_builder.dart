import 'package:dio/dio.dart';

/// 网络错误处理器
/// 
/// 提供统一的网络错误处理和用户友好的错误信息转换。
/// 将错误处理逻辑从主服务类中分离，提高代码复用性。
class NetworkErrorHandler {
  /// 处理Dio异常并转换为用户友好的错误信息
  /// 
  /// 参数：
  /// - [dioException] Dio网络请求异常
  /// 
  /// 返回：包含用户友好错误信息的Exception
  static Exception handleDioError(DioException dioException) {
    
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('连接超时，请检查网络设置');
        
      case DioExceptionType.sendTimeout:
        return Exception('发送请求超时，请检查网络连接');
        
      case DioExceptionType.receiveTimeout:
        return Exception('接收响应超时，请稍后重试');
        
      case DioExceptionType.badResponse:
        return _handleBadResponse(dioException);
        
      case DioExceptionType.cancel:
        return Exception('请求已取消');
        
      case DioExceptionType.unknown:
        return _handleUnknownError(dioException);
        
      default:
        return Exception('未知网络错误: ${dioException.message}');
    }
  }
  
  /// 处理HTTP响应错误
  static Exception _handleBadResponse(DioException dioException) {
    final statusCode = dioException.response?.statusCode;
    
    switch (statusCode) {
      case 400:
        return Exception('请求参数错误，请检查输入内容');
      case 401:
        return Exception('API密钥无效，请检查密钥设置');
      case 403:
        return Exception('没有访问权限，请检查API密钥');
      case 404:
        return Exception('请求的资源不存在');
      case 429:
        return Exception('请求过于频繁，请稍后再试');
      case 500:
        return Exception('服务器内部错误，请稍后重试');
      case 502:
        return Exception('网关错误，请稍后重试');
      case 503:
        return Exception('服务暂时不可用，请稍后重试');
      default:
        return Exception('服务器错误 ($statusCode)');
    }
  }
  
  /// 处理未知类型错误
  static Exception _handleUnknownError(DioException dioException) {
    final errorMessage = dioException.message?.toLowerCase() ?? '';
    
    // DNS解析失败
    if (errorMessage.contains('failed host lookup') || 
        errorMessage.contains('host lookup')) {
      return Exception('网络连接失败：无法解析服务器地址\n'
          '请检查：\n'
          '1. 网络连接是否正常\n'
          '2. 是否能访问外网\n'
          '3. DNS设置是否正确');
    }
    
    // 连接被拒绝
    if (errorMessage.contains('connection refused')) {
      return Exception('连接被拒绝，请检查网络设置');
    }
    
    // SSL/TLS证书问题
    if (errorMessage.contains('certificate') || 
        errorMessage.contains('ssl') || 
        errorMessage.contains('tls')) {
      return Exception('SSL证书验证失败，请检查网络安全设置');
    }
    
    // 网络不可达
    if (errorMessage.contains('network is unreachable')) {
      return Exception('网络不可达，请检查网络连接');
    }
    
    // 默认错误
    return Exception('网络连接失败：${dioException.message}\n请检查网络设置');
  }
  
  /// 获取错误的简短描述（用于日志记录）
  static String getErrorSummary(Exception exception) {
    final message = exception.toString();
    
    if (message.contains('连接超时')) return 'CONNECTION_TIMEOUT';
    if (message.contains('API密钥无效')) return 'INVALID_API_KEY';
    if (message.contains('请求过于频繁')) return 'RATE_LIMIT_EXCEEDED';
    if (message.contains('DNS解析失败')) return 'DNS_RESOLUTION_FAILED';
    if (message.contains('SSL证书')) return 'SSL_CERTIFICATE_ERROR';
    if (message.contains('服务器错误')) return 'SERVER_ERROR';
    
    return 'UNKNOWN_ERROR';
  }
}
