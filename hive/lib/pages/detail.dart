import 'package:flutter/material.dart';
import 'package:myhive/common/views.dart';
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
      appBar: getAppBar(context, title),
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
    final PlatformWebViewController controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..hiveLoad(htmlContent);

    return SizedBox(
      child: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: controller),
      ).build(context),
    );
  }
}
