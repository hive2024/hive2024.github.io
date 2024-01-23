import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:provider/provider.dart';

class PageShare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<MyAppViewModel>();
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "images/share_logo.webp",
            height: 160,
            width: double.infinity,
          ),
          SizedBox(height: 16),
          Text(
            Global.txtShareTitle,
            style: TextStyles.header20,
          ),
          SizedBox(height: 4),
          Text(
            Global.txtShareDesc,
            style: TextStyles.header14,
          ),
          Flexible(flex: 1, child: Container()),
          Text(
            Global.txtShareLink,
            style: TextStyles.header20,
          ),
          Text(
            viewModel.shareLink,
            style: TextStyles.header14,
          ),
          H16,
          Row(
            children: [
              Expanded(
                flex: 1,
                child: MyOutlineButton(
                  text: Global.txtShareCopyLink,
                  onPressed: () {
                    //todo tess clip on phone.
                    Clipboard.setData(
                            ClipboardData(text: viewModel.shareCopyContent))
                        .then((value) {
                    });
                  },
                ),
              ),
              W16,
              Expanded(
                flex: 1,
                child: MyButton(
                  text: Global.txtShareShareTo,
                  onPressed: () {
                    //todo tess clip on phone.
                    //https://pub.dev/packages/url_launcher
                    var shareData = {
                      "title": 'MDN',
                      "text": 'Learn web development on MDN!',
                      "url": 'https://developer.mozilla.org',
                    };
                    window.navigator.share(shareData);
                  },
                ),
              ),
            ],
          ),
          Flexible(flex: 1, child: Container()),
        ],
      ),
    );
  }
}
