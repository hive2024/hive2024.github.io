import 'package:flutter/material.dart';
import 'package:myhive/common/global.dart';
import 'package:myhive/common/strings.dart';
import 'package:video_player/video_player.dart';

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
  });

  final String text;
  final VoidCallback? onPressed;

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
                textAlign: TextAlign.center,
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
    print("_controller.play() ${widget.url}");
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
              child: CircularProgressIndicator(color: Global.mainColor),
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

class VideoApp3 extends StatefulWidget {
  const VideoApp3({super.key});

  @override
  State<VideoApp3> createState() => _VideoAppState3();
}

class _VideoAppState3 extends State<VideoApp3> {
  late VideoPlayerController _controller;

  var flag = 0;
  final mybuttonkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    )
      ..setVolume(0)
      ..setLooping(true)
      ..initialize().then((_) {
        Future.delayed(Duration(seconds: 1), () {
          print("controller.play()");
          _controller.play();
          Future.delayed(Duration(seconds: 2), () {
            print("controller.setVolume()");
            _controller.setVolume(1);
          });
        });
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    print("build.flag = $flag");
    if (flag < 1) {}
    flag++;
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? Column(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                      key: mybuttonkey,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            print(
                                "error= ${_controller.value.errorDescription}");
                          },
                          icon: Icon(
                            Icons.error,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _controller.play();
                            });
                          },
                          icon: Icon(
                            Icons.text_fields_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _controller.setVolume(1);
                            });
                          },
                          icon: Icon(
                            Icons.volume_up,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Container(
                  color: Colors.amber,
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
