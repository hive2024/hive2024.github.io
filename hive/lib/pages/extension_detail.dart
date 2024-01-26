import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/json/user.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PageExtensionDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController detailDateStart =
        context.watch<MyAppViewModel>().detailDateStart;

    AppLocalizations al = AppLocalizations.of(context)!;
    var viewModel = context.watch<MyAppViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        title: Text(Global.txtPromotionDetails),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            H10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownMenu<String>(
                      width: 300,
                      label: const Text('Team'),
                      onSelected: (value) => viewModel.onSelectTeam(value),
                      dropdownMenuEntries: [
                        DropdownMenuEntry<String>(
                          value: "1",
                          label: "primary team",
                          leadingIcon: Icon(Icons.diversity_1),
                        ),
                        DropdownMenuEntry<String>(
                          value: "1",
                          label: "Secondary income today",
                          leadingIcon: Icon(Icons.diversity_1),
                        ),
                        DropdownMenuEntry<String>(
                          value: "1",
                          label:
                              "Secondary income today Secondary income today ",
                          leadingIcon: Icon(Icons.diversity_1),
                        ),
                      ],
                    ),
                    H10,
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: detailDateStart,
                        decoration: InputDecoration(
                          labelText: "date",
                          border: OutlineInputBorder(),
                        ),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          showTopupDialog(context);
                        },
                      ),
                    ),
                  ],
                ),
                FloatingActionButton(
                  onPressed: () => viewModel.search(),
                  elevation: 0,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            H10,
            H10,
            Flexible(
              flex: 1,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    viewModel.detailLoadmore();
                  }
                  return false;
                },
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 5.0),
                  itemCount: 1 + viewModel.detailList.length,
                  itemBuilder: (context, index) {
                    return (index == viewModel.detailList.length)
                        ? OutlinedButton(
                            onPressed: viewModel.detailLoadmore,
                            child: Text(viewModel.detailHasLoadmore
                                ? "Load More"
                                : "No More"),
                          )
                        : PromotionInfo(info: viewModel.detailList[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromotionInfo extends StatelessWidget {
  const PromotionInfo({
    super.key,
    required this.info,
  });

  final Promotion info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: mainColor,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Promotion Id  ${info.uid}', style: TextStyles.header14),
          H10,
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: SizedBox(
                      width: double.infinity,
                      child: Text('Lv ${info.level}',
                          style: TextStyles.header14))),
              Flexible(
                  flex: 3,
                  child: SizedBox(
                      width: double.infinity,
                      child: Text('earning ${info.income}',
                          style: TextStyles.header14))),
              Flexible(
                  flex: 3,
                  child: SizedBox(
                      width: double.infinity,
                      child: Text('Promotion income ${info.allIncome}',
                          style: TextStyles.header14))),
            ],
          )
        ],
      ),
    );
  }
}

void showTopupDialog(BuildContext c) {
  showDialog(
    context: c,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        // content: Text("aaa"),
        content: Container(
          width: 400,
          height: 400,
          child: SfDateRangePicker(
            view: DateRangePickerView.month,
            showActionButtons: true,
            selectionMode: DateRangePickerSelectionMode.range,
            showTodayButton: true,
            onSubmit: (p0) {
              print("onSubmit $p0");
              Navigator.of(context).pop();
              if (p0 is PickerDateRange) {
                c.read<MyAppViewModel>().updateDate(p0);
              }
            },
            onCancel: () {
              print("onCancel");
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: <Widget>[],
      );
    },
  );
}
