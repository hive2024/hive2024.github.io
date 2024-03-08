import 'package:flutter/material.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageRetrievePwd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    MyAppViewModel viewModel = context.watch<MyAppViewModel>();
    int ot = viewModel.otpTimer;
    String ots = ot > 0 ? " ($ot)" : "";
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
              controller: viewModel.forgotPhoneTEC,
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
                text: "${al.send_verify_code} $ots",
                onPressed: () {
                  context.read<MyAppViewModel>().sendForgotOtp(context);
                }),

            if (viewModel.forgotOtpSent) ...[
              H16,
              TextFormField(
                controller: viewModel.forgotOtpTEC,
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
                  viewModel.verifyForgotOtp(context);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
