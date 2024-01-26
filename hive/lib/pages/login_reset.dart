import 'package:flutter/material.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageLoginReset extends StatefulWidget {
  @override
  State<PageLoginReset> createState() => _PageLoginResetState();
}

class _PageLoginResetState extends State<PageLoginReset> {
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _pwd2Controller = TextEditingController();
  bool pwdShow = false;
  bool obscurePwd1 = true;
  bool obscurePwd2 = true;
  // GlobalKey _formKey = GlobalKey<FormState>();
  // bool _nameAutoFocus = true;
  // bool _checkboxSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: getAppBar(context,"Reset Password"),
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
                obscureText: obscurePwd1,
                controller: _pwdController,
                decoration: InputDecoration(
                  hintText: al.login_hint_enter_pwd,
                  focusedBorder: forcedInputBorder,
                  enabledBorder: enableInputBorder,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off_outlined,
                        color: Colors.black87),
                    onPressed: () => setState(() => obscurePwd1 = !obscurePwd1),
                  ),
                ),
              ),
            ),
            // repeat password
            H16,
            TextField(
              obscureText: obscurePwd2,
              controller: _pwd2Controller,
              decoration: InputDecoration(
                hintText: al.login_hint_repeat_pwd,
                focusedBorder: forcedInputBorder,
                enabledBorder: enableInputBorder,
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_off_outlined,
                      color: Colors.black87),
                  onPressed: () => setState(() => obscurePwd2 = !obscurePwd2),
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
                      .resetPwd(context, _pwdController.text);
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
