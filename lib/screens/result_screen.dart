import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/result.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResultWidget(),
    );
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'Ваш результат:',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF1d1e33),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Center(
                        child: Text(
                          context.watch<Result>().textTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              color: context.watch<Result>().titleColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 60, left: 20, right: 16),
                      child: Center(
                        child: Text(
                          context.watch<Result>().result.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 100,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 60, bottom: 80, left: 16, right: 16),
                      child: Center(
                        child: Text(
                          context.watch<Result>().textDecription,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const CalculateButton()
          ],
        ),
      ),
    );
  }
}

class CalculateButton extends StatelessWidget {
  const CalculateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: MaterialButton(
          color: const Color(0xFFeb1555),
          textColor: Colors.white,
          onPressed: () => Navigator.pop(context),
          child: const SizedBox(
            width: double.infinity,
            height: 60,
            child: Center(
                child: Text(
              'Пересчитать',
              style: TextStyle(fontSize: 25),
            )),
          ),
        ),
      ),
    );
  }
}
