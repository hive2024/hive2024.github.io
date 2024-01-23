import 'dart:html';

import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class PageHome2 extends StatelessWidget {
  // late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    var appState = context.read<MyAppViewModel>();
    String bannerVideo = appState.bannerVideo;
    Widget bannerWidget;
    if (bannerVideo.isNotEmpty) {
      print("create video $bannerVideo");
      bannerWidget = VideoApp(url: bannerVideo);
      // } else if (bannerImage.isNotEmpty) {
      //   print("create image");
      //   bannerWidget = SizedBox(
      //     height: 200,
      //     child: Image.network(bannerImage),
      //   );
    } else {
      print("create default image");
      bannerWidget = SizedBox(
        height: 200,
        child: Image.network(Global.defaultBanner),
      );
    }
    final userPlatform = window.navigator.platform;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        bannerWidget,
        Expanded(flex: 1, child: HomeHtmlView()),
      ],
    );
  }
}

class HomeHtmlView extends StatelessWidget {
  const HomeHtmlView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppViewModel>();
    var html = appState.homeHtml;
    final userPlatform = window.navigator.platform;
    final PlatformWebViewController _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadHtmlString(html);

    return SizedBox(
      height: 400,
      child: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _controller),
      ).build(context),
    );
  }
}
