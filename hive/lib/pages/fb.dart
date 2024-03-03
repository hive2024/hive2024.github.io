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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H16,
          H16,
          Text("1.3").addHP(16),
          Text("1120211638995535").addHP(16),
          Text("sdk isWebSdkInitialized = ${FacebookAuth.instance.isWebSdkInitialized}")
              .addHP(16),
          H16,
          Row(
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
          ).addHP(16),
          H16,
          MyButton(
            text: "test",
            onPressed: () {
              loginFB();
            },
          ).addLRBPadding(16),
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
