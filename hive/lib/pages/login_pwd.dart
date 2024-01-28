import 'package:flutter/material.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageLoginPwd extends StatefulWidget {
  @override
  State<PageLoginPwd> createState() => _PageLoginPwdState();
}

class _PageLoginPwdState extends State<PageLoginPwd> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false;
  // GlobalKey _formKey = GlobalKey<FormState>();
  // bool _nameAutoFocus = true;
  // bool _checkboxSelected = false;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    // _phoneController.text = Global.user.lastLogin ?? "";
    // if (_phoneController.text.isNotEmpty) {
    //   _nameAutoFocus = false;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _phoneController.text = context.read<MyAppViewModel>().currentPhone;
    AppLocalizations al = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyTextTitle(text: al.login),
            H16,
            MyTextTip(text: al.tip_login),
            H16,
            //phone number
            TextField(
              enabled: false,
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: al.hint_phone_number,
                focusedBorder: forcedInputBorder,
                enabledBorder: enableInputBorder,
                disabledBorder: disableInputBorder,
              ),
            ),
            //password
            H16,
            TextField(
              obscureText: true,
              controller: _pwdController,
              decoration: InputDecoration(
                hintText: al.enter_pwd,
                focusedBorder: forcedInputBorder,
                enabledBorder: enableInputBorder,
                suffixIcon:
                    Icon(Icons.visibility_off_outlined, color: Colors.black87),
              ),
            ),
            H16,
            // Forgot your password?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 16),
                  child: GestureDetector(
                    onTap: () {
                      context
                    .read<MyAppViewModel>().clickForgot(context);
                    },
                    child: Text(
                      al.forgot_pwd,
                      style: TextStyles.header2,
                    ),
                  ),
                )
              ],
            ),
            H16,
            // button
            MyButton(
              text: al.login,
              onPressed: () {
                context
                    .read<MyAppViewModel>()
                    .login(_phoneController.text, _pwdController.text, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
