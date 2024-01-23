import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

class PagePlay extends StatelessWidget {
  const PagePlay({
    super.key,
    required this.myTitle,
  });

  final myTitle;

  @override
  Widget build(BuildContext context) {
    final userPlatform = window.navigator.platform;
    final PlatformWebViewController _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadHtmlString('''<h2>Norwegian Mountain Trip</h2>
<img border="0" src="https://www.runoob.com/images/pulpit.jpg" alt="Pulpit rock" width="304" height="228">
''');

    return Container(
      color: Colors.amber,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 200,
            //   child: PlatformWebViewWidget(
            //     PlatformWebViewWidgetCreationParams(controller: _controller),
            //   ).build(context),
            // ),
            SizedBox(
              width: 400,
              height: 100,
              child: Container(
                color: Colors.cyan,
                child: Text("HOME-$myTitle-11"),
              ),
            ),
            SizedBox(
              width: 400,
              height: 100,
              child: Container(
                color: Colors.cyan,
                child: Text("HOME-$myTitle-22"),
              ),
            ),
            SizedBox(
              width: 400,
              height: 100,
              child: Container(
                color: Colors.cyan,
                child: Text("HOME-$myTitle-33"),
              ),
            ),
            SizedBox(
              width: 400,
              height: 100,
              child: Container(
                color: Colors.cyan,
                child: Text("HOME-$myTitle-44"),
              ),
            ),
            SizedBox(
              width: 400,
              height: 100,
              child: Container(
                color: Colors.cyan,
                child: Text("HOME-$myTitle-55"),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     color: Colors.cyan,
            //     child: Text("HOME-$myTitle-66"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
