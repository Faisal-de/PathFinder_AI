import 'package:flutter/material.dart';
import 'package:pathfinder_ai/data/dummy_data.dart';
import 'package:pathfinder_ai/screens/assessment_screen.dart';
import 'package:pathfinder_ai/screens/home_screen.dart';
import 'package:pathfinder_ai/screens/profile_screen.dart';
import 'package:pathfinder_ai/screens/roadmap_screen.dart';
import 'package:pathfinder_ai/services/user_data_service.dart';
import 'package:pathfinder_ai/theme/app_theme.dart';

/// Holds the four tabs. [_goal] is shared because Home shows it and Profile edits it.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  bool _loading = true;
  String _goal = starterCareerGoal;
  int _careerFit = careerFitScore;
  int _futureProof = futureProofScore;
  List<String> _completedPhaseIds = const [];

  static const _titles = ['PathFinder AI', 'Assessment', 'Roadmap', 'Profile'];

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  /// Reads the signed-in user's Firestore document once, before the tabs appear.
  Future<void> _loadUser() async {
    final user = await UserDataService.loadUser();
    if (!mounted) return;
    setState(() {
      _goal = user.careerGoal;
      _careerFit = user.careerFit;
      _futureProof = user.futureProof;
      _completedPhaseIds = user.completedPhaseIds;
      _loading = false;
    });
  }

  /// Reloads scores after the assessment saves them, so the Home bars update.
  Future<void> _reloadScores() async {
    final user = await UserDataService.loadUser();
    if (!mounted) return;
    setState(() {
      _careerFit = user.careerFit;
      _futureProof = user.futureProof;
    });
  }

  void _openTab(int index) {
    setState(() => _index = index);
  }

  Future<String?> _saveGoal(String goal) async {
    final error = await UserDataService.saveCareerGoal(goal);
    if (error == null && mounted) {
      setState(() => _goal = goal);
    }
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index])),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : IndexedStack(
              index: _index,
              children: [
                HomeScreen(
                  goal: _goal,
                  careerFit: _careerFit,
                  futureProof: _futureProof,
                  onOpenTab: _openTab,
                ),
                AssessmentScreen(onScoresSaved: _reloadScores),
                RoadmapScreen(completedPhaseIds: _completedPhaseIds),
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
