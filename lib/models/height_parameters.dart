import 'package:flutter/material.dart';

class HeightParameters extends ChangeNotifier {
  double height = 150.0;

  void changeHeight(val) {
    height = val;
    notifyListeners();
  }
}
