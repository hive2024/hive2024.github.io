import 'package:flutter/material.dart';

class PagePlay extends StatelessWidget {
  const PagePlay({
    super.key,
    required this.myTitle,
  });

  final myTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 100,
              child: Container(
                color: Colors.cyan,
                child: Text("HOME-$myTitle-11"),
              ),
            ),
            SizedBox(
              width: 400,
              height: 100,
              child: Container(
                color: Colors.cyan,
                child: Text("HOME-$myTitle-22"),
              ),
            ),
            SizedBox(
              width: 400,
              height: 100,
              child: Container(
                color: Colors.cyan,
                child: Text("HOME-$myTitle-33"),
              ),
            ),
            SizedBox(
              width: 400,
              height: 100,
              child: Container(
                color: Colors.cyan,
                child: Text("HOME-$myTitle-44"),
              ),
            ),
            SizedBox(
              width: 400,
              height: 100,
              child: Container(
                color: Colors.cyan,
                child: Text("HOME-$myTitle-55"),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     color: Colors.cyan,
            //     child: Text("HOME-$myTitle-66"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
