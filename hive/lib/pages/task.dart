import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/strings.dart';
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
      print(e);
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
                text: al.txtRules,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return PageRules();
                  }),
                ),
              ),
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
        // button
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
        insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        contentPadding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        content: Column(
          children: [
            Expanded(
              flex: 25,
              child: Image.asset("images/success.webp"),
            ),
            Expanded(
              flex: 15,
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
    String bg = "images/vip${(task.level <= 6) ? task.level : 6}.webp";
    List<Widget> views = [
      Image.asset(bg, width: double.infinity, fit: BoxFit.fitWidth)
    ];
    var status = task.status;
    if (status == 0) {
      views.add(Positioned(
          bottom: 15,
          child: Text("Start",
              style: TextStyle(
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.white,
                fontSize: 26,
              ))));
      views.add(Positioned(
          bottom: 15,
          child: Text("Start",
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
              ))));
    }
    if (status == 1) {
      views.add(Positioned(
          bottom: 15,
          child: Text("Working",
              style: TextStyle(
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.white,
                fontSize: 26,
              ))));
      views.add(Positioned(
          bottom: 15,
          child: Text("Working",
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
              ))));
    }
    if (status == 2) {
      views.add(Image.asset(
        "images/only${(task.level <= 6) ? task.level : 6}.webp",
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fitWidth,
      ));
    }
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

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, //注意State类需要混入SingleTickerProviderStateMixin（提供动画帧计时/触发器）
      duration: Duration(seconds: 3),
    );
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget actionView = (_animationController.value >= 1)
        ? Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: MyButton(
                text: AppLocalizations.of(context)!.txtSuccess,
                onPressed: () {
                  context
                      .read<MyAppViewModel>()
                      .clickTask(context, widget.taskId);
                }),
          )
        : getProgress();

    return actionView;
  }

  Widget getProgress() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: LinearProgressIndicator(
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation(Global.mainColor),
        value: _animationController.value,
      ),
    );
  }
}
