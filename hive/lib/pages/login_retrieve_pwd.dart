import 'package:flutter/material.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageRetrievePwd extends StatefulWidget {
  @override
  State<PageRetrievePwd> createState() => _PageRetrievePwdState();
}

class _PageRetrievePwdState extends State<PageRetrievePwd> {
  TextEditingController _phoneController = TextEditingController();
  late Widget verifyWidget;
  late AppLocalizations al;
  // bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    al = AppLocalizations.of(context)!;
    var appState = context.watch<MyAppViewModel>();
    verifyWidget = appState.forgotOtpSent
        ? Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: MyButton(
              text: al.verify,
              onPressed: () {
                context
                    .read<MyAppViewModel>()
                    .verifyForgotOtp(_phoneController.text, context);
              },
            ),
          )
        : H16;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: getAppBar(context, al.forgot_pwd),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyTextTitle(text: al.retrieve_pwd),
            H16,
            MyTextTip(text: al.tip_whatsapp),
            H16,
            //phone number
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: al.hint_phone_number,
                focusedBorder: forcedInputBorder,
                enabledBorder: enableInputBorder,
                disabledBorder: disableInputBorder,
              ),
            ),
            H16,
            // button
            MyButton(
                text: al.send_whatsapp,
                onPressed: () {
                  context
                      .read<MyAppViewModel>()
                      .retrieveForgotOtp(_phoneController.text, context);
                }),
            verifyWidget,
          ],
        ),
      ),
    );
  }
}
