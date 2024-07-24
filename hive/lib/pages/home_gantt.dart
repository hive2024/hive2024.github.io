import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/tools.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class HomeGantt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [Text("TITLE HomeGantt")],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: colorF5,
        backgroundColor: mainColor,
        shape: CircleBorder(),
        onPressed: () => {},
        child: Transform.rotate(angle: pi / 4, child: Icon(Icons.grid_view)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
