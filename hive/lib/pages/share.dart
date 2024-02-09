import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class PageShare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    var viewModel = context.watch<MyAppViewModel>();
    PlatformWebViewController? controller;
    if (viewModel.shareCopyContent.isNotEmpty) {
      controller = PlatformWebViewController(
        const PlatformWebViewControllerCreationParams(),
      )..hiveLoad(viewModel.shareCopyContent);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset(
          //   "images/share_logo.webp",
          //   height: 160,
          //   width: double.infinity,
          // ),
          // SizedBox(height: 16),
          // Text(
          //   al.txtShareTitle,
          //   style: TextStyles.header20,
          // ),
          // SizedBox(height: 4),
          // Text(
          //   viewModel.shareCopyContent,
          //   style: TextStyles.header14,
          // ),
          // Flexible(flex: 1, child: Container()),
          controller != null
              ? Flexible(
                  flex: 1,
                  child: PlatformWebViewWidget(
                    PlatformWebViewWidgetCreationParams(controller: controller),
                  ).build(context),
                )
              : CircularProgressIndicator(color: mainColor),
          // Text(
          //   al.txtShareLink,
          //   style: TextStyles.header20,
          // ),
          // Text(
          //   viewModel.shareLink,
          //   style: TextStyles.header14,
          // ),
          // H16,
          Row(
            children: [
              Expanded(
                flex: 1,
                child: MyOutlineButton(
                  text: al.txtShareCopyLink,
                  textAlign: TextAlign.center,
                  onPressed: () {
                    //todo tess clip on phone.
                    Clipboard.setData(
                            ClipboardData(text: viewModel.shareLink))
                        .then((value) {});
                  },
                ),
              ),
              SizedBox(width: 60),
              Expanded(
                flex: 1,
                child: MyButton(
                  text: al.txtShareShareTo,
                  onPressed: () {
                    //todo tess clip on phone.
                    //https://pub.dev/packages/url_launcher
                    var shareData = {
                      // "title": 'MDN',
                      // "text": 'Learn web development on MDN!',
                      "url": viewModel.shareLink,
                    };
                    window.navigator.share(shareData);
                  },
                ),
              ),
            ],
          ),
          H8,
        ],
      ),
    );
  }
}
