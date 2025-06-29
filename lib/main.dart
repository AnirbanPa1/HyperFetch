import 'dart:io';

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:yaru/yaru.dart';

void main() async {
  if (Platform.isLinux) {
    await YaruWindowTitleBar.ensureInitialized();
  }
  runApp(const HyperFetchApp());
}

class HyperFetchApp extends StatelessWidget {
  const HyperFetchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HyperFetch',
      debugShowCheckedModeBanner: false,
      theme: Platform.isLinux
          ? yaruLight
          : ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
      darkTheme: Platform.isLinux
          ? yaruDark
          : ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
            ),
      home: const HomeScreen(),
    );
  }
}
