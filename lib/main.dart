import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder_ai/firebase_options.dart';
import 'package:pathfinder_ai/screens/login_screen.dart';
import 'package:pathfinder_ai/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
