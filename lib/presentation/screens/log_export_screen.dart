import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_generator/core/logging/app_logger.dart';

class LogExportScreen extends StatefulWidget {
  const LogExportScreen({super.key});

  @override
  State<LogExportScreen> createState() => _LogExportScreenState();
}

class _LogExportScreenState extends State<LogExportScreen> {
  List<File> _logFiles = [];
  List<String> _webLogBuffer = [];
  bool _isLoading = false;
  String? _lastExportPath;

  @override
  void initState() {
    super.initState();
    _loadLogFiles();
  }

  Future<void> _loadLogFiles() async {
    setState(() => _isLoading = true);
    
    try {
      if (kIsWeb) {
        // Web平台加载内存中的日志缓存
        final webLogs = AppLogger.getWebLogBuffer();
        setState(() {
          _webLogBuffer = webLogs;
          _isLoading = false;
        });
        AppLogger.debug('LogExportScreen: Loaded ${webLogs.length} web log entries');
      } else {
        // 移动端加载文件日志
        final files = await AppLogger.getLogFiles();
        setState(() {
          _logFiles = files;
          _isLoading = false;
        });
        AppLogger.debug('LogExportScreen: Loaded ${files.length} log files');
      }
    } catch (e) {
      AppLogger.error('LogExportScreen: Failed to load log files', e);
      setState(() => _isLoading = false);
      if (mounted && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载日志文件失败: $e')),
        );
      }
    }
  }

  Future<void> _exportLogs() async {
    setState(() => _isLoading = true);
    
    try {
      String? exportPath;
      
      if (kIsWeb) {
        // Web平台：导出到浏览器存储
        exportPath = await AppLogger.exportLogs('');
      } else {
        // 移动端：导出到文件系统
        final directory = await getExternalStorageDirectory() ?? await getApplicationDocumentsDirectory();
        exportPath = await AppLogger.exportLogs(directory.path);
      }
      
      setState(() {
        _isLoading = false;
        _lastExportPath = exportPath;
      });
      
      if (mounted && exportPath != null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(kIsWeb ? '日志已保存到浏览器存储' : '日志已导出到: $exportPath'),
              duration: const Duration(seconds: 5),
              action: kIsWeb ? null : SnackBarAction(
                label: '复制路径',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: exportPath!));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('路径已复制到剪贴板')),
                    );
                  }
                },
              ),
            ),
          );
        }
      } else if (mounted && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('导出失败，没有找到日志文件')),
        );
      }
    } catch (e) {
      AppLogger.error('LogExportScreen: Failed to export logs', e);
      setState(() => _isLoading = false);
      if (mounted && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导出失败: $e')),
        );
      }
    }
  }

  Future<void> _viewLogFile(File file) async {
    try {
      final content = await file.readAsString();
      if (mounted) {
        _showLogDialog(file.path.split(Platform.pathSeparator).last, content);
      }
    } catch (e) {
      AppLogger.error('LogExportScreen: Failed to read log file', e);
      if (mounted && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('读取日志文件失败: $e')),
        );
      }
    }
  }

  void _viewWebLog(String logContent) {
    _showLogDialog('Web日志', logContent);
  }

  void _showLogDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: SelectableText(
                    content,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: content));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('日志内容已复制到剪贴板')),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('复制'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日志导出'),
        actions: [
          IconButton(
            onPressed: _isLoading ? null : _loadLogFiles,
            icon: const Icon(Icons.refresh),
            tooltip: '刷新',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kIsWeb ? '当前日志状态：' : '当前日志文件路径：',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        kIsWeb 
                          ? '日志缓存在浏览器内存中 (${_webLogBuffer.length} 条记录)'
                          : AppLogger.currentLogFilePath ?? '未设置',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: (kIsWeb ? _webLogBuffer.isEmpty : _logFiles.isEmpty) ? null : _exportLogs,
                              icon: const Icon(Icons.download),
                              label: const Text(kIsWeb ? '保存到浏览器存储' : '导出所有日志'),
                            ),
                          ),
                        ],
                      ),
                      if (_lastExportPath != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          kIsWeb ? '上次操作: $_lastExportPath' : '上次导出路径: $_lastExportPath',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: kIsWeb 
                    ? _buildWebLogList()
                    : _buildMobileLogList(),
                ),
              ],
            ),
    );
  }

  Widget _buildWebLogList() {
    if (_webLogBuffer.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.web, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              '没有找到日志记录',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              '请先进行一些操作以生成日志',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _viewWebLog(_webLogBuffer.join('\n')),
                  icon: const Icon(Icons.visibility),
                  label: const Text('查看所有日志'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    final content = _webLogBuffer.join('\n');
                    Clipboard.setData(ClipboardData(text: content));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('日志内容已复制到剪贴板')),
                      );
                    }
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('复制所有日志'),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: _webLogBuffer.length,
            itemBuilder: (context, index) {
              final logEntry = _webLogBuffer[index];
              final isError = logEntry.contains('⛔') || logEntry.contains('ERROR');
              final isWarning = logEntry.contains('⚠️') || logEntry.contains('WARNING');
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ExpansionTile(
                  leading: Icon(
                    isError ? Icons.error : isWarning ? Icons.warning : Icons.info,
                    color: isError ? Colors.red : isWarning ? Colors.orange : Colors.blue,
                    size: 20,
                  ),
                  title: Text(
                    logEntry.length > 100 ? '${logEntry.substring(0, 100)}...' : logEntry,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: isError ? Colors.red : isWarning ? Colors.orange : null,
                    ),
                  ),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: SelectableText(
                        logEntry,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLogList() {
    if (_logFiles.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              '没有找到日志文件',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _logFiles.length,
      itemBuilder: (context, index) {
        final file = _logFiles[index];
        final stat = file.statSync();
        final fileName = file.path.split(Platform.pathSeparator).last;
        
        return ListTile(
          leading: const Icon(Icons.description),
          title: Text(fileName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('大小: ${_formatFileSize(stat.size)}'),
              Text('修改时间: ${_formatDate(stat.modified)}'),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _viewLogFile(file),
                icon: const Icon(Icons.visibility),
                tooltip: '查看',
              ),
              IconButton(
                onPressed: () async {
                  final content = await file.readAsString();
                  Clipboard.setData(ClipboardData(text: content));
                  if (mounted && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('日志内容已复制到剪贴板')),
                    );
                  }
                },
                icon: const Icon(Icons.copy),
                tooltip: '复制内容',
              ),
            ],
          ),
          isThreeLine: true,
        );
      },
    );
  }
}