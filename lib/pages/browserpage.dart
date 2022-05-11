import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';




class WebPage extends StatelessWidget { const
  WebPage({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
