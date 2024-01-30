import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:myhive/pages/mine.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageTopup extends StatefulWidget {
  @override
  State<PageTopup> createState() => _PageTopupState();
}

class _PageTopupState extends State<PageTopup> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _rechargeController = TextEditingController();
  TextEditingController _walletController = TextEditingController();
  FocusNode _amountFocus = FocusNode();
  late AppLocalizations al;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("PageLogin.didChangeDependencies()");
    al = AppLocalizations.of(context)!;
    var appState = context.watch<MyAppViewModel>();
    _rechargeController.text = appState.userInfo.chargeWalletAddress ?? "";
    _walletController.text = appState.userInfo.settleWalletAddress ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, al.txtMeRecharge),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(scrollDirection: Axis.vertical, children: [
          getProfileView(),
          H10,
          Row(
            children: [
              getAmountWidget("\$5", () => _amountController.text = '5'),
              W12,
              getAmountWidget("\$50", () => _amountController.text = '50'),
              W12,
              getAmountWidget("\$100", () => _amountController.text = '100'),
            ],
          ),
          H10,
          Row(
            children: [
              getAmountWidget("\$200", () => _amountController.text = '200'),
              W12,
              getAmountWidget("\$500", () => _amountController.text = '500'),
              W12,
              getAmountWidget(al.txtOther,
                  () => FocusScope.of(context).requestFocus(_amountFocus)),
            ],
          ),
          H10,
          TextField(
            focusNode: _amountFocus,
            controller: _amountController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: al.txtOtherAmount,
              focusedBorder: forcedInputBorder,
              enabledBorder: enableInputBorder,
              prefixIcon: Icon(Icons.attach_money_outlined),
            ),
          ),
          H10,
          MyButton(
              text: al.txtRecharge,
              onPressed: () {
                if (_amountController.text.isNotEmpty) {
                  showTopupDialog();
                } else {
                  toast(context, al.input_amount);
                }
              }),
          H10,
          Text(al.txtTopupInfo1),
        ]),
      ),
    );
  }

  void showTopupDialog() {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10),
          contentPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                al.txtRechargeAddress,
                style: TextStyles.header16,
              ),
              H16,
              TextField(
                readOnly: true,
                controller: _rechargeController,
                decoration: InputDecoration(
                  hintText: al.txtRechargeAddress,
                  focusedBorder: forcedInputBorder,
                  enabledBorder: enableInputBorder,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(MColorF4),
                        ),
                        onPressed: () {
                          Clipboard.setData(
                                  ClipboardData(text: _rechargeController.text))
                              .then((value) {
                            toast(context, "Copy: ${_rechargeController.text}");
                          });
                        },
                        child: Text(al.txtCopy, style: TextStyles.btn4)),
                  ),
                ),
              ),
              H16,
              Text(al.txtWalletAddress),
              H16,
              TextField(
                readOnly: true,
                controller: _walletController,
                decoration: InputDecoration(
                  hintText: al.txtWalletAddress,
                  focusedBorder: forcedInputBorder,
                  enabledBorder: enableInputBorder,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(MColorF4),
                        ),
                        onPressed: () {
                          context
                              .read<MyAppViewModel>()
                              .topupEditWallet(context);
                        },
                        child: Text(al.txtEdit, style: TextStyles.btn4)),
                  ),
                ),
              ),
              H16,
              Text(al.txtTopupInfo2),
              H16,
              MyButton(
                  text: al.txtConfirmRecharge,
                  onPressed: () {
                    context.read<MyAppViewModel>().topup(context,
                        _amountController.text, _walletController.text);
                  }),
            ],
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}

Widget getAmountWidget(String text, VoidCallback click) {
  return Flexible(
    flex: 1,
    fit: FlexFit.loose,
    child: SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              // side: BorderSide(color: color6D, width: 1),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(mainColor),
        ),
        onPressed: click,
        child: Text(text,style: TextStyles.btn1,),
      ),
    ),
  );
}

Widget getAmountWidget2(String text, VoidCallback click) {
  return Flexible(
    flex: 1,
    fit: FlexFit.loose,
    child: SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: color6D, width: 1)),
          ),
          backgroundColor: MaterialStateProperty.all(MColor4C),
        ),
        onPressed: click,
        child: Text(text),
      ),
    ),
  );
}
