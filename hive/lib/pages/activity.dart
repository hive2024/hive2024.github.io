import 'package:flutter/material.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
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
    var al = appState.activityList.map((e) => NewCard(
          picutre: e.icon ?? "",
          name: e.title ?? "",
          bio: e.desc ?? "",
        ));
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
    required this.picutre,
    required this.name,
    required this.bio,
  });

  final String picutre;
  final String name;
  final String bio;

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
            htmlContent: bio,
            title: name,
          );
        })),
        child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          clipBehavior: Clip.antiAlias,
          semanticContainer: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(child: Image.network(url1), height: 100, width: double.infinity,),
              Image.network(
                picutre,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 16, right: 16, bottom: 4),
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.activityHeader,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Text(
                  bio,
                  maxLines: 1,
                  style: TextStyles.activityDesc,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
