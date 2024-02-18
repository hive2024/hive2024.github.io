import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/tools.dart';

class Result {
  bool success = true;
  Map<String, dynamic> data = {};
  List<dynamic> dataList = [];
  bool dataBool = false;
  String error = "";
  String errorPage = "";
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
  )..interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          printLog("DioException >> ${e.response?.statusCode} ");
          APIS.apiKey = "";
          Global.saveAPIKey("");
        },
      ),
    );

  ///1.1
  static Future<Result> homeInfo(String? inviter) async {
    var tag = "homeInfo";
    printLog("$tag  <<<<<");
    Response response = await dio.get(
      "v1/app/home/info",
      queryParameters: inviter == null ? {} : {"inviter": inviter},
      options: language.option(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.2
  static Future<Result> userCheck(String phone, int type) async {
    var tag = "userCheck";
    printLog("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/user/check",
      queryParameters: {"phone": phone, "type": type},
      options: language.option(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.3. 验证码验证检查
  static Future<Result> otpCheck(String phone) async {
    var tag = "checkOtp";
    printLog("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/otp/check",
      queryParameters: {"phone": phone},
      options: language.option(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.3. 积分兑换
  static Future<Result> exchange() async {
    var tag = "exchange";
    printLog("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/exchange",
      options: language.option(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.4. 用户登录
  static Future<Result> userLogin(String username, String pwd) async {
    var tag = "userLogin";
    printLog("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/user/login",
      data: {"pwd": pwd, "username": username},
      options: language.optionPost(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
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
    printLog("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/user/password/forget",
      data: {"phone": phone, "otp": otp, "newPwd": newPwd},
      options: language.optionPost(),
    );
    printLog(
        "$tag Uri >> ${response.realUri}  ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.6 用户密码重置
  static Future<Result> userPasswordReset(String newPwd) async {
    var tag = "userPasswordReset";
    printLog("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/user/password/reset",
      data: {"newPwd": newPwd},
      options: language.optionPost(),
    );
    printLog(
        "$tag Uri >> ${response.realUri}  ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.7. 创建用户
  static Future<Result> userCreat(
      String phone, String password, String inviter) async {
    var tag = "userCreat";
    printLog("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/user/creat",
      data: {"phone": phone, "password": password, "inviter": inviter},
      options: language.optionPost(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.7 logout
  static Future<void> logout() async {
    var tag = "logout";
    printLog("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/logout",
      // queryParameters: {"phone": phone},
      options: language.option(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
  }

  ///1.8 查询活动列表
  static Future<Result> actList() async {
    var tag = "actList";
    printLog("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/act/list",
      // queryParameters: {"phone": phone},
      options: language.option(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.11. 查询用户任务
  static Future<Result> actInfo(String id) async {
    var tag = "actInfo";
    printLog("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/act/info",
      queryParameters: {"id": id},
      options: language.option(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  static Future<Result> tasksInfo() async {
    var tag = "tasksInfo";
    printLog("$tag <<<<<");
    try {
      Response response = await dio.get(
        "v1/app/tasks/info",
        options: language.option(),
      );
      printLog(
          "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
      printLog("$tag Response >> ${response.data}");
      return handleResponse(response);
    } catch (e) {
      return Result()..success = false;
    }
  }

  ///1.12. 参加活动
  static Future<Result> taskJoin(int taskId) async {
    var tag = "task/join";
    printLog("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/task/join",
      queryParameters: {"taskId": taskId},
      options: language.option(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.13. 充值
  static Future<Result> balanceCharge(
      String amount, String fromWallet, String targetWallet) async {
    var tag = "balanceCharge";
    printLog("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/balance/charge",
      data: {
        "amount": amount,
        "fromWallet": fromWallet,
        "targetWallet": targetWallet
      },
      options: language.optionPost(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.14. 绑定钱包
  static Future<Result> walletBind(String walletAddr) async {
    var tag = "walletBind";
    printLog("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/user/wallet/bind",
      data: {"walletAddr": walletAddr},
      options: language.optionPost(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.15. 余额提现
  static Future<Result> withdraw(String amount, String targetWallet) async {
    var tag = "withdraw";
    printLog("$tag <<<<<");
    Response response = await dio.post(
      "v1/app/balance/settl",
      data: {"amount": amount, "targetWallet": targetWallet},
      options: language.optionPost(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.16. 获取推广页信息
  static Future<Result> advInfo() async {
    var tag = "advInfo";
    printLog("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/adv/info",
      // queryParameters: {"phone": phone},
      options: language.option(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.17. 我的信息接口
  static Future<Result> userInfo() async {
    var tag = "userInfo";
    printLog("$tag <<<<< ${APIS.apiKey}");
    Response? response;
    try {
      response = await dio.get(
        "v1/app/user/info",
        // queryParameters: {"phone": phone},
        options: language.option(),
      );
    } catch (e) {
      printLog("$tag exception =====");
      printLog("$tag statusCode= ${response?.statusCode}");
      printLog(e);
    }
    printLog(
        "$tag Uri >> ${response?.realUri} ; ${response?.requestOptions.data ?? language.option()}");
    printLog("$tag Response >> ${response?.data}");
    return response != null ? handleResponse(response) : Result();
  }

  ///1.18. 我的推广收益接口
  static Future<Result> userRevenue() async {
    var tag = "userRevenue";
    printLog("$tag <<<<<");
    Response response = await dio.get(
      "v1/app/user/revenue",
      // queryParameters: {"phone": phone},
      options: language.option(),
    );
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
  }

  ///1.19. 分页查询 推广数据. 0、今日一级收益；1、今日二级收益；2、今日自身（三级）收益
  static Future<Result> revenueInfos(int page, int pageSize, int type,
      String startTime, String endTime) async {
    var tag = "revenueInfos";
    printLog("$tag <<<<<");
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
    printLog(
        "$tag Uri >> ${response.realUri} ; ${response.requestOptions.data}");
    printLog("$tag Response >> ${response.data}");
    return handleResponse(response);
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
      } else {
        if (respCode == 123) {
          result.errorPage = getInnerUrl(respMap['message'] ?? "", 0);
        }
      }
      result.error = respMap['message'];
    } catch (e) {
      result.success = false;
      result.error = e.toString();
      printLog(e);
    }
    return result;
  }
}

extension addLanguage on String {
  Options option() {
    return Options(
      headers: {
        HttpHeaders.acceptLanguageHeader: APIS.language,
        "Authorization": APIS.apiKey,
      },
    );
  }

  Options optionPost() {
    return Options(
      headers: {
        HttpHeaders.acceptLanguageHeader: APIS.language,
        "Authorization": APIS.apiKey,
      },
      contentType: Headers.jsonContentType,
    );
  }
}
