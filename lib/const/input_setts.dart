import 'package:flutter/material.dart';

class InputSetts {
  static const searcAppBarInput = InputDecoration(
    border: OutlineInputBorder(borderSide: BorderSide()),
    filled: true,
    fillColor: Colors.white,
    hintText: "Ara",
    prefixIcon: Icon(Icons.search),
  );
  static const titleTStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const tempTStyle =
      TextStyle(fontSize: 34, fontWeight: FontWeight.w500);
}
