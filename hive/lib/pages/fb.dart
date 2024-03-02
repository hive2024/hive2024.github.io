import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/tools.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/json/user.dart';
import 'package:myhive/main.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:myhive/pages/debug.dart';
import 'package:myhive/pages/home2.dart';
import 'package:myhive/pages/task.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageFacebook extends StatelessWidget {
  // late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    var viewModel = context.watch<MyAppViewModel>();
    double principal = 1225080; // 贷款本金
    double annualInterestRate = 5.0; // 年利率（百分比）
    int loanTermInYears = 29; // 贷款期限（年）

    double monthlyPayment =
        calculateMonthlyPayment(principal, annualInterestRate, loanTermInYears);
    print('每月还款额：\$${monthlyPayment.toStringAsFixed(2)}');

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H16,
          H16,
          Text("1.2").addHP(16),
          Text("942398130788099").addHP(16),
          Text("sdk isWebSdkInitialized = ${FacebookAuth.instance.isWebSdkInitialized}").addHP(16),
          H16,
          debug
              ? Row(
                  children: [
                    FilledButton.icon(
                        onPressed: () => (),
                        icon: Icon(Icons.gpp_good_outlined),
                        label: Text("SKIP:")),
                    FilledButton.icon(
                        onPressed: () => {checkLogin()},
                        icon: Icon(Icons.gpp_good_outlined),
                        label: Text("INFO")),
                  ],
                ).addHP(16)
              : H4,
          H16,
          MyButton(
            text: al.get_start,
            onPressed: () {
              loginFB();
            },
          ).addLRBPadding(16),
          // Text("principal:\$$principal , loanTermInYears:$loanTermInYears :"),
          // Text(
          //     "[4.32%] \$${calculateMonthlyPayment(principal, 4.32, loanTermInYears).toStringAsFixed(2)} "),
          // Text(
          //     "[3.32%] \$${calculateMonthlyPayment(principal, 3.32, loanTermInYears).toStringAsFixed(2)} "),
          // Text(
          //     "[3.00%] \$${calculateMonthlyPayment(principal, 3.0, loanTermInYears).toStringAsFixed(2)} "),
          // Text(
          //     "[2.95%] \$${calculateMonthlyPayment(principal, 2.95, loanTermInYears).toStringAsFixed(2)} "),
          // Text(
          //     "[2.90%] \$${calculateMonthlyPayment(principal, 2.90, loanTermInYears).toStringAsFixed(2)} "),
        ],
      ),
    );
  }

  Future<void> loginFB() async {
    // by default we request the email and the public profile
    LoginResult result = await FacebookAuth.i.login();
    print(result.status);
    print(result.message);
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      print("you are logged $accessToken");
    }
  }
}

Future<void> checkLogin() async {
  final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
  print("checkLogin = $accessToken");
// or FacebookAuth.i.accessToken
  if (accessToken != null) {
    // user is logged
  }
}

double calculateMonthlyPayment(
    double principal, double annualInterestRate, int loanTermInYears) {
  // Convert annual interest rate to monthly interest rate
  double monthlyInterestRate = annualInterestRate / 12 / 100;

  // Convert loan term from years to months
  int loanTermInMonths = loanTermInYears * 12;

  // Calculate monthly payment
  double monthlyPayment = (principal *
          monthlyInterestRate *
          pow(1 + monthlyInterestRate, loanTermInMonths)) /
      (pow(1 + monthlyInterestRate, loanTermInMonths) - 1);

  return monthlyPayment;
}
