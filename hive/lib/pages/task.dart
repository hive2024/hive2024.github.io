import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/tools.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/json/user.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:myhive/pages/rules.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    var viewModel = context.watch<MyAppViewModel>();
    var tasks = viewModel.taskList;
    List<Widget> r1 = [];
    List<Widget> r2 = [];
    List<Widget> r3 = [];
    try {
      if (tasks.isNotEmpty) {
        r1.add(Expanded(flex: 1, child: MyTaskCard(task: tasks[0])));
        r1.add(H16);
      }
      if (tasks.length > 1) {
        r1.add(Expanded(flex: 1, child: MyTaskCard(task: tasks[1])));
      }
      if (tasks.length > 2) {
        r2.add(Expanded(flex: 1, child: MyTaskCard(task: tasks[2])));
        r2.add(H16);
      }
      if (tasks.length > 3) {
        r2.add(Expanded(flex: 1, child: MyTaskCard(task: tasks[3])));
      }
      if (tasks.length > 4) {
        r3.add(Expanded(flex: 1, child: MyTaskCard(task: tasks[4])));
        r3.add(H16);
      }
      if (tasks.length > 5) {
        r3.add(Expanded(flex: 1, child: MyTaskCard(task: tasks[5])));
      }
    } catch (e) {
      printLog(e);
    }

    Widget taskList = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        // PageTask PageTask:file:///Users/daining/ddai_workspace/flutter_project/hive/lib/main.dart:89:7
        H10,
        Text(al.mining_for_revenue, style: TextStyles.headerTask),
        H16,
        Row(children: r1),
        H16,
        Row(children: r2),
        H16,
        Row(children: r3),
        H16,
        Text(
          "${al.your_coin_balance_is} ${viewModel.userIntegral}",
          style: TextStyles.headerTask,
        ),
        H16,
        Row(
          children: [
            Expanded(
              flex: 1,
              child: MyOutlineButton(
                  textAlign: TextAlign.center,
                  text: al.txtRules,
                  onPressed: () {
                    Navigator.pushNamed(context, viewModel.ruleLink);
                  }),
            ),
            W16,
            Expanded(
              flex: 1,
              child: MyButton(
                text: al.txtExchange,
                onPressed: () {
                  viewModel.exchange(context);
                },
              ),
            ),
          ],
        ),
        // MyButton(text: "test", onPressed: () => showTopupDialog(context, 1))
      ],
    );

    Widget taskDetail = ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: taskList,
      ),
    );
    return taskDetail;
  }
}

void showTopupDialog(BuildContext context, int id) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: color2169,
        insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        // contentPadding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        content: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset("images/success4.webp"),
            ),
            Expanded(
              flex: 1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyWorkProgress(taskId: id),
                  ]),
            ),
          ],
        ),
        actions: <Widget>[],
      );
    },
  );
}

///
///type: 0-start; 1-working; 2-lock
///status 0、未参加（可参加）；1、已参加；2、不可参加
///
class MyTaskCard extends StatelessWidget {
  final Task task;
  const MyTaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    String finalIcon = task.icon ?? "images/vip1.webp";
    printLog("task card ${task.level} ; $finalIcon");
    List<Widget> views = [
      Image.network(finalIcon, width: double.infinity, fit: BoxFit.fitWidth)
    ];
    var status = task.status;
    if (status == 0) {
      //   views.add(Positioned(
      //       bottom: 15,
      //       child: Text("Start",
      //           style: TextStyle(
      //             foreground: Paint()
      //               ..style = PaintingStyle.stroke
      //               ..strokeWidth = 2
      //               ..color = Colors.white,
      //             fontSize: 26,
      //           ))));
      //   views.add(Positioned(
      //       bottom: 15,
      //       child: Text("Start",
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontSize: 26,
      //           ))));
    }
    if (status == 1) {
      views.add(Positioned(
          child: Container(
        color: colorx1,
      )));
      views.add(Positioned(
        top: 8,
        right: 8,
        child: SizedBox(
          width: 26,
          height: 26,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
      ));
    }
    if (status == 2) {
      views.add(Positioned(
          child: Container(
        color: Color(0XBB000000),
      )));
      views.add(Positioned(
          top: 8,
          right: 8,
          child: Icon(
            Icons.lock_outline,
            color: Colors.white,
            size: 32,
          )));
    }
    views.add(Positioned(
        top: 8,
        child: Text(task.title ?? "",
            style: TextStyle(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = Colors.white,
              fontSize: 28,
            ))));
    views.add(Positioned(
        top: 8,
        child: Text(task.title ?? "",
            style: TextStyle(
              color: colorF5,
              fontSize: 28,
            ))));
    views.add(Positioned(
        bottom: 15,
        child: Text(task.desc ?? "",
            style: TextStyle(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = Colors.white,
              fontSize: 22,
            ))));
    views.add(Positioned(
        bottom: 15,
        child: Text(task.desc ?? "",
            style: TextStyle(
              color: colorF5,
              fontSize: 22,
            ))));
    return Card(
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      clipBehavior: Clip.antiAlias,
      semanticContainer: false,
      child: AspectRatio(
        aspectRatio: 400 / 233,
        child: GestureDetector(
          onTap: () {
            if (task.status == 0) {
              showTopupDialog(context, task.id);
            }
          },
          child: Container(
            color: Colors.white,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Stack(
                alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                children: views,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyWorkProgress extends StatefulWidget {
  const MyWorkProgress({
    super.key,
    required this.taskId,
  });

  final int taskId;

  @override
  State<MyWorkProgress> createState() => _MyWorkProgressState();
}

class _MyWorkProgressState extends State<MyWorkProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  var finish = false;
  late AppLocalizations al;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, //注意State类需要混入SingleTickerProviderStateMixin（提供动画帧计时/触发器）
      duration: Duration(seconds: 3),
    );
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    al = AppLocalizations.of(context)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [];
    if (_animationController.value >= 1) {
      views = [
        Text(
          al.txtSuccess,
          style: TextStyle(
            color: colorAA3A,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(al.yours_are_ready,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
            )),
        H8,
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: MyButton(
              text: AppLocalizations.of(context)!.txtSuccess,
              onPressed: () {
                context
                    .read<MyAppViewModel>()
                    .clickTask(context, widget.taskId);
              }),
        ),
      ];
    } else {
      views = [
        getProgress(),
        H4,
        Text(al.yours_ard_matched,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
            )),
      ];
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: views,
    );
  }

  Widget getProgress() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: LinearProgressIndicator(
        backgroundColor: color2169,
        valueColor: AlwaysStoppedAnimation(Colors.white),
        value: _animationController.value,
      ),
    );
  }
}
