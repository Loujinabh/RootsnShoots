import 'package:flutter/material.dart';
import 'package:plant_diary/Views/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Diary',
      theme: ThemeData(
        fontFamily: 'quick',
      ),
      home: Login(),
    );
  }
}
