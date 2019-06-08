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
}