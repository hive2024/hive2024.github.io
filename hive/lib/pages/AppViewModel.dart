import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/tools.dart';
import 'package:myhive/json/user.dart';
import 'package:myhive/pages/login.dart';
import 'package:myhive/pages/login_forgot_pwd.dart';
import 'package:myhive/pages/login_register.dart';
import 'package:myhive/pages/login_retrieve_pwd.dart';
import 'package:myhive/pages/withdraw.dart';
import 'package:myhive/test/test_api.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'login_pwd.dart';

class MyAppViewModel extends ChangeNotifier {
  /// loading

  var loading = true;

  void checkErrorPage(BuildContext context, Result result) {
    if (!result.success) {
      if (result.errorPage.isNotEmpty) {
        Navigator.pushNamed(context, result.errorPage);
      }
    }
  }

  void startLoading(BuildContext context) {
    printLog("startLoading");
    if (loading) {
      APIS.homeInfo(Global.shareCode).then((result) {
        if (result.success) {
          var videos = result.data['videos'];
          if (videos != null) {
            bannerVideo = videos['url'];
          }
          var contents = result.data['contents'];
          homeHtml = contents['text'];
          appUrl = result.data['appUrl'];
          selectedPage = 1;
          notifyListeners();
        } else {
          checkErrorPage(context, result);
          if (!result.errorPage.isNotEmpty) {
            showEmpty();
          }
        }
      });
      if (APIS.apiKey.isNotEmpty) {
        queryActivityList(context, false);
        queryUserInfo(context);
        queryTask(context);
      }
    }
    loading = false;
  }

  void showEmpty() {
    selectedPage = 6;
    notifyListeners();
  }

  /// home
  int selectedPage = 0;
  String bannerVideo = '';
  String appUrl = '';
  String homeHtml = '';

  void selecte(BuildContext context, int index) {
    if (APIS.apiKey.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return PageLogin();
        }),
      );
      return;
    }
    selectedPage = index;
    notifyListeners();
    if (index == 2) {
      queryActivityList(context, true);
    }
    if (index == 3) {
      queryUserInfo(context);
    }
    if (index == 4) {
      queryUserInfo(context);
    }
    if (index == 5) {
      queryTask(context);
    }
  }

  ///Activity

  List<Activity> activityList = [];

  void queryActivityList(BuildContext context, bool needCheck) {
    APIS.actList().then((result) {
      var al = result.dataList.map((e) => Activity.fromJson(e)).toList();
      activityList = al;
      if (needCheck) {
        checkErrorPage(context, result);
      }
      notifyListeners();
    });
  }

  /// task
  int userLevel = 1;
  String userIntegral = "0.0";
  String ruleLink = "";
  List<Task> taskList = [];

  void queryTask(BuildContext context) {
    printLog("queryTask");
    APIS.tasksInfo().then((result) {
      if (result.success) {
        userLevel = result.data['userLevel'] ?? 0;
        userIntegral = result.data['integral'] ?? 0;
        // ruleLink = (result.data['rulesPageUrl'] ?? "");
        // int actIndex = ruleLink.indexOf("/act/");
        // ruleLink = ruleLink.substring(actIndex).replaceAll("/act/", "/rule/");
        ruleLink = getInnerUrl(result.data['rulesPageUrl'] ?? "", 1);
        taskList = (result.data['tasks'] as List)
            .map((e) => Task.fromJson(e))
            .toList();
        taskList.sort((a, b) => a.level - b.level);
        for (var task in taskList) {
          if (task.level < 2 && task.status == 2) {
            task.status = 0;
          }
        }
        notifyListeners();
      } else {
        checkErrorPage(context, result);
      }
    });
  }

  void clickTask(BuildContext context, int taskId) {
    APIS.taskJoin(taskId).then((value) {
      Navigator.of(context).pop();
      taskList.lastWhere((element) => element.id == taskId).status = 1;
      notifyListeners();
    });
  }

  void exchange(BuildContext context) {
    APIS.exchange().then((result) {
      if (result.success) {
        toast(context, AppLocalizations.of(context)!.success_exchange, true);
      } else {
        toast(context, result.error, false);
      }
    });
  }

  /// share
  String shareLink = "";
  String shareCopyContent = "";

  void queryShareInfo() {
    printLog("queryShareInfo");
    APIS.advInfo().then((result) {
      if (result.success) {
        String oriUrl = result.data['url'] ?? "";
        shareLink = oriUrl +
            (oriUrl.contains("?")
                ? "&sc=${userInfo.uid}"
                : "?sc=${userInfo.uid}");
        shareCopyContent = result.data['contents'];
        printLog(shareCopyContent);
        notifyListeners();
      }
    });
  }

  ///login

  TextEditingController loginPhoneTEC = TextEditingController();
  TextEditingController loginOtpTEC = TextEditingController();

  var needVerifyLogin = false;
  String otp = "";
  String otpReceiver = "";
  String currentPhone = "";
  bool checkboxSelected = false;

  void clickCheckBox() {
    checkboxSelected = !checkboxSelected;
    notifyListeners();
  }

  void tryLogin(BuildContext context) {
    String phone = loginPhoneTEC.text;
    printLog("tryLogin $phone");
    currentPhone = phone;
    APIS.userCheck(phone, 0).then((result) {
      if (result.success) {
        bool exist = result.data['exist'] as bool;
        printLog("tryLogin $phone = $exist");
        if (exist) {
          //use exist
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return PageLoginPwd();
          }));
        } else {
          //user not found
          needVerifyLogin = true;
          otpReceiver = result.data['receiver'] as String;
          otp = result.data['result'] as String;
          notifyListeners();
          // whatsapp(otpReceiver, otp);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) {
          //   return PageLoginOtp();
          // }));
          // toast(context, "send whatsapp for register");
        }
      } else {
        toast(context, result.error, false);
      }
    });
  }

  var period = const Duration(seconds: 1);
  var otpTimer = 0;
  var maxTimer = 10;

  void sendLoginOTP(BuildContext context) {
    String phone = loginPhoneTEC.text;
    doSendOTP(phone, context);
  }

  void doSendOTP(String phone, BuildContext context) {
    if (otpTimer > 0) {
      return;
    }
    APIS.sendOTP(phone).then((result) {
      if (result.success) {
        otpTimer = maxTimer;
        Timer.periodic(period, (t) {
          print('timer= $otpTimer');
          otpTimer--;
          notifyListeners();
          if (otpTimer <= 0) {
            t.cancel();
          }
        });
      } else {
        toast(context, result.error, false);
      }
    });
  }

  void verify(BuildContext context) {
    String phone = loginPhoneTEC.text;
    printLog("verify $phone");
    APIS.otpCheck(phone).then((result) {
      if (result.success) {
        if (result.dataBool) {
          needVerifyLogin = false;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return PageLoginReg();
          }));
        } else {
          toast(context, AppLocalizations.of(context)!.otp_incorrect, true);
        }
      } else {
        toast(context, result.error, false);
      }
    });
  }

  void login(String phone, String pwd, BuildContext context) {
    APIS.userLogin(phone, pwd).then((result) {
      if (result.success) {
        Navigator.of(context).pop();
      } else {
        toast(context, result.error, false);
      }
    });
  }

  void register(BuildContext context, String pwd) {
    printLog("register pwd=$pwd ");
    APIS.userCreat(currentPhone, pwd, Global.shareCode).then((result) {
      if (result.success) {
        // Navigator.of(context).pop();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return PageLoginPwd();
        }));
      } else {
        toast(context, result.error, false);
      }
    });
  }

  ///forgot

  TextEditingController forgotPhoneTEC = TextEditingController();
  TextEditingController forgotOtpTEC = TextEditingController();
  var forgotOtpSent = false;
  // var forgotOtpVerify = false;
  String forgotOtp = "";
  String forgotPhone = "";

  void clickForgot(BuildContext context) {
    forgotOtpSent = false;
    // forgotOtpVerify = false;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PageRetrievePwd();
      }),
    );
  }

  void sendForgotOtp(BuildContext context) {
    String phone = forgotPhoneTEC.text;
    printLog("retrieveForgotOtp $phone");
    forgotPhone = phone;
    if (otpTimer > 0) {
      return;
    }
    APIS.sendOTP(phone).then((result) {
      if (result.success) {
        forgotOtpSent = true;
        otpTimer = maxTimer;
        Timer.periodic(period, (t) {
          print('timer= $otpTimer');
          otpTimer--;
          notifyListeners();
          if (otpTimer <= 0) {
            t.cancel();
          }
        });
      } else {
        toast(context, result.error, false);
      }
    });
  }

  void verifyForgotOtp(BuildContext context) {
    String phone = forgotPhoneTEC.text;
    printLog("verify $phone");
    APIS.otpCheck(phone).then((result) {
      if (result.success) {
        if (result.dataBool) {
          // forgotOtpVerify = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              return PageLoginForgotPwd();
            }),
          );
        } else {
          toast(context, AppLocalizations.of(context)!.otp_incorrect, true);
        }
      } else {
        toast(context, result.error, false);
      }
    });
  }

  void saveForgotPwd(BuildContext context, String pwd) {
    APIS.userPasswordForget(forgotPhone, forgotOtp, pwd).then((result) {
      if (result.success) {
        Navigator.of(context).pop();
      } else {
        toast(context, result.error, false);
      }
    });
  }

  ///Mine
  UserInfo userInfo = UserInfo.empty();

  void queryUserInfo(BuildContext context) {
    APIS.userInfo().then((result) {
      if (result.success) {
        userInfo = UserInfo.fromJson(result.data);
        userLevel = userInfo.level;
        notifyListeners();
        queryShareInfo();
      } else {
        checkErrorPage(context, result);
      }
    });
  }

  void resetPwd(BuildContext context, String pwd) {
    APIS.userPasswordReset(pwd).then((result) {
      if (result.success) {
        Navigator.of(context).pop();
      } else {
        toast(context, result.error, false);
      }
    });
  }

  void settingOpenWithdraw(BuildContext context) {
    saveMode = false;
    fromTopup = false;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PageWithdraw();
      }),
    );
  }

  void logout(BuildContext context) {
    APIS.apiKey = "";
    Global.saveAPIKey("");
    selectedPage = 1;
    notifyListeners();
  }

  //'https://wa.me/${receiver}/?text=hello'
// 'http://m.me/${receiver}'
// 'https://telegram.me/${receiver}'
  Future<void> contectWhatsapp() async {
    // if (!await launchUrl(
    //     Uri.parse('https://wa.me/${Global.appName}/?text=hello'))) {
    //   throw Exception('Could not launch');
    // }
    try {
      launchUrl(Uri.parse(userInfo.whatsappUrl ?? ""));
    } catch (e) {
      printLog(e);
    }
  }

  void contectMessenger() {
    try {
      launchUrl(Uri.parse(userInfo.messagerUrl ?? ""));
    } catch (e) {
      printLog(e);
    }
  }

  void contectTelegram() {
    try {
      launchUrl(Uri.parse(userInfo.telegramUrl ?? ""));
    } catch (e) {
      printLog(e);
    }
  }

  //topup
  void topupEditWallet(BuildContext context) {
    saveMode = true;
    fromTopup = true;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PageWithdraw();
      }),
    );
  }

  void topup(BuildContext context, String amount, String fromWallet) {
    APIS
        .balanceCharge(amount, fromWallet, userInfo.chargeWalletAddress ?? "")
        .then((value) {
      if (value.success) {
        Navigator.of(context).pop();
      }
    });
  }

  ///withdraw
  bool saveMode = false;
  String walletAddress = "todo";
  double fullBlance = 0;
  bool fromTopup = false;

  void withDrawSaveMode(bool bool) {
    saveMode = true;
    notifyListeners();
  }

  void withDrawCopy(BuildContext context) {
    printLog("withDrawCopy");
    Clipboard.setData(ClipboardData(text: walletAddress)).then((value) {});
  }

  void withDraw(BuildContext context, String amount) {
    printLog("withDraw");
    APIS.withdraw(amount, userInfo.settleWalletAddress ?? "").then((result) {
      if (result.success) {
        queryUserInfo(context);
        Navigator.of(context).pop();
        toast(context, "Success", true);
      } else {
        toast(context, result.error, false);
      }
    });
  }

  void saveWallet(BuildContext context, String newWallet) {
    printLog("saveWallet");
    APIS.walletBind(newWallet).then((result) {
      if (result.success) {
        saveMode = false;
        userInfo.settleWalletAddress = newWallet;
        notifyListeners();
        if (fromTopup) {
          Navigator.of(context).pop();
        }
      } else {
        toast(context, result.error, false);
      }
    });
  }

  /// Extension
  UserRevenue userRevenue = UserRevenue.empty();

  void copyShareLink(BuildContext context) {
    printLog("copyShareLink");
    Clipboard.setData(ClipboardData(text: shareLink)).then((value) {});
  }

  void loadUserRevenue() {
    APIS.userRevenue().then((result) {
      if (result.success) {
        userRevenue = UserRevenue.fromJson(result.data);
        notifyListeners();
      }
    });
  }

  static DateFormat formater = DateFormat("y-M-d");

  TextEditingController detailTeam = TextEditingController();
  TextEditingController detailDateStart = TextEditingController()
    ..text = formater.format(DateTime.now());
  DateTime? start = DateTime.now();
  DateTime? end;
  int page = 1;
  String type = "0";

  void updateDate(PickerDateRange p0) {
    start = p0.startDate;
    end = p0.endDate;
    if (start != null && end != null) {
      detailDateStart.text =
          "${formater.format(start!)} - ${formater.format(end!)}";
    } else if (start != null) {
      detailDateStart.text = formater.format(start!);
    } else if (end != null) {
      detailDateStart.text = formater.format(end!);
    } else {
      start = DateTime.now();
      detailDateStart.text = formater.format(start!);
    }
    notifyListeners();
  }

  var detailList = [];
  // List<Promotion>.generate(10, (i) => Promotion("uid-$i", i, "$i", "$i"));
  var detailHasLoadmore = true;

  void detailLoadmore() {
    // var s = detailList.length;
    // var news =
    //     List<Promotion>.generate(10, (i) => Promotion("uid-$i", i, "$i", "$i"));
    // detailList.addAll(news);
    // notifyListeners();
    if (!detailHasLoadmore) {
      return;
    }
    search(page + 1);
  }

  search(int p) {
    page = p;
    String startDay = formater.format(DateTime.now());
    String endDay = startDay;

    if (start != null && end != null) {
      startDay = formater.format(start!);
      endDay = formater.format(end!);
    } else if (start != null) {
      startDay = formater.format(start!);
      endDay = startDay;
    } else if (end != null) {
      endDay = formater.format(end!);
      startDay = endDay;
    }
    String startTime = "$startDay 00:00:00";
    String endTime = "$endDay 23:59:59";
    APIS
        .revenueInfos(page, 10, int.parse(type), startTime, endTime)
        .then((result) {
      if (result.success) {
        var rs = result.dataList.map((e) => Promotion.fromJson(e)).toList();
        if (page == 1) {
          detailList = rs;
        } else {
          detailList.addAll(rs);
        }
        detailHasLoadmore = rs.length >= 10;
        notifyListeners();
      }
    });
  }

  onSelectTeam(String? value) {
    type = value ?? "0";
  }

  //activity detail
  Activity activityDetail = Activity.empty();
  String currentActId = "";

  void getActDetail(String actId) {
    if (actId == currentActId) {
      printLog("same event $actId");
      return;
    }
    currentActId = actId;
    printLog("getActDetail $actId");
    APIS.actInfo(actId).then((result) {
      activityDetail = Activity.fromJson(result.data);
      notifyListeners();
    }, onError: (e) {
      activityDetail.desc = "<H1>Not Found Event: $actId <H1>";
      notifyListeners();
    });
  }

  //download
  int loadTime = 0;
  void loadDownload() {
    printLog("loadDownload = $loadTime");
    if (loadTime > 0) {
      return;
    }
    loadTime++;
    APIS.homeInfo(Global.shareCode).then((result) {
      if (result.success) {
        var videos = result.data['videos'];
        if (videos != null) {
          bannerVideo = videos['url'];
        }
        var contents = result.data['contents'];
        homeHtml = contents['text'];
        appUrl = result.data['appUrl'];
        notifyListeners();
      }
    });
  }

  void clickDownload() {
    try {
      launchUrl(Uri.parse(appUrl));
    } catch (e) {
      printLog(e);
    }
  }

  showDebug(BuildContext context) {}

  var clicked = 0;

  void markClicked() {
    clicked++;
    printLog("markClicked = $clicked");
    if (clicked == 1) {
      notifyListeners();
    }
  }
}

void toast(BuildContext context, String s, bool success) {
  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  toastification.show(
    context: context,
    type: success ? ToastificationType.success : ToastificationType.info,
    style: ToastificationStyle.flat,
    title: s,
    alignment: Alignment.center,
    showProgressBar: false,
    autoCloseDuration: const Duration(seconds: 2),
  );
}
