import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/tools.dart';
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
      printLog("create video $bannerVideo");
      bannerWidget = HomeVideoView(videoUrl: bannerVideo);
      // bannerWidget = HomeYTView();
    } else {
      printLog("create default image");
      bannerWidget = SizedBox(
        height: 200,
        child: Image.network(Global.defaultBanner),
      );
    }

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
    final PlatformWebViewController controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..hiveLoad(html);

    return SizedBox(
      height: 400,
      child: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: controller),
      ).build(context),
    );
  }
}

class HomeVideoView extends StatelessWidget {
  const HomeVideoView({super.key, required this.videoUrl});

  final videoUrl;

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppViewModel>();
    // var html = appState.homeVideoHtml;
    final PlatformWebViewController controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadHtmlString(getHtmlBody(videoUrl));

    return Container(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PlatformWebViewWidget(
          PlatformWebViewWidgetCreationParams(controller: controller),
        ).build(context),
      ),
    );
  }
}
