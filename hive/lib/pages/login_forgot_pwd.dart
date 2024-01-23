import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/main.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:myhive/pages/login_retrieve_pwd.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageLoginForgotPwd extends StatefulWidget {
  @override
  State<PageLoginForgotPwd> createState() => _PageLoginForgotPwdState();
}

class _PageLoginForgotPwdState extends State<PageLoginForgotPwd> {
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _pwd2Controller = TextEditingController();
  bool pwdShow = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: getAppBar(context, "Reset Password"),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyTextTitle(text: al.login_reset_tip3),
            H16,
            MyTextTip(text: al.login_reset_tip4),
            H16,
            //password
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextField(
                obscureText: pwdShow,
                controller: _pwdController,
                decoration: InputDecoration(
                  hintText: al.login_hint_enter_pwd,
                  focusedBorder: forcedInputBorder,
                  enabledBorder: enableInputBorder,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off_outlined,
                        color: Colors.black87),
                    onPressed: () => setState(() => pwdShow = !pwdShow),
                  ),
                ),
              ),
            ),
            // repeat password
            H16,
            TextField(
              obscureText: pwdShow,
              controller: _pwd2Controller,
              decoration: InputDecoration(
                hintText: al.login_hint_repeat_pwd,
                focusedBorder: forcedInputBorder,
                enabledBorder: enableInputBorder,
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_off_outlined,
                      color: Colors.black87),
                  onPressed: () => setState(() => pwdShow = !pwdShow),
                ),
              ),
            ),
            // button
            H16,
            MyButton(
              text: al.login_save_pwd,
              onPressed: () {
                if (_pwdController.text == _pwd2Controller.text) {
                  context
                      .read<MyAppViewModel>()
                      .saveForgotPwd(context, _pwdController.text);
                } else {
                  toast(context, "Password different.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
