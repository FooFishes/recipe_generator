import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/logging/app_logger.dart';

class BingWebViewScreen extends StatefulWidget {
  const BingWebViewScreen({super.key});

  @override
  State<BingWebViewScreen> createState() => _BingWebViewScreenState();
}

class _BingWebViewScreenState extends State<BingWebViewScreen> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    AppLogger.info('BingWebViewScreen初始化');
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // 更新加载进度
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
            AppLogger.info('WebView开始加载: $url');
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            AppLogger.info('WebView加载完成: $url');
          },
          onWebResourceError: (WebResourceError error) {
            AppLogger.error('WebView加载错误: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.bing.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('必应搜索'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
              AppLogger.logUserAction('刷新WebView');
            },
            tooltip: '刷新',
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}