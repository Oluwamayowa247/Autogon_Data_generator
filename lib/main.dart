import 'package:dataset_generator/screens/data_generator_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    AutogonDataGenerator(),
  );
}

class AutogonDataGenerator extends StatelessWidget {
  const AutogonDataGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataGeneratorHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
