import 'package:flutter/material.dart';
import 'package:instagramdownloader/pages/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
