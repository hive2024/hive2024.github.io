import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/main.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:myhive/pages/debug.dart';
import 'package:myhive/pages/home2.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageDownload extends StatelessWidget {
  // late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    var viewModel = context.watch<MyAppViewModel>();
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
            Row(
              children: [
                FilledButton.icon(
                    onPressed: () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeTabPage2();
                        })),
                    icon: Icon(Icons.gpp_good_outlined),
                    label: Text("跳过:")),
                FilledButton.icon(
                    onPressed: () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return PageDebug();
                        })),
                    icon: Icon(Icons.gpp_good_outlined),
                    label: Text("信息")),
              ],
            ),
            H4,
            MyButton(
              text: al.get_start,
              onPressed: () => viewModel.clickDownload(),
            )
          ],
        ),
      ),
    );
  }
}
