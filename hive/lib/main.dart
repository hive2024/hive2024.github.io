import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myhive/common/tools.dart';
import 'package:myhive/pages/download.dart';
import 'package:myhive/pages/event.dart';
import 'package:myhive/pages/fb.dart';
import 'package:myhive/pages/home2.dart';
import 'package:myhive/pages/mine.dart';
import 'package:myhive/pages/share.dart';
import 'package:myhive/pages/task.dart';
import 'package:myhive/test/test_api.dart';
import 'common/strings.dart';
import 'pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:html';
import 'common/global.dart';
import 'pages/activity.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// GetIt getIt = GetIt.instance;

void main() async {
  print("kIsWeb = $kIsWeb");
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.instance.webAndDesktopInitialize(
      appId: "814806589053271",
      // appId: "942398130788099",
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
    print("sdk isWebSdkInitialized = ${FacebookAuth.instance.isWebSdkInitialized}");
  }
  Global.init().then((e) => runApp(MyApp()));
}

RegExp eventReg = RegExp(r'^/act/([\w-]+)$');
RegExp eventReg2 = RegExp(r'^/rule/([\w-]+)$');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    String path = settings.name ?? "";
    printLog("onGenerateRoute; path=$path");
    if (eventReg.hasMatch(path)) {
      final firstMatch = eventReg.firstMatch(path);
      final match = (firstMatch?.groupCount == 1) ? firstMatch?.group(1) : null;
      printLog("onGenerateRoute; >> PageEvent; match=$match");
      return MaterialPageRoute<void>(
        builder: (context) => PageEvent(eventId: match ?? "", canBack: false),
        settings: settings,
      );
    }
    if (eventReg2.hasMatch(path)) {
      final firstMatch = eventReg2.firstMatch(path);
      final match = (firstMatch?.groupCount == 1) ? firstMatch?.group(1) : null;
      printLog("onGenerateRoute; >> PageEvent; match=$match");
      return MaterialPageRoute<void>(
        builder: (context) => PageEvent(eventId: match ?? "", canBack: true),
        settings: settings,
      );
    }
    // If no match is found, [WidgetsApp.onUnknownRoute] handles it.
    return MaterialPageRoute<void>(
      builder: (context) => HomeTabPage2(),
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPlatform = window.navigator.platform;
    printLog("userPlatform = $userPlatform");
    return ChangeNotifierProvider(
      create: (context) => MyAppViewModel(),
      child: MaterialApp(
        title: Global.appName,
        initialRoute: "/",
        routes: {
          // "/": (context) => Global.isApp ? HomeTabPage2() : PageDownload(),
          "/": (context) => PageFacebook(),
        },
        onGenerateRoute: onGenerateRoute,
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
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: mainColors,
        ),
        // home: HomeTabPage2(),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lc = AppLocalizations.of(context)?.localeName ?? 'en';
    printLog("current language = $lc");
    APIS.language = lc;
    context.read<MyAppViewModel>().startLoading(context);
    return Center(
      child: SizedBox(
          width: 200,
          height: 200,
          child: Column(
            children: [
              CircularProgressIndicator(color: mainColor),
            ],
          )),
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
                color: colorF5,
              ),
              onPressed: () => viewModel.selecte(context, 1),
            ),
            IconButton(
              icon: Icon(
                Icons.card_giftcard,
                color: colorF5,
              ),
              onPressed: () => viewModel.selecte(context, 2),
            ),
            SizedBox(), // 增加一些间隔
            IconButton(
              icon: Icon(
                Icons.share,
                color: colorF5,
              ),
              onPressed: () => viewModel.selecte(context, 3),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: colorF5,
              ),
              onPressed: () => viewModel.selecte(context, 4),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: colorF5,
        backgroundColor: mainColor,
        shape: CircleBorder(),
        onPressed: () => viewModel.selecte(context, 5),
        child: Transform.rotate(angle: pi / 4, child: Icon(Icons.grid_view)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
