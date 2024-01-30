import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myhive/json/user.dart';
import 'package:myhive/test/test_api.dart';

class Global {
  // static late SharedPreferences _prefs;
  static String appName = "App";
  static String baseServer = "https://api.genesiscapitalgs.com/";

  static String defaultBanner =
      "https://static-web.bigolive.tv/as/bigo-static/reseller/banner.png";

  static User user = User.empty();
  static late Storage _localStorage;

  static bool login = true;

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _localStorage = window.localStorage;
    // var profile = _localStorage['user'];
    APIS.apiKey = _localStorage['api_key'] ?? "";
    print("init apiKey =  ${APIS.apiKey}");

    // Isar.open(schemas, directory: directory)
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // Isar.initializeIsarCore();
    // final dir = await getApplicationDocumentsDirectory();
    // final isar = await Isar.open(
    //   [UserSchema],
    //   directory: dir.path,
    // );
    // var profile = _prefs.getString("profile");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var test = prefs.getInt('counter') ?? 0;
    // print("profile >> $test");
    // print("init profile =  $profile");

    // if (profile != null) {
    //   try {
    //     user = User.fromJson(jsonDecode(profile));
    //   } catch (e) {
    //     print(e);
    //   }
    // } else {
    //   // 默认主题索引为0，代表蓝色
    //   user = User.empty();
    // }
    //初始化网络请求相关配置
  }

  static saveAPIKey(String apiKey) async {
    print("saveAPIKey >> $apiKey");
    _localStorage["api_key"] = apiKey;
  }

  static String platform = "";
  static Map<String, String> urlParams = {};
  static void setFrom(String? userPlatform, Map<String, String> params) {
    platform = userPlatform ?? "";
    urlParams = params;
  }

  // static saveUser() async {
  //   var userJson = jsonEncode(user.toJson());
  //   print("saveUser >> $userJson");
  //   _localStorage["user"] = userJson;
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // var test = prefs.getInt('counter') ?? 0;
  //   // prefs.setInt("counter", test + 1);
  //   // prefs.commit();
  // }

  // static printUser() async {
  //   var test = _localStorage["user"];
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // var test = prefs.getInt('counter') ?? 0;
  //   print("printUser >> $test");
  // }
  // static saveUser() => _prefs.setString("profile", jsonEncode(user.toJson()));
}
