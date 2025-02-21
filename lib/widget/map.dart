import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapPage extends StatefulWidget {
  final String url;
  const MapPage({Key? key, required this.url}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(
          JavaScriptMode.unrestricted) // ✅ JavaScript etkinleştirildi
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint('Sayfa yükleniyor: $url');
          },
          onPageFinished: (url) {
            debugPrint('Sayfa yüklendi: $url');
          },
          onWebResourceError: (error) {
            debugPrint('Hata: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        title: const Text(
          "🗺️ Harita Görüntüleme",
          style: TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.w700),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
