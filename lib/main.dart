import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/gender_parameters.dart';
import 'models/height_parameters.dart';
import 'models/result.dart';
import 'models/weight_age_parameters.dart';
import 'screens/main_screen.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GenderParameters>(
            create: (_) => GenderParameters()),
        ChangeNotifierProvider<HeightParameters>(
            create: (context) => HeightParameters()),
        ChangeNotifierProvider<WeightAgeParameters>(
            create: (context) => WeightAgeParameters()),
        ChangeNotifierProvider<Result>(
          create: (context) => Result(),
        ),
      ],
      child: const MainScreenWidget(),
    ),
  );
}

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMT',
      debugShowMaterialGrid: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0a0e21),
      ),
      home: const MainScreen(),
    );
  }
}
