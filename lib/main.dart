import 'package:flutter/material.dart';
import 'package:pathfinder_ai/screens/login_screen.dart';
import 'package:pathfinder_ai/theme/app_theme.dart';

void main() {
  runApp(const PathFinderApp());
}

/// App root. Login is the first screen. After login, MainShell shows the tabs.
class PathFinderApp extends StatelessWidget {
  const PathFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PathFinder AI',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const LoginScreen(),
    );
  }
}
