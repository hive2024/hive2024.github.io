import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class PageEvent extends StatelessWidget {
  const PageEvent({
    super.key,
    required this.eventId,
  });

  final String eventId;

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<MyAppViewModel>();
    viewModel.getActDetail(eventId);
    var html = viewModel.activityDetail.desc;
    PlatformWebViewController? controller;
    if (html != null) {
      controller = PlatformWebViewController(
        const PlatformWebViewControllerCreationParams(),
      )..loadHtmlString(html);
    }

    return Scaffold(
      body: SizedBox(
        height: 400,
        child: controller != null
            ? PlatformWebViewWidget(
                PlatformWebViewWidgetCreationParams(controller: controller),
              ).build(context)
            : CircularProgressIndicator(color: mainColor),
      ),
    );
  }
}
