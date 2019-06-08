import 'package:flutter/material.dart';
import 'package:instagramdownloader/style/theme.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: GlobalTheme.renderBackground(),
      ),
    );
  }
}
