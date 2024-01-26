import 'package:flutter/material.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageLoginReg extends StatefulWidget {
  @override
  State<PageLoginReg> createState() => _PageLoginRegState();
}

class _PageLoginRegState extends State<PageLoginReg> {
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _pwd2Controller = TextEditingController();
  bool pwdShow = false;

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
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyTextTitle(text: al.login_pwd_tip1),
            H16,
            MyTextTip(text: al.login_pwd_tip2),
            H16,
            //password
            TextField(
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
            H16,
            // repeat password
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
            H16,
            // button
            MyButton(
              text: al.login_complete,
              onPressed: () {
                if (_pwdController.text == _pwd2Controller.text) {
                  context
                      .read<MyAppViewModel>()
                      .register(context, _pwdController.text);
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
