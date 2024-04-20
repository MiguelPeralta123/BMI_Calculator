import 'package:flutter/cupertino.dart';
import 'package:bmi_calculator/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: "BMI Calculator",
      theme: CupertinoThemeData(
        brightness: Brightness.light,
      ),
      home: MainPage(),
    );
  }
}