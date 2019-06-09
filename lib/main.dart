import 'package:flutter/material.dart';
import 'package:instagramdownloader/pages/homepage.dart';

//import 'package:flutter/rendering.dart';

void main() {
    //debugPaintSizeEnabled = true;
    //debugPaintBaselinesEnabled = true;
    //debugPaintPointersEnabled = true;
    runApp(new MyApp());
  }


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Downloader',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
    );
  }
}
