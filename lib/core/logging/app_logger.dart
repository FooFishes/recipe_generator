import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_generator/core/logging/log_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLogger {
  static AppLogger? _instance;
  static late Logger _logger;
  static LogConfig _config = LogConfig.development;
  static String? _logFilePath;
  static final List<String> _webLogBuffer = []; // Web端日志缓存
  
  AppLogger._();
  
  static AppLogger get instance {
    _instance ??= AppLogger._();
    return _instance!;
  }
  
  /// Initialize the logger with the appropriate configuration
  static Future<void> initialize({LogConfig? config}) async {
    _config = config ?? (kDebugMode ? LogConfig.development : LogConfig.production);
    
    if (!_config.enabled!) return;
    
    // Setup log file path for file output (only for non-web platforms)
    if ((_config.outputType == LogOutputType.file || _config.outputType == LogOutputType.both) && !kIsWeb) {
      await _setupLogFile();
    }
    
    _logger = Logger(
      level: _config.toLoggerLevel(),
      printer: _createPrinter(),
      output: _createOutput(),
      filter: _createFilter(),
    );
  }
  
  static LogFilter _createFilter() {
    return ProductionFilter();
  }
  
  static LogPrinter _createPrinter() {
    if (_config.outputType == LogOutputType.console || _config.outputType == LogOutputType.both) {
      return PrettyPrinter(
        methodCount: _config.showStackTrace! ? 2 : 0,
        errorMethodCount: _config.showStackTrace! ? 8 : 0,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: _config.showTimestamp! ? DateTimeFormat.onlyTimeAndSinceStart : DateTimeFormat.none,
      );
    } else {
      // For file output, use simpler format
      return SimplePrinter();
    }
  }
  
  static LogOutput _createOutput() {
    final outputs = <LogOutput>[];
    
    if (_config.outputType == LogOutputType.console || _config.outputType == LogOutputType.both) {
      outputs.add(ConsoleOutput());
    }
    
    if ((_config.outputType == LogOutputType.file || _config.outputType == LogOutputType.both)) {
      if (kIsWeb) {
        // Web平台使用自定义输出，将日志存储到内存缓存
        outputs.add(_WebLogOutput());
      } else if (_logFilePath != null) {
        outputs.add(FileOutput(file: File(_logFilePath!)));
      }
    }
    
    return MultiOutput(outputs);
  }
  
  static Future<void> _setupLogFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logDir = Directory('${directory.path}/logs');
      
      if (!await logDir.exists()) {
        await logDir.create(recursive: true);
      }
      
      final now = DateTime.now();
      final timestamp = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
      _logFilePath = '${logDir.path}/${_config.fileNamePrefix}_$timestamp.log';
      
      // Clean up old log files if needed
      await _cleanupOldLogs(logDir);
    } catch (e) {
      debugPrint('Failed to setup log file: $e');
    }
  }
  
  static Future<void> _cleanupOldLogs(Directory logDir) async {
    try {
      final files = logDir.listSync()
          .where((entity) => entity is File && entity.path.contains(_config.fileNamePrefix!))
          .cast<File>()
          .toList();
      
      // Sort by last modified date (newest first)
      files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
      
      // Keep only the specified number of files
      if (files.length > _config.maxFileCount!) {
        final filesToDelete = files.skip(_config.maxFileCount!);
        for (final file in filesToDelete) {
          await file.delete();
        }
      }
    } catch (e) {
      debugPrint('Failed to cleanup old logs: $e');
    }
  }
  
  // Logging methods
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_config.enabled!) return;
    _logger.d(message, error: error, stackTrace: stackTrace);
  }
  
  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_config.enabled!) return;
    _logger.i(message, error: error, stackTrace: stackTrace);
  }
  
  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_config.enabled!) return;
    _logger.w(message, error: error, stackTrace: stackTrace);
  }
  
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_config.enabled!) return;
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
  
  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_config.enabled!) return;
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
  
  // Utility methods
  static void logMethodEntry(String className, String methodName, [Map<String, dynamic>? params]) {
    if (kDebugMode) {
      final paramsStr = params != null ? ' with params: $params' : '';
      debug('[$className.$methodName] Entry$paramsStr');
    }
  }
  
  static void logMethodExit(String className, String methodName, [dynamic result]) {
    if (kDebugMode) {
      final resultStr = result != null ? ' with result: $result' : '';
      debug('[$className.$methodName] Exit$resultStr');
    }
  }
  
  static void logApiCall(String method, String url, [Map<String, dynamic>? params]) {
    info('API Call: $method $url', params);
  }
  
  static void logApiResponse(String method, String url, int statusCode, [dynamic response]) {
    if (statusCode >= 200 && statusCode < 300) {
      info('API Response: $method $url -> $statusCode');
    } else {
      warning('API Response: $method $url -> $statusCode', response);
    }
  }
  
  static void logUserAction(String action, [Map<String, dynamic>? context]) {
    info('User Action: $action', context);
  }
  
  static void logPerformance(String operation, Duration duration, [Map<String, dynamic>? context]) {
    final ms = duration.inMilliseconds;
    final level = ms > 1000 ? 'WARNING' : 'INFO';
    final message = 'Performance: $operation took ${ms}ms';
    
    if (level == 'WARNING') {
      warning(message, context);
    } else {
      info(message, context);
    }
  }
  
  /// Get current log file path for export
  static String? get currentLogFilePath => _logFilePath;
  
  /// Get all available log files
  static Future<List<File>> getLogFiles() async {
    try {
      if (kIsWeb) {
        // Web平台返回空列表，因为无法访问文件系统
        return [];
      }
      
      final directory = await getApplicationDocumentsDirectory();
      final logDir = Directory('${directory.path}/logs');
      
      if (!await logDir.exists()) {
        return [];
      }
      
      return logDir.listSync()
          .where((entity) => entity is File && entity.path.contains(_config.fileNamePrefix!))
          .cast<File>()
          .toList();
    } catch (e) {
      error('Failed to get log files', e);
      return [];
    }
  }
  
  /// Export logs to a specific directory
  static Future<String?> exportLogs(String targetPath) async {
    try {
      if (kIsWeb) {
        // Web平台将日志内容保存到SharedPreferences
        await _saveWebLogsToStorage();
        return 'Web logs saved to browser storage';
      }
      
      final logFiles = await getLogFiles();
      if (logFiles.isEmpty) {
        warning('No log files found to export');
        return null;
      }
      
      final targetDir = Directory(targetPath);
      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }
      
      final exportDir = Directory('${targetDir.path}/logs_export_${DateTime.now().millisecondsSinceEpoch}');
      await exportDir.create();
      
      for (final logFile in logFiles) {
        final fileName = logFile.path.split(Platform.pathSeparator).last;
        final targetFile = File('${exportDir.path}/$fileName');
        await logFile.copy(targetFile.path);
      }
      
      info('Logs exported to: ${exportDir.path}');
      return exportDir.path;
    } catch (e) {
      error('Failed to export logs', e);
      return null;
    }
  }
  
  /// Web平台特有方法：获取缓存的日志内容
  static List<String> getWebLogBuffer() {
    return List.from(_webLogBuffer);
  }
  
  /// Web平台特有方法：清空日志缓存
  static void clearWebLogBuffer() {
    _webLogBuffer.clear();
  }
  
  /// Web平台特有方法：将日志保存到本地存储
  static Future<void> _saveWebLogsToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final logContent = _webLogBuffer.join('\n');
      await prefs.setString('app_logs_${DateTime.now().millisecondsSinceEpoch}', logContent);
      info('Web logs saved to SharedPreferences');
    } catch (e) {
      error('Failed to save web logs to storage', e);
    }
  }
  
  /// Web平台特有方法：从本地存储获取历史日志
  static Future<List<String>> getWebStoredLogs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys().where((key) => key.startsWith('app_logs_'));
      final logs = <String>[];
      
      for (final key in keys) {
        final log = prefs.getString(key);
        if (log != null) {
          logs.add(log);
        }
      }
      
      return logs;
    } catch (e) {
      error('Failed to get stored web logs', e);
      return [];
    }
  }
}

/// Web平台专用的日志输出类
class _WebLogOutput extends LogOutput {
  static const int _maxBufferSize = 1000; // 限制缓存大小
  
  @override
  void output(OutputEvent event) {
    final logLine = event.lines.join('\n');
    AppLogger._webLogBuffer.add(logLine);
    
    // 限制缓存大小，删除最旧的日志
    if (AppLogger._webLogBuffer.length > _maxBufferSize) {
      AppLogger._webLogBuffer.removeAt(0);
    }
  }
}