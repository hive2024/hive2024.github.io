import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int present = 0;
  int perPage = 10;

  final originalItems = List<String>.generate(10000, (i) => "Item $i");
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      items.addAll(originalItems.getRange(present, present + perPage));
      present = present + perPage;
    });
  }

  void loadMore() {
    setState(() {
      if ((present + perPage) > originalItems.length) {
        items.addAll(originalItems.getRange(present, originalItems.length));
      } else {
        items.addAll(originalItems.getRange(present, present + perPage));
      }
      present = present + perPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            loadMore();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: (present <= originalItems.length)
              ? items.length + 1
              : items.length,
          itemBuilder: (context, index) {
            return (index == items.length)
                ? Container(
                    color: Colors.greenAccent,
                    child: FilledButton(
                      child: Text("Load More"),
                      onPressed: () {
                        loadMore();
                      },
                    ),
                  )
                : ListTile(
                    title: Text('${items[index]}'),
                  );
          },
        ),
      ),
    );
  }
}
