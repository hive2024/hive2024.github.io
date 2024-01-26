import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myhive/json/user.dart';
import 'package:myhive/test/test_api.dart';

class Global {
  // static late SharedPreferences _prefs;
  static String appName = "App";
  static String baseServer = "http://207.246.97.25:9018/";

  static String defaultBanner =
      "https://static-web.bigolive.tv/as/bigo-static/reseller/banner.png";

  static String contectWhatsapp = "+6591291573";
  static String contectMessenger = "+6591291573";
  static String contectTelegram= "+6591291573";

  static String txtRules = "Rules";
  static String txtExchange = "Exchange";
  static String txtSuccess = "Success";
  static String txtCopy = "Copy";
  static String txtEdit = "Edit";
  static String txtSave = "Save";

  static String txtShareTitle = "Invitation and reward rules";
  static String txtShareDesc = '''
1. Share links to social platforms and invite friends to register
2、被邀请者完成任务，则分享任务奖励的5%给邀请者。
3、XXXXXXXX
''';
  static String txtShareLink = "Your invitation link is: \r";
  static String txtShareCopyLink = "Copy Link";
  static String txtShareShareTo = "Share to";

  static String txtMeRecharge = "Recharge application";
  static String txtMeWithdraw = "Withdraw application (with wallet)";
  static String txtMeCustomerService = "Dedicated customer service";
  static String txtMeExtension = "Extension center";
  static String txtMeChangePassword = "Change password";
  static String txtMeLogOut = "Log out";

  //topup
  static String txtRecharge = "Recharge";
  static String txtOtherAmount = "Other amount";
  static String txtRechargeAddress = "Recharge address";
  static String txtWalletAddress = "Wallet address";
  static String txtConfirmRecharge = "Confirm recharge";
  static String txtTopupInfo1 =
      "Recharge instructions: You need to recharge USDT, please make sure to transfer the money The package address is the same as the wallet address bound to the user account. Recharge will arrive at the latest 24 hours, please wait patiently, if not, please contact customer service";
  static String txtTopupInfo2 =
      "Please use the wallet address attached to the account to recharge. If the wallet address is incorrect, change the wallet address";

  //withdraw
  static String txtWithdraw = "Withdraw";
  static String txtWithdrawApplication = "Withdraw application";
  static String txtWithdrawInfo =
      "Withdrawal instructions: Please confirm that the withdrawal address is correct. If the loss caused by the wrong address is borne by yourself";
  static String txtFullBlance = "Full blance";
  static String txtOther = "Other";

  //Extension
  static String txtExtensionCenter = "Extension center";
  static String txtPromotionDetails = "Promotion details";

  //task
  static String txtTaskRule =
      "Recharge instructions: You need to recharge USDT, please make sure to transfer the money The package address is the same as the wallet address bound to the user account. Recharge will arrive at the latest 24 hours, please wait patiently, if not, please contact customer service";


  static User user = User.empty();
  static late Storage _localStorage;

  static bool login = true;

  static MaterialColor mainColor = MaterialColor(0XFF4CB2B6, {
    50: Color(0XFF4CB2B6),
    100: Color(0XFF4CB2B6),
    200: Color(0XFF4CB2B6),
    300: Color(0XFF4CB2B6),
    400: Color(0XFF4CB2B6),
    500: Color(0XFF4CB2B6),
    600: Color(0XFF4CB2B6),
    700: Color(0XFF4CB2B6),
    800: Color(0XFF4CB2B6),
    900: Color(0XFF4CB2B6),
  });

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
