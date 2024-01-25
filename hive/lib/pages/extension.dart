import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:myhive/pages/extension_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PageExtension extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    var viewModel = context.watch<MyAppViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        title: Text(Global.txtExtensionCenter),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ListView(scrollDirection: Axis.vertical, children: [
          // getProfileView(),
          H10,
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: mainColor,
                      style: BorderStyle.solid,
                    ),
                    color: colorEE),
                child: Container(
                  padding: EdgeInsets.only(right: 55),
                  width: double.infinity,
                  child: Text(Global.txtShareLink + viewModel.shareLink),
                ),
              ),
              MyLiteButton(
                t: Global.txtCopy,
                click: () {
                  viewModel.copyShareLink(context);
                },
              ),
            ],
          ),
          H10,
          Row(
            children: [
              _getSmall("New today", 10, context),
              W10,
              _getSmall("Total team size", 10, context),
            ],
          ),
          H10,
          Row(
            children: [
              _getSmall("Primary income today", 10, context),
              W10,
              _getSmall("Secondary income today", 10, context),
            ],
          ),
          H10,
          Row(
            children: [
              _getSmall("My income today", 10, context),
              W10,
              _getSmall("Total revenue today", 10, context),
            ],
          ),
          H10,
          Row(
            children: [
              _getSmall("Promotion income for the month", 10, context),
              W10,
              _getSmall("Total promotional revenue", 10, context),
            ],
          ),
          H10,
          MyButton(
              text: "Details",
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return PageExtensionDetail();
                    }),
                  ))
        ]),
      ),
    );
  }

  Widget _getSmall(String k, double v, BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      flex: 1,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: mainColor,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              k,
              style: TextStyles.header20,
              textAlign: TextAlign.center,
            ),
            H5,
            Text("$v", style: TextStyles.header14),
          ],
        ),
      ),
    );
  }

  Widget getAmountEmptyWidget() {
    return Flexible(
      flex: 1,
      fit: FlexFit.loose,
      child: SizedBox(
        width: double.infinity,
        child: Container(),
      ),
    );
  }
}
