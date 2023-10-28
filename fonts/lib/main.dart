import 'package:flutter/material.dart';
import 'package:todo_list/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final Map<String, Color> customColors = {
    'ToDo_BG': const Color(0xffFF8181),
    'ToDo_Font': const Color(0xffD0F4A4),
    'ToSchedule_BG': const Color(0xffFCE38A),
    'ToSchedule_Font': const Color(0xff6677bb),
    'ToDelegate_BG': const Color(0xffEAFFD0),
    'ToDelegate_Font': const Color(0xffD297F3),
    'ToDelete_BG': const Color(0xff95E1D3),
    'ToDelete_Font': const Color(0xffE27C7F),
  };

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
