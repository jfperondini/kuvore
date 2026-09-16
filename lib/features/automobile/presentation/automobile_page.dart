import 'dart:io';

import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants/app_constants.dart';

class AutomobilePage extends StatefulWidget {
  const AutomobilePage({super.key});

  @override
  State<AutomobilePage> createState() => _AutomobilePageState();
}

class _AutomobilePageState extends State<AutomobilePage> {
  WebViewController? _controller;

  bool get _isWindows => !kIsWeb && Platform.isWindows;

  bool get _isWeb => kIsWeb;

  bool _windowsOpened = false;

  @override
  void initState() {
    super.initState();

    if (_isWindows) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _openWindowsWebView();
      });
      return;
    }

    final controller = WebViewController();

    if (!_isWeb) {
      controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    }

    controller.loadRequest(Uri.parse(AppConstants.automobileUrl));

    _controller = controller;
  }

  Future<void> _openWindowsWebView() async {
    if (_windowsOpened) return;

    _windowsOpened = true;

    final available = await WebviewWindow.isWebviewAvailable();

    if (!available) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('WebView2 não está disponível neste Windows.'),
        ),
      );

      return;
    }

    final webview = await WebviewWindow.create(
      configuration: const CreateConfiguration(
        title: 'KUVORE - Automóvel',
        windowWidth: 1200,
        windowHeight: 800,
      ),
    );

    webview.launch(AppConstants.automobileUrl);
  }

  @override
  Widget build(BuildContext context) {
    if (_isWindows) {
      return Scaffold(
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Abrindo WebView...'),
            ],
          ),
        ),
      );
    }

    return Scaffold(body: WebViewWidget(controller: _controller!));
  }
}
