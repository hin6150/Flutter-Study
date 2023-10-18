import 'package:flutter/material.dart';
import 'package:stateful_widgets/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme:
            const TextTheme(displayLarge: TextStyle(color: Color(0xFF232B55))),
        colorScheme:
            ColorScheme.fromSwatch(backgroundColor: const Color(0xFFE7626C)),
      ),
      home: const HomeScreen(),
    );
  }
}
