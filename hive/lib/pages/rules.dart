import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/views.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageRules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, "Rules"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [Text(AppLocalizations.of(context)!.txtTaskRule)],
        ),
      ),
    );
  }
}
