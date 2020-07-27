import 'package:aapgblogflutter/screens/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewModel extends StatefulWidget {
  final String url;

  WebViewModel({this.url});

  @override
  _WebViewModelState createState() => _WebViewModelState();
}

class _WebViewModelState extends State<WebViewModel> {
  final _key = UniqueKey();
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (_) {
      return SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            Container(
              color: isDarkMode ? Colors.black : Colors.green[800],
              height: 68,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 30),
                      color: Colors.white,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        height: 55,
                        width: 110,
                        child: Image.asset('assets/images/blog_logo.png')),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(''),
                  )
                ],
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            isDarkMode ? Colors.black54 : Colors.green[700])))
                : Container(height: 0, width: 0, color: Colors.transparent)
          ],
        ),
      );
    }));
  }
}
