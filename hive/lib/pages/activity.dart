import 'package:flutter/material.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/json/user.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:myhive/pages/detail.dart';
import 'package:provider/provider.dart';

class PageActivity extends StatelessWidget {
  const PageActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppViewModel>();
    var al = appState.activityList.map((e) => NewCard(activity: e));
    return ListView(
      children: [
        ...al,
        H16,
      ],
    );
  }
}

class NewCard extends StatelessWidget {
  const NewCard({
    super.key,
    required this.activity,
  });

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final style = theme.textTheme.displayMedium!.copyWith(
    //   color: theme.colorScheme.onPrimary,
    // );

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: GestureDetector(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PageDetail(
            htmlContent: activity.desc ?? "",
            title: activity.title ?? "",
          );
        })),
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          clipBehavior: Clip.antiAlias,
          semanticContainer: false,
          color: colorF5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(child: Image.network(url1), height: 100, width: double.infinity,),
              Image.network(
                activity.icon ?? "",
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                child: Text(
                  activity.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.activityHeader,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 8, top: 4),
                  child: Text(
                    activity.subTitle ?? "",
                    maxLines: 1,
                    style: TextStyles.activityDesc,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
