import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gantt_chart/gantt_chart.dart';
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
          children: [Text("TITLE HomeGantt"), getGanttView()],
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

  getGanttView() {
    return GanttChartView(
      maxDuration: const Duration(
          days: 30 * 2), //optional, set to null for infinite horizontal scroll
      startDate: DateTime(2024, 7, 22), //required
      dayWidth: 30, //column width for each day
      eventHeight: 30, //row height for events
      stickyAreaWidth: 200, //sticky area width
      showStickyArea: true, //show sticky area or not
      showDays: true, //show days or not
      startOfTheWeek: WeekDay.sunday, //custom start of the week
      weekEnds: const {WeekDay.friday, WeekDay.saturday}, //custom weekends
      isExtraHoliday: (context, day) {
        //define custom holiday logic for each day
        return DateUtils.isSameDay(DateTime(2022, 7, 1), day);
      },
      events: [
        //event relative to startDate
        GanttRelativeEvent(
          relativeToStart: const Duration(days: 0),
          duration: const Duration(days: 5),
          displayName: '77288 Real Match划卡页增加reaction',
        ),
        //event with absolute start and end
        GanttAbsoluteEvent(
          startDate: DateTime(2024, 7, 24),
          endDate: DateTime(2024, 8, 1),
          displayName: '78744 Real Match划卡引导',
        ),
      ],
    );
  }
}
