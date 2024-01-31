import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:myhive/pages/mine.dart';
import 'package:myhive/pages/topup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PageWithdraw extends StatefulWidget {
  @override
  State<PageWithdraw> createState() => _PageWithdrawState();
}

class _PageWithdrawState extends State<PageWithdraw> {
  TextEditingController _rechargeController = TextEditingController();
  TextEditingController _walletController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  late Widget verifyWidget;
  late AppLocalizations al;

  bool saveMode = false;
  // String walletAddress = "";
  double fullBlance = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("PageLogin.didChangeDependencies()");
    al = AppLocalizations.of(context)!;
    var viewModel = context.watch<MyAppViewModel>();
    saveMode = viewModel.saveMode;
    fullBlance = viewModel.fullBlance;
    _walletController.text = viewModel.userInfo.settleWalletAddress ?? "";
    // ? Padding(
    //     padding: const EdgeInsets.only(top: 8, bottom: 16),
    //     child: MyButton(
    //       text: al.verify,
    //       onPressed: () {
    //         context
    //             .read<MyAppViewModel>()
    //             .verify(_phoneController.text, context);
    //       },
    //     ),
    //   )
    // : H16;
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<MyAppViewModel>();
    return Scaffold(
      appBar: getAppBar(context, al.txtWithdrawApplication),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(scrollDirection: Axis.vertical, children: [
          getProfileView(),
          H10,
          Row(
            children: [
              getAmountWidget("\$5", () {
                _rechargeController.text = "5";
              }),
              W12,
              getAmountWidget(al.txtFullBlance, () {
                _rechargeController.text = "$fullBlance";
              }),
              W12,
              getAmountWidget(al.txtOther,
                  () => FocusScope.of(context).requestFocus(_focusNode)),
            ],
          ),
          H10,
          TextField(
            enabled: !saveMode,
            focusNode: _focusNode,
            controller: _rechargeController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
                filled: saveMode,
                fillColor: Colors.grey[300],
                hintText: al.txtOtherAmount,
                focusedBorder: forcedInputBorder,
                enabledBorder: enableInputBorder,
                disabledBorder: enableInputBorder,
                prefixIcon: Icon(Icons.attach_money_outlined)),
          ),
          H10,
          Text(al.txtWalletAddress),
          H10,
          Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                enabled: saveMode,
                controller: _walletController,
                decoration: InputDecoration(
                  filled: !saveMode,
                  fillColor: Colors.grey[300],
                  hintText: al.txtWalletAddress,
                  focusedBorder: forcedInputBorder,
                  enabledBorder: enableInputBorder,
                  disabledBorder: enableInputBorder,
                ),
              ),
              MyLiteButton(
                t: saveMode ? al.txtCopy : al.txtEdit,
                click: () {
                  if (saveMode) {
                    viewModel.withDrawCopy(context);
                  } else {
                    viewModel.withDrawSaveMode(true);
                  }
                },
              ),
            ],
          ),
          H10,
          MyButton(
              text: saveMode ? al.txtSave : al.txtWithdraw,
              onPressed: () {
                if (saveMode) {
                  viewModel.saveWallet(context, _walletController.text);
                } else {
                  viewModel.withDraw(context, _rechargeController.text);
                }
              }),
          H10,
          Text(al.txtWithdrawInfo),
        ]),
      ),
    );
  }

  // Widget getAmountEmptyWidget() {
  //   return Flexible(
  //     flex: 1,
  //     fit: FlexFit.loose,
  //     child: SizedBox(
  //       width: double.infinity,
  //       child: Container(),
  //     ),
  //   );
  // }
}
