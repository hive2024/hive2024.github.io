import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/views.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myhive/test/test_api.dart';

class PageDebug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, "Debug Info"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Text("platform=${APIS.language}"),
            Text("platform=${Global.platform}"),
            Text("apiKey=${APIS.apiKey}"),
            Text("shareCode=${Global.shareCode}"),
            Text("isApp = ${Global.isApp}"),
            H16,
            Text("${Global.urlParams}"),
          ],
        ),
      ),
    );
  }
}
