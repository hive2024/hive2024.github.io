import 'package:flutter/material.dart';
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

// class PageRules extends StatelessWidget {
//   const PageRules({
//     super.key,
//     required this.url,
//   });

//   final String url;

//   @override
//   Widget build(BuildContext context) {
//     var viewModel = context.watch<MyAppViewModel>();
//     viewModel.getActDetail(eventId);
//     var html = viewModel.activityDetail.desc;
//     PlatformWebViewController? controller;
//     if (html != null) {
//       controller = PlatformWebViewController(
//         const PlatformWebViewControllerCreationParams(),
//       )..hiveLoad(html);
//     }

//     return Scaffold(
//       body: SizedBox(
//         child: controller != null
//             ? PlatformWebViewWidget(
//                 PlatformWebViewWidgetCreationParams(controller: controller),
//               ).build(context)
//             : CircularProgressIndicator(color: mainColor),
//       ),
//     );
//   }
// }
