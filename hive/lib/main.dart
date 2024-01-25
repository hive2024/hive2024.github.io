import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/extension.dart';
import 'package:myhive/pages/extension_detail.dart';
import 'package:myhive/pages/home2.dart';
import 'package:myhive/pages/mine.dart';
import 'package:myhive/pages/share.dart';
import 'package:myhive/pages/task.dart';
import 'package:myhive/pages/topup.dart';
import 'package:myhive/pages/withdraw.dart';
import 'package:myhive/test/test_api.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'common/strings.dart';
import 'pages/AppViewModel.dart';
import 'pages/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common/global.dart';
import 'pages/activity.dart';

// GetIt getIt = GetIt.instance;

void main() {
  // getIt.registerSingleton<MyAppViewModel>(MyAppViewModel(), signalsReady: true);
  WebViewPlatform.instance = WebWebViewPlatform();
  Global.init().then((e) => runApp(MyApp()));
  // runApp(VideoApp3());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppViewModel(),
      child: MaterialApp(
        title: Global.appName,
        // locale: const Locale('en', 'US'),
        // locale: Locale('es'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Global.mainColor,
          // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFF4CB2B6)),
        ),
        home: HomeTabPage2(),
        // home: VideoPlayerScreen(),
        // home: PageTask(),
        // home: PagePlay(myTitle: ""),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lc = AppLocalizations.of(context)?.localeName ?? 'en';
    print("current language = $lc");
    APIS.language = lc;
    context.read<MyAppViewModel>().startLoading(context);
    return Center(
      child: SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(color: Global.mainColor)),
    );
  }
}

class HomeTabPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> bottomNavPages = [
      // PageMine(),
      LoadingView(),
      PageHome2(), //1
      PageActivity(), //2
      PageShare(), //3
      PageMine(), //4
      PageTask(), //5
    ];
    var viewModel = context.watch<MyAppViewModel>();
    Widget page = bottomNavPages[viewModel.selectedPage];
    return Scaffold(
      body: page,
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: mainColor,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () => viewModel.selecte(context, 1),
            ),
            IconButton(
              icon: Icon(
                Icons.card_giftcard,
                color: Colors.white,
              ),
              onPressed: () => viewModel.selecte(context, 2),
            ),
            SizedBox(), // 增加一些间隔
            IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () => viewModel.selecte(context, 3),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () => viewModel.selecte(context, 4),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: mainColor,
        shape: CircleBorder(),
        onPressed: () => viewModel.selecte(context, 5),
        child: Icon(Icons.diamond),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
