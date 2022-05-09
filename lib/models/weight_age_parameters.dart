import 'package:flutter/material.dart';

class WeightAgeParameters extends ChangeNotifier {
  int weight = 60;
  int age = 18;

  void changeWeightPlus() {
    if (weight >= 250) {
      return;
    } else {
      weight++;
    }
    notifyListeners();
  }

  void changeWeightMinus() {
    if (weight <= 1) {
      return;
    } else {
      weight--;
    }
    notifyListeners();
  }

  void changeAgePlus() {
    if (age >= 120) {
      return;
    } else {
      age++;
    }
    notifyListeners();
  }

  void changeAgeMinus() {
    if (age <= 1) {
      return;
    } else {
      age--;
    }
    notifyListeners();
  }
}
