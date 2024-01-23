import 'dart:html';

import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class PageDetail extends StatelessWidget {
  const PageDetail({
    super.key,
    required this.htmlContent,
    required this.title,
  });

  final String htmlContent;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context,title),
      body: DetailHtmlView(htmlContent: htmlContent),
    );
  }
}

class DetailHtmlView extends StatelessWidget {
  const DetailHtmlView({
    super.key,
    required this.htmlContent,
  });

  final String htmlContent;

  @override
  Widget build(BuildContext context) {
    final userPlatform = window.navigator.platform;
    final PlatformWebViewController _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadHtmlString(htmlContent);

    return SizedBox(
      height: 400,
      child: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _controller),
      ).build(context),
    );
  }
}
