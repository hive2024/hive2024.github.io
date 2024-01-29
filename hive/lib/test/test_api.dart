import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/views.dart';

class Result {
  bool success = true;
  Map<String, dynamic> data = {};
  List<dynamic> dataList = [];
  bool dataBool = false;
  String error = "";
}

class PageTestApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var testPhone = '18612341234';
    var otp = '1234';
    // final userPlatform = window.navigator.platform;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        title: Text("test"),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          child: ListView(
            children: [
              H16,
              OutlinedButton(
                  onPressed: () => APIS.homeInfo(),
                  child: Text(" 1.1 获取首页信息  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.userCheck(testPhone, 1),
                  child: Text(" 1.2 用户检查  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.userCheck(testPhone, 0),
                  child: Text(" 1.2 忘记密码 OTP")),
              H16,
              OutlinedButton(
                  // onPressed: () => APIS.api3(, testPhone),
                  onPressed: () => APIS.otpCheck(otp),
                  child: Text("  1.3 验证码验证检查  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.userLogin(testPhone, '123456'),
                  child: Text("  1.4. 用户登录  ")),
              H16,
              OutlinedButton(
                  onPressed: () =>
                      APIS.userPasswordForget(testPhone, otp, '112233'),
                  child: Text("  1.5 用户密码忘记  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.userPasswordReset('112233'),
                  child: Text("  1.6 用户密码重置  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.userCreat(testPhone, '123456'),
                  child: Text("  1.7 创建用户  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.logout(),
                  child: Text("  1.8 logout  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.actList(),
                  child: Text("  1.9 查询活动列表  ")),
              H16,
              // OutlinedButton(
              //     onPressed: () => APIS.api9(1), child: Text("  1.9 查询活动信息  ")),
              // H16,
              OutlinedButton(
                  onPressed: () => APIS.taskJoin(1),
                  child: Text("  1.12 参加活动  ")),
              H16,
              OutlinedButton(
                  onPressed: () =>
                      APIS.balanceCharge('100', "wallet_from", "wallet_to"),
                  child: Text("  1.13 充值  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.walletBind('wallet-119'),
                  child: Text("  1.14 绑定钱包  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.withdraw('100', 'wallet'),
                  child: Text("  1.15 余额提现  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.advInfo(),
                  child: Text("  1.16 获取推广页信息  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.userInfo(),
                  child: Text("  1.17 我的信息接口  ")),
              H16,
              OutlinedButton(
                  onPressed: () => APIS.userRevenue(),
                  child: Text("  1.18 我的推广收益接口  ")),
              H16,
              OutlinedButton(
                  //0、今日一级收益；1、今日二级收益；2、今日自身（三级）收益
                  onPressed: () => APIS.revenueInfos(
                      0, 10, 0, '2024-01-18 00:00:00', '2024-01-19 00:00:00'),
                  child: Text("  1.19 分页查询 推广数据  ")),
            ],
          ),
        ),
      ),
    );
  }
}

class APIS {
  static String apiKey = "";
  static String language = 'en';
  static final dio = Dio(
    BaseOptions(
      baseUrl: Global.baseServer,
      // connectTimeout: Duration(seconds: 5),
      // receiveTimeout: Duration(seconds: 10),
      // 5s
      headers: {
        // HttpHeaders.userAgentHeader: 'dio',
        // 'api': '1.0.0',
      },
      contentType: Headers.formUrlEncodedContentType,
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
      responseType: ResponseType.plain,
    ),
  );

  ///1.1
  static Future<Result> homeInfo() async {
    var tag = "homeInfo";
    print("$tag  <<<<<");
    Response response = await dio.get(
      "v1/app/home/info",
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.2
  static Future<Result> userCheck(String phone, int type) async {
    var tag = "userCheck";
    print("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/user/check",
      queryParameters: {"phone": phone, "type": type},
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.3. 验证码验证检查
  static Future<Result> otpCheck(String phone) async {
    var tag = "checkOtp";
    print("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/otp/check",
      queryParameters: {"phone": phone},
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.3. 积分兑换
  static Future<Result> exchange() async {
    var tag = "exchange";
    print("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/exchange",
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.4. 用户登录
  static Future<Result> userLogin(String username, String pwd) async {
    var tag = "userLogin";
    print("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/user/login",
      data: {"pwd": pwd, "username": username},
      options: language.optionPost(),
    );
    print("$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    print("$tag Response >> ${response.data}");
    var result = handleResponse(response);
    if (result.success) {
      APIS.apiKey = result.data['apiKey'];
      Global.saveAPIKey(apiKey);
    }
    return result;
  }

  ///1.5 用户密码忘记
  static Future<Result> userPasswordForget(
      String phone, String otp, String newPwd) async {
    var tag = "userPasswordForget";
    print("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/user/password/forget",
      data: {"phone": phone, "otp": otp, "newPwd": newPwd},
      options: language.optionPost(),
    );
    print("$tag Uri >> ${response.realUri}  ; ${response.requestOptions.data}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.6 用户密码重置
  static Future<Result> userPasswordReset(String newPwd) async {
    var tag = "userPasswordReset";
    print("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/user/password/reset",
      data: {"newPwd": newPwd},
      options: language.optionPost(),
    );
    print("$tag Uri >> ${response.realUri}  ; ${response.requestOptions.data}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.7. 创建用户
  static Future<Result> userCreat(String phone, String password) async {
    var tag = "userCreat";
    print("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/user/creat",
      data: {"phone": phone, "password": password},
      options: language.optionPost(),
    );
    print("$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.7 logout
  static Future<void> logout() async {
    var tag = "logout";
    print("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/logout",
      // queryParameters: {"phone": phone},
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
  }

  ///1.8 查询活动列表
  static Future<Result> actList() async {
    var tag = "actList";
    print("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/act/list",
      // queryParameters: {"phone": phone},
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.11. 查询用户任务
  static Future<Result> actInfo(String id) async {
    var tag = "actInfo";
    print("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/act/info",
      queryParameters: {"id": id},
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  static Future<Result> tasksInfo() async {
    var tag = "tasksInfo";
    print("$tag <<<<<");
    try {
      Response response = await dio.get(
        "v1/app/tasks/info",
        options: language.option(),
      );
      print("$tag Uri >> ${response.realUri}");
      print("$tag Response >> ${response.data}");
      return handleResponse(response);
    } catch (e) {
      return Result()..success = false;
    }
  }

  ///1.12. 参加活动
  static Future<Result> taskJoin(int taskId) async {
    var tag = "task/join";
    print("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/task/join",
      queryParameters: {"taskId": taskId},
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.13. 充值
  static Future<Result> balanceCharge(
      String amount, String fromWallet, String targetWallet) async {
    var tag = "balanceCharge";
    print("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/balance/charge",
      data: {
        "amount": amount,
        "fromWallet": fromWallet,
        "targetWallet": targetWallet
      },
      options: language.optionPost(),
    );
    print("$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.14. 绑定钱包
  static Future<Result> walletBind(String walletAddr) async {
    var tag = "walletBind";
    print("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/user/wallet/bind",
      data: {"walletAddr": walletAddr},
      options: language.optionPost(),
    );
    print("$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.15. 余额提现
  static Future<Result> withdraw(String amount, String targetWallet) async {
    var tag = "withdraw";
    print("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/balance/settl",
      data: {"amount": amount, "targetWallet": targetWallet},
      options: language.optionPost(),
    );
    print("$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.16. 获取推广页信息
  static Future<Result> advInfo() async {
    var tag = "advInfo";
    print("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/adv/info",
      // queryParameters: {"phone": phone},
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.17. 我的信息接口
  static Future<Result> userInfo() async {
    var tag = "userInfo";
    print("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/user/info",
      // queryParameters: {"phone": phone},
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.18. 我的推广收益接口
  static Future<void> userRevenue() async {
    var tag = "userRevenue";
    print("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/user/revenue",
      // queryParameters: {"phone": phone},
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
  }

  ///1.19. 分页查询 推广数据. 0、今日一级收益；1、今日二级收益；2、今日自身（三级）收益
  static Future<void> revenueInfos(int page, int pageSize, int type,
      String startTime, String endTime) async {
    var tag = "revenueInfos";
    print("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/user/revenue/infos",
      queryParameters: {
        "page": page,
        "pageSize": pageSize,
        "type": type,
        "startTime": startTime,
        "endTime": endTime,
      },
      options: language.option(),
    );
    print("$tag Uri >> ${response.realUri}");
    print("$tag Response >> ${response.data}");
  }

  static Result handleResponse(Response response) {
    Result result = Result();
    try {
      var respMap = jsonDecode(response.data);
      var respCode = respMap['code'] as int;
      result.success = (respCode == 100);
      if (result.success) {
        if (respMap['data'] is Map<String, dynamic>) {
          result.data = respMap['data'] as Map<String, dynamic>;
        }
        if (respMap['data'] is List<dynamic>) {
          result.dataList = respMap['data'] as List<dynamic>;
        }
        if (respMap['data'] is bool) {
          result.dataBool = respMap['data'] as bool;
        }
      }
      result.error = respMap['message'];
    } catch (e) {
      result.success = false;
      result.error = e.toString();
      print(e);
    }
    return result;
  }
}

extension addLanguage on String {
  Options option() {
    return Options(
      headers: {
        HttpHeaders.acceptLanguageHeader: this,
        "API_KEY": APIS.apiKey,
      },
    );
  }

  Options optionPost() {
    return Options(
      headers: {
        HttpHeaders.acceptLanguageHeader: this,
        "API_KEY": APIS.apiKey,
      },
      contentType: Headers.jsonContentType,
    );
  }
}
