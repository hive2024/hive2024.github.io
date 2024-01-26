import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/views.dart';
import 'package:myhive/pages/AppViewModel.dart';
import 'package:myhive/pages/login_reset.dart';
import 'package:myhive/pages/extension.dart';
import 'package:myhive/pages/topup.dart';
import 'package:myhive/test/test_api.dart';
import 'package:provider/provider.dart';

class PageMine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<MyAppViewModel>();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getProfileView(),
          SizedBox(height: 20),
          MyOutlineButton(
            text: Global.txtMeRecharge,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return PageTopup();
                }),
              );
            },
          ),
          H4,
          MyOutlineButton(
            text: Global.txtMeWithdraw,
            onPressed: () {
              viewModel.settingOpenWithdraw(context);
            },
          ),
          H16,
          MyOutlineButton(
            text: Global.txtMeExtension,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return PageExtension();
                }),
              );
            },
          ),
          H4,
          MyOutlineButton(
            text: Global.txtMeChangePassword,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return PageLoginReset();
                }),
              );
            },
          ),
          H16,
          MyOutlineButton(
            text: Global.txtMeLogOut,
            onPressed: () {
              context.read<MyAppViewModel>().logout(context);
            },
          ),
          H16,
          MyOutlineButton(
            text: 'Test API',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return PageTestApi();
                }),
              );
            },
          ),
          H10,
          Text("Contect US", style: TextStyles.header20),
          H10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  viewModel.contectWhatsapp();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("images/whatsapp.webp", width: 35, height: 35),
                    H4,
                    Text("Whatsapp")
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  viewModel.contectMessenger();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("images/messeger.webp", width: 35, height: 35),
                    H4,
                    Text("Messenger")
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  viewModel.contectTelegram();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("images/telegram.webp", width: 35, height: 35),
                    H4,
                    Text("Telegram")
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget getProfileView() {
  return MyProfileView();
}

class MyProfileView extends StatelessWidget {
  const MyProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<MyAppViewModel>();
    double blance = viewModel.fullBlance;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Container(
        child: Row(
          children: [
            Image.asset(
              "images/avatar.webp",
              height: 80,
              width: 80,
            ),
            SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            "images/vip_fill.webp",
                            height: 24,
                            width: 24,
                          ),
                          Flexible(
                            flex: 1,
                            child: Center(
                                child: Text("VIP ${viewModel.userInfo.level}")),
                          ),
                        ],
                      ),
                    ),
                    H16,
                    Text("Blacnce:$blance"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
