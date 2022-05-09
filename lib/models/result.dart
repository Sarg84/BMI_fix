import 'dart:math';
import 'package:flutter/cupertino.dart';

class Result with ChangeNotifier {
  double result = 0;
  String textTitle = '';
  Color? titleColor;
  String textDecription = '';

  void res(BuildContext context, double height, int weight) {
    result = weight / pow(height / 100, 2);

    if (result <= 16) {
      textTitle = 'Гораздо ниже нормы';
      textDecription = 'Вам нужно срочно к врачу!';
      titleColor = const Color(0xfff00000);
    } else if (result > 16 && result <= 18.5) {
      textTitle = 'Ниже нормы';
      textDecription = 'Вам нужно больше есть и меньше двигаться!';
      titleColor = const Color(0xffff8000);
    } else if (result > 18.6 && result <= 25) {
      textTitle = 'Вес в норме';
      textDecription = 'У вас все в порядке! Хорошая работа!';
      titleColor = const Color(0xff00ff00);
    } else if (result > 25.1 && result <= 30) {
      textTitle = 'Чуть выше нормы';
      textDecription = 'Немного скинуть не повредило бы!';
      titleColor = const Color(0xffadff2f);
    } else if (result > 30.1 && result <= 35) {
      textTitle = 'Выше нормы';
      textDecription =
          'Пора заканчивать жрать! Пора начинать работать над собой!';
      titleColor = const Color(0xffffff00);
    } else if (result > 35.1 && result <= 40) {
      textTitle = 'Выше нормы';
      textDecription = 'Срочно бегом на тренажеры! И замок на холодильник!';
      titleColor = const Color(0xffff8000);
    } else if (result > 40.1) {
      textTitle = 'Гораздо выше нормы';
      textDecription = 'Вам нужно срочно к врачу!';
      titleColor = const Color(0xfff00000);
    }
    notifyListeners();
  }
}
