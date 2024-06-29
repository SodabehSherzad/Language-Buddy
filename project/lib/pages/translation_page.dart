import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TranslatePage extends StatelessWidget {
  static const routeName = '/translate';
  final String initialUrl =
      'https://translate.google.com/?hl=en&sl=auto&tl=en&op=translate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: WebView(
        initialUrl: initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

