import 'package:flutter/material.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///
/// PageLogin
///   - PageLoginPwd
///     - PageLoginRetrievePwd
///     - PageLoginReset
///   - PageLoginReg
///
///
class PageLogin extends StatelessWidget {
  bool pwdShow = false;
  bool _nameAutoFocus = true;

  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    MyAppViewModel viewModel = context.watch<MyAppViewModel>();
    int ot = viewModel.otpTimer;
    String ots = ot > 0 ? " ($ot)" : "";
    return Scaffold(
      appBar: getAppBar(context, al.login),
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
            TextFormField(
              autofocus: _nameAutoFocus,
              controller: viewModel.loginPhoneTEC,
              enabled: !viewModel.needVerifyLogin,
              decoration: InputDecoration(
                hintText: al.hint_phone_number,
                focusedBorder: forcedInputBorder,
                enabledBorder: enableInputBorder,
                disabledBorder: disableInputBorder,
              ),
            ),
            H16,
            if (!viewModel.needVerifyLogin) ...[
              MyButton(
                text: al.login_register,
                onPressed: () {
                  if (viewModel.checkboxSelected) {
                    viewModel.tryLogin(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please check user term"),
                    ));
                  }
                },
              ),
              H16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: viewModel.checkboxSelected,
                    onChanged: (v) {
                      viewModel.clickCheckBox();
                    },
                  ),
                  Text(
                    al.accept_user_term,
                    style: TextStyles.header2,
                  )
                ],
              )
            ],
            if (viewModel.needVerifyLogin) ...[
              MyButton(
                text: "${al.send_verify_code} $ots",
                onPressed: () {
                  viewModel.sendLoginOTP(context);
                },
              ),
              H16,
              TextFormField(
                controller: viewModel.loginOtpTEC,
                decoration: InputDecoration(
                  hintText: al.input_verify_code,
                  focusedBorder: forcedInputBorder,
                  enabledBorder: enableInputBorder,
                ),
              ),
              H16,
              MyButton(
                text: al.verify,
                onPressed: () {
                  viewModel.verify(context);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
