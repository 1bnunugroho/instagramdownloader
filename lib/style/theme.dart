import 'package:flutter/material.dart';

class GlobalTheme {
  static renderBackground() {
    return new BoxDecoration(
      gradient: new LinearGradient(
          colors: [Colors.grey[200], Colors.grey[300]],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
    );
  }

  static defaultInputPadding() {
    return EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0);
  }
}

final Color color1 = Color(0xff38bbad);
final Color color2 = Color(0xff2b7a98);
