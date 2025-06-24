import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const HyperFetchApp());
}

class HyperFetchApp extends StatelessWidget {
  const HyperFetchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HyperFetch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
