import 'package:flutter/material.dart';
import 'package:myhive/common/strings.dart';
import 'package:myhive/common/tools.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

extension addHive on PlatformWebViewController {
  hiveLoad(String html) {
    var newHtml = html.replaceAll("<img src=", "<img width='100%' src=");
    loadHtmlString(newHtml);
  }
}

extension addPadding on Widget {
  addHP(double p) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: p), child: this);
  }

  addLRBPadding(double p) {
    return Padding(
        padding: EdgeInsets.only(left: p, right: p, bottom: p), child: this);
  }
}

class MyTextTitle extends StatelessWidget {
  const MyTextTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.header,
      textAlign: TextAlign.center,
    );
  }
}

class MyTextTip extends StatelessWidget {
  const MyTextTip({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyles.header1, textAlign: TextAlign.center);
  }
}

const SizedBox H4 = SizedBox(height: 4);
const SizedBox H5 = SizedBox(height: 5);
const SizedBox H8 = SizedBox(height: 8);
const SizedBox H10 = SizedBox(height: 10);
const SizedBox H16 = SizedBox(height: 16);
const SizedBox W10 = SizedBox(width: 10);
const SizedBox W12 = SizedBox(width: 12);
const SizedBox W16 = SizedBox(width: 16);

AppBar getAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    leading: BackButton(onPressed: () => Navigator.of(context).pop()),
    title: Text(title),
  );
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          onPressed: onPressed,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyles.btn1,
              ),
            ),
          )),
    );
  }
}

// class MyDisButton extends StatelessWidget {
//   const MyDisButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//   });

//   final String text;
//   final VoidCallback? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: FilledButton(
//           style: ButtonStyle(
//             shape: MaterialStateProperty.all(
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//           ),
//           onPressed: onPressed,
//           child: SizedBox(
//             width: double.infinity,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Text(
//                 text,
//                 textAlign: TextAlign.center,
//                 style: TextStyles.btn1,
//               ),
//             ),
//           )),
//     );
//   }
// }

class MyOutlineButton extends StatelessWidget {
  const MyOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textAlign,
  });

  final String text;
  final VoidCallback? onPressed;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          onPressed: onPressed,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                text,
                textAlign: textAlign ?? TextAlign.start,
                style: TextStyles.btn2,
              ),
            ),
          )),
    );
  }
}

class MySettingButton extends StatelessWidget {
  const MySettingButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: color6D, width: 1)),
            ),
            backgroundColor: MaterialStateProperty.all(MColor4C),
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyles.btn3,
                ),
                Flexible(flex: 1, child: Container()),
                SizedBox(
                    width: 18,
                    height: 18,
                    child: Icon(Icons.arrow_forward_ios, size: 18)),
              ],
            ),
          )),
    );
  }
}

class VideoApp extends StatefulWidget {
  const VideoApp({super.key, required this.url});
  final String url;

  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    printLog("_controller.play() ${widget.url}");
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        Future.delayed(Duration(seconds: 1), () {
          print("_controller.play()");
          _controller.play();
        });
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(
              color: Colors.white,
              width: 200,
              height: 200,
              child: CircularProgressIndicator(color: mainColor),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class MyLiteButton extends StatelessWidget {
  const MyLiteButton({super.key, required this.t, required this.click});
  final String t;
  final VoidCallback click;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MColorF4),
          ),
          onPressed: click,
          child: Text(t, style: TextStyles.btn4)),
    );
  }
}
