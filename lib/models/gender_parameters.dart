import 'package:flutter/material.dart';

class GenderParameters extends ChangeNotifier {
  bool isActiveMale = false;
  bool isActiveFemale = false;
  final activeColor = const Color(0xFF1d1e33);
  final notActiveColor = const Color(0xFF111328);

  void changeColorMale() {
    if (isActiveFemale == false && isActiveMale == false) {
      isActiveMale = true;
      notifyListeners();
    } else if (isActiveMale == true && isActiveFemale == false) {
      isActiveMale = false;
      isActiveFemale = false;
      notifyListeners();
    } else if (isActiveMale == false && isActiveFemale == true) {
      isActiveMale = true;
      isActiveFemale = false;
      notifyListeners();
    }
  }

  void changeColorFemale() {
    if (isActiveFemale == false && isActiveMale == false) {
      isActiveFemale = true;
      notifyListeners();
    } else if (isActiveMale == true && isActiveFemale == false) {
      isActiveMale = false;
      isActiveFemale = true;
      notifyListeners();
    } else if (isActiveMale == false && isActiveFemale == true) {
      isActiveMale = false;
      isActiveFemale = false;
      notifyListeners();
    }
  }

  colorMale() {
    Color colorMale = isActiveMale ? activeColor : notActiveColor;
    return colorMale;
  }

  colorFemale() {
    Color colorFemale = isActiveFemale ? activeColor : notActiveColor;
    return colorFemale;
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0a0e21),
          title: const Text(
            'Ошибка!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Вы не выбрали пол',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: MaterialButton(
                color: const Color(0xFFeb1555),
                textColor: Colors.white,
                child: const Text('Ок'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
