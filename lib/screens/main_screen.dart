import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/gender_parameters.dart';
import '../models/height_parameters.dart';
import '../models/result.dart';
import '../models/weight_age_parameters.dart';
import 'result_list_screen.dart';
import 'result_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weight = context.watch<WeightAgeParameters>().weight;
    final age = context.watch<WeightAgeParameters>().age;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          '\nКалькулятор ИМТ',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF0a0e21),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
              child: Row(
                children: [
                  GenderButton(
                    title: 'МУЖ',
                    icon: Icons.male,
                    onTap: () =>
                        Provider.of<GenderParameters>(context, listen: false)
                            .changeColorMale(),
                    color: context.watch<GenderParameters>().colorMale(),
                  ),
                  const SizedBox(width: 20),
                  GenderButton(
                    title: 'ЖЕН',
                    icon: Icons.female,
                    onTap: () =>
                        Provider.of<GenderParameters>(context, listen: false)
                            .changeColorFemale(),
                    color: context.watch<GenderParameters>().colorFemale(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1d1e33),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: SliderWidget(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  WeightAgeWidget(
                    title: 'ВЕС',
                    data: '$weight кг',
                    plus: () =>
                        context.read<WeightAgeParameters>().changeWeightPlus(),
                    minus: () =>
                        context.read<WeightAgeParameters>().changeWeightMinus(),
                  ),
                  const SizedBox(width: 20),
                  WeightAgeWidget(
                    title: 'ВОЗРАСТ',
                    data: '$age',
                    plus: () =>
                        context.read<WeightAgeParameters>().changeAgePlus(),
                    minus: () =>
                        context.read<WeightAgeParameters>().changeAgeMinus(),
                  ),
                ],
              ),
            ),
            const BottomButtons(),
          ]),
    );
  }
}

class GenderButton extends StatelessWidget {
  const GenderButton({
    Key? key,
    required this.title,
    required this.color,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final Color? color;
  final VoidCallback onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onPressed: onTap,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final valueHeight = context.watch<HeightParameters>().height;
    return Column(
      children: [
        const Text(
          'РОСТ',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        RichText(
          text: TextSpan(
            text: valueHeight.toStringAsFixed(0),
            style: const TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700),
            children: const <TextSpan>[
              TextSpan(
                text: ' см',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Slider(
          value: valueHeight,
          activeColor: const Color(0xFFeb1555),
          inactiveColor: Colors.grey,
          min: 50,
          max: 220,
          divisions: 170,
          onChanged: (val) =>
              context.read<HeightParameters>().changeHeight(val),
        ),
      ],
    );
  }
}

class WeightAgeWidget extends StatelessWidget {
  final String title;
  final VoidCallback plus;
  final VoidCallback minus;
  final String data;

  const WeightAgeWidget({
    Key? key,
    required this.title,
    required this.data,
    required this.plus,
    required this.minus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF1d1e33),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                data,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFF4c4f5e),
                    child: IconButton(
                      color: Colors.white,
                      iconSize: 24,
                      onPressed: plus,
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFF4c4f5e),
                    child: IconButton(
                      iconSize: 24,
                      color: Colors.white,
                      onPressed: minus,
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: MaterialButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
              color: const Color(0xFFeb1555),
              textColor: Colors.white,
              onPressed: () {
                if (context.read<GenderParameters>().isActiveMale == false &&
                    context.read<GenderParameters>().isActiveFemale == false) {
                  context.read<GenderParameters>().showMyDialog(context);
                } else {
                  context.read<Result>().res(
                      context,
                      context.read<HeightParameters>().height,
                      context.read<WeightAgeParameters>().weight);
                  FirebaseFirestore.instance.collection('imt').doc().set({
                    'date': date,
                    'imt': context.read<Result>().result,
                    'weight': context.read<WeightAgeParameters>().weight,
                    'height': context.read<HeightParameters>().height
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResultScreen()));
                }
              },
              child: const Center(
                  child: Text(
                'Посчитать',
                style: TextStyle(fontSize: 25),
              )),
            ),
          ),
          Expanded(
            flex: 1,
            child: MaterialButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResultListScreen()));
              },
              child: const Center(
                  child: Text(
                'Журнал',
                style: TextStyle(fontSize: 25),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
