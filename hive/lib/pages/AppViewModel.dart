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
import 'package:url_launcher/url_launcher.dart';

import 'login_pwd.dart';

class MyAppViewModel extends ChangeNotifier {
  /// loading

  var loading = true;

  void startLoading(BuildContext context) {
    print("startLoading");
    if (loading) {
      APIS.homeInfo().then((result) {
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
          showEmpty();
        }
      });
      if (APIS.apiKey.isNotEmpty) {
        queryActivityList();
        // queryShareInfo();
        queryUserInfo();
        queryTask();
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
      queryActivityList();
    }
    if (index == 3) {
      queryShareInfo();
    }
    if (index == 4) {
      queryUserInfo();
    }
    if (index == 5) {
      queryTask();
    }
  }

  ///Activity

  List<Activity> activityList = [];

  void queryActivityList() {
    APIS.actList().then((result) {
      var al = result.dataList.map((e) => Activity.fromJson(e)).toList();
      activityList = al;
      notifyListeners();
    });
  }

  /// task
  int userLevel = 1;
  int userIntegral = 0;
  List<Task> taskList = [];

  void queryTask() {
    print("queryTask");
    APIS.tasksInfo().then((result) {
      userLevel = result.data['userLevel'];
      userIntegral = result.data['integral'];
      taskList =
          (result.data['tasks'] as List).map((e) => Task.fromJson(e)).toList();
      taskList.sort((a, b) => a.level - b.level);
      for (var task in taskList) {
        if (task.level < 2 && task.status == 2) {
          task.status = 0;
        }
      }
      notifyListeners();
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
        toast(context, "Success submit exchange");
      } else {
        toast(context, result.error);
      }
    });
  }

  /// share
  String shareLink = "https://www.111.com/source?from=1234";
  String shareCopyContent = "CopyContent https://www.111.com/source?from=1234";

  void queryShareInfo() {
    print("queryShareInfo");
    APIS.advInfo().then((result) {
      if (result.success) {
        shareLink = result.data['url'];
        shareCopyContent = result.data['contents'];
        notifyListeners();
      }
    });
  }

  ///login

  var needVerifyLogin = false;
  String otp = "";
  String otpReceiver = "+65 86161190";
  String currentPhone = "";

  void tryLogin(String phone, BuildContext context) {
    print("tryLogin $phone");
    currentPhone = phone;
    APIS.userCheck(phone, 0).then((result) {
      if (result.success) {
        bool exist = result.data['exist'] as bool;
        print("tryLogin $phone = $exist");
        if (exist) {
          //use exist
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return PageLoginPwd();
          }));
        } else {
          //user not found
          needVerifyLogin = true;
          otp = result.data['result'] as String;
          notifyListeners();
          whatsapp(otpReceiver, otp);
          toast(context, "send whatsapp for register");
        }
      } else {
        toast(context, result.error);
      }
    });
  }

  void verify(String phone, BuildContext context) {
    print("verify $phone");
    APIS.otpCheck(phone).then((result) {
      if (result.success) {
        if (result.dataBool) {
          needVerifyLogin = false;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return PageLoginReg();
          }));
        } else {
          toast(context, "otp incorrect");
        }
      } else {
        toast(context, result.error);
      }
    });
  }

  void login(String phone, String pwd, BuildContext context) {
    APIS.userLogin(phone, pwd).then((result) {
      if (result.success) {
        Navigator.of(context).pop();
      } else {
        toast(context, result.error);
      }
    });
  }

  void register(BuildContext context, String pwd) {
    print("register pwd=$pwd ");
    APIS.userCreat(currentPhone, pwd).then((result) {
      if (result.success) {
        Navigator.of(context).pop();
      } else {
        toast(context, result.error);
      }
    });
  }

  ///forgot

  var forgotOtpSent = false;
  var forgotOtpVerify = false;
  String forgotOtp = "";
  String forgotPhone = "";

  void clickForgot(BuildContext context) {
    forgotOtpSent = false;
    forgotOtpVerify = false;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PageRetrievePwd();
      }),
    );
  }

  void retrieveForgotOtp(String phone, BuildContext context) {
    print("retrieveForgotOtp $phone");
    forgotPhone = phone;

    APIS.userCheck(phone, 1).then((result) {
      if (result.success) {
        print("retrieveForgotOtp $forgotOtp");
        forgotOtp = result.data['result'] as String;
        // forgotOtp = "1234";
        forgotOtpSent = true;
        notifyListeners();
        whatsapp(otpReceiver, forgotOtp);
        toast(context, "send whatsapp for register");
      } else {
        toast(context, result.error);
      }
    });
  }

  void verifyForgotOtp(String phone, BuildContext context) {
    print("verify $phone");
    APIS.otpCheck(phone).then((result) {
      if (result.success) {
        if (result.dataBool) {
          forgotOtpVerify = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              return PageLoginForgotPwd();
            }),
          );
        } else {
          toast(context, "otp incorrect");
        }
      } else {
        toast(context, result.error);
      }
    });
  }

  void saveForgotPwd(BuildContext context, String pwd) {
    APIS.userPasswordForget(forgotPhone, forgotOtp, pwd).then((result) {
      if (result.success) {
        Navigator.of(context).pop();
      } else {
        toast(context, result.error);
      }
    });
  }

  ///Mine
  UserInfo userInfo = UserInfo.empty();

  void queryUserInfo() {
    APIS.userInfo().then((result) {
      if (result.success) {
        userInfo = UserInfo.fromJson(result.data);
        userLevel = userInfo.level;
        notifyListeners();
      }
    });
  }

  void resetPwd(BuildContext context, String pwd) {
    APIS.userPasswordReset(pwd).then((result) {
      if (result.success) {
        Navigator.of(context).pop();
      } else {
        toast(context, result.error);
      }
    });
  }

  void settingOpenWithdraw(BuildContext context) {
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

  Future<void> contectWhatsapp() async {
    // if (!await launchUrl(
    //     Uri.parse('https://wa.me/${Global.appName}/?text=hello'))) {
    //   throw Exception('Could not launch');
    // }
    try {
      launchUrl(Uri.parse('https://wa.me/${Global.appName}/?text=hello'));
    } catch (e) {
      print(e);
    }
  }

  void contectMessenger() {
    try {
      launchUrl(Uri.parse('http://m.me/${Global.contectMessenger}'));
    } catch (e) {
      print(e);
    }
  }

  void contectTelegram() {
    try {
      launchUrl(Uri.parse('https://telegram.me/${Global.contectTelegram}'));
    } catch (e) {
      print(e);
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
  double fullBlance = 1088.8;
  bool fromTopup = false;

  void withDrawSaveMode(bool bool) {
    saveMode = true;
    notifyListeners();
  }

  void withDrawCopy(BuildContext context) {
    print("withDrawCopy");
    Clipboard.setData(ClipboardData(text: walletAddress)).then((value) {});
  }

  void withDraw(BuildContext context, String amount) {
    print("withDraw");
    APIS.withdraw(amount, userInfo.settleWalletAddress ?? "").then((result) {
      if (result.success) {
        if (fromTopup) {
          Navigator.of(context).pop();
        }
      } else {
        toast(context, result.error);
      }
    });
  }

  void saveWallet(BuildContext context, String newWallet) {
    print("saveWallet");
    APIS.walletBind(newWallet).then((result) {
      if (result.success) {
        saveMode = false;
        userInfo.settleWalletAddress = newWallet;
        notifyListeners();
        if (fromTopup) {
          Navigator.of(context).pop();
        }
      } else {
        toast(context, result.error);
      }
    });
  }

  /// Extension
  void copyShareLink(BuildContext context) {
    print("copyShareLink");
    Clipboard.setData(ClipboardData(text: shareLink)).then((value) {});
  }

  TextEditingController detailDateStart = TextEditingController();
  TextEditingController detailDateEnd = TextEditingController();

  void updateDate(PickerDateRange p0) {
    DateTime start = p0.startDate ?? DateTime.now();
    DateTime end = p0.endDate ?? DateTime.now();
    detailDateStart.text =
        "${DateFormat.yMd().format(start)} - ${DateFormat.yMd().format(end)}";
    notifyListeners();
  }

  var detailList =
      List<Promotion>.generate(10, (i) => Promotion("uid-$i", i, "$i", "$i"));
  var detailHasLoadmore = true;

  void detailLoadmore() {
    // var s = detailList.length;
    var news =
        List<Promotion>.generate(10, (i) => Promotion("uid-$i", i, "$i", "$i"));
    detailList.addAll(news);
    notifyListeners();
  }
}

void toast(BuildContext context, String s) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
}
