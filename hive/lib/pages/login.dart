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
class PageLogin extends StatefulWidget {
  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  TextEditingController _unameController = TextEditingController();
  bool pwdShow = false;
  bool _nameAutoFocus = true;
  bool _checkboxSelected = false;
  late List<Widget> buttons = [];
  // late Widget verifyWidget;
  late AppLocalizations al;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    // _unameController.text = Global.user.lastLogin;
    // if (_unameController.text.isNotEmpty) {
    //   _nameAutoFocus = false;
    // }
    super.initState();
    print("PageLogin.initState()");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("PageLogin.didChangeDependencies()");
    al = AppLocalizations.of(context)!;
    var appState = context.watch<MyAppViewModel>();
    buttons = [
      MyButton(
        text: al.login_register,
        onPressed: () {
          if (_checkboxSelected) {
            appState.tryLogin(_unameController.text, context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please check user term"),
            ));
          }
        },
      )
    ];
    if (appState.needVerifyLogin) {
      buttons.addAll([
        H10,
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: MyButton(
            text: al.verify,
            onPressed: () {
              appState.verify(_unameController.text, context);
            },
          ),
        ),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // MyAppViewModel viewModel = context.watch<MyAppViewModel>();
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
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextFormField(
                autofocus: _nameAutoFocus,
                controller: _unameController,
                decoration: InputDecoration(
                  hintText: al.hint_phone_number,
                  focusedBorder: forcedInputBorder,
                  enabledBorder: enableInputBorder,
                ),
              ),
            ),
            H16,
            ...buttons,
            H16,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _checkboxSelected,
                  onChanged: (v) {
                    setState(() {
                      _checkboxSelected = !_checkboxSelected;
                    });
                  },
                ),
                Text(
                  al.accept_user_term,
                  style: TextStyles.header2,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class BaseView<T extends ChangeNotifier> extends StatefulWidget {
//   final Widget Function(BuildContext context, T value, Widget child) builder;
//   final Function(T) onModelReady;

//   BaseView({required this.builder, required this.onModelReady});
//   @override
//   _BaseViewState<T> createState() => _BaseViewState<T>();
// }

// class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<T>(
//       create: (context) => model,
//       child: build(context),
//     );
//   }
// }
