import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/main.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:myhive/pages/home2.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class PageDownload extends StatelessWidget {
  // late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<MyAppViewModel>();
    viewModel.loadDownload();
    String bannerVideo = viewModel.bannerVideo;
    Widget bannerWidget;
    if (bannerVideo.isNotEmpty) {
      print("create video $bannerVideo");
      bannerWidget = VideoApp(url: bannerVideo);
    } else {
      print("create default image");
      bannerWidget = SizedBox(
        height: 200,
        child: Image.network(Global.defaultBanner),
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bannerWidget,
            Expanded(flex: 1, child: HomeHtmlView()),
            IconButton(
                onPressed: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeTabPage2();
                    })),
                icon: Icon(Icons.bug_report)),
            MyButton(
              text: "Download",
              onPressed: () => viewModel.clickDownload(),
            )
          ],
        ),
      ),
    );
  }
}
