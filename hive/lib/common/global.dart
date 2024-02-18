import 'dart:html';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myhive/common/tools.dart';
import 'package:myhive/json/user.dart';
import 'package:myhive/test/test_api.dart';

class Global {
  // static late SharedPreferences _prefs;
  static String appName = "App";
  static String baseServer = "https://api.genesiscapitalgs.com/";

  static String defaultBanner =
      "https://static-web.bigolive.tv/as/bigo-static/reseller/banner.png";

  static String urlShareCode = "sc";
  static String urlAppCode = "ac";

  static User user = User.empty();
  static late Storage _localStorage;

  static bool login = true;

  static String platform = "";
  static Map<String, String> urlParams = {};
  static String shareCode = "";
  static bool isApp = false;

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _localStorage = window.localStorage;
    APIS.apiKey = _localStorage['api_key'] ?? "";
    printLog("init apiKey =  ${APIS.apiKey}");

    platform = window.navigator.platform ?? "Empty";
    urlParams = Uri.base.queryParameters;
    String newSC = urlParams[urlShareCode] ?? "";
    String newAC = urlParams[urlAppCode] ?? "";
    isApp = (platform.contains("iPhone") ||
        platform.contains("Empty") ||
        newAC == "1");
    shareCode = _localStorage[urlShareCode] ?? "";
    if (newSC.isNotEmpty && newSC != shareCode) {
      shareCode = newSC;
      _localStorage[urlShareCode] = newSC;
    }
  }

  static bool isApple() {
    return platform.contains("iPhone");
  }

  static saveAPIKey(String apiKey) async {
    printLog("saveAPIKey >> $apiKey");
    _localStorage["api_key"] = apiKey;
  }
}
