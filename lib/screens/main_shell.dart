import 'package:flutter/material.dart';
import 'package:pathfinder_ai/data/dummy_data.dart';
import 'package:pathfinder_ai/screens/assessment_screen.dart';
import 'package:pathfinder_ai/screens/home_screen.dart';
import 'package:pathfinder_ai/screens/profile_screen.dart';
import 'package:pathfinder_ai/screens/roadmap_screen.dart';
import 'package:pathfinder_ai/theme/app_theme.dart';

/// Holds the four tabs. [_index] is the selected tab. [_goal] is shared
/// because Home displays it and Profile edits it.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  String _goal = starterCareerGoal;

  static const _titles = ['PathFinder AI', 'Assessment', 'Roadmap', 'Profile'];

  void _openTab(int index) {
    setState(() => _index = index);
  }

  void _saveGoal(String goal) {
    setState(() => _goal = goal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index])),
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(goal: _goal, onOpenTab: _openTab),
          const AssessmentScreen(),
          const RoadmapScreen(),
          ProfileScreen(goal: _goal, onGoalSaved: _saveGoal),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: _openTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined),
              activeIcon: Icon(Icons.fact_check),
              label: 'Assessment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.route_outlined),
              activeIcon: Icon(Icons.route),
              label: 'Roadmap',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
