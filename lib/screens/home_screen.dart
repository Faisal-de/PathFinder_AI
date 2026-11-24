import 'package:flutter/material.dart';
import 'package:pathfinder_ai/data/dummy_data.dart';
import 'package:pathfinder_ai/screens/results_screen.dart';
import 'package:pathfinder_ai/theme/app_theme.dart';

/// Home tab. [goal] comes from MainShell. [onOpenTab] switches the bottom bar.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.goal, required this.onOpenTab});

  final String goal;
  final ValueChanged<int> onOpenTab;

  void _openResults(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ResultsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final goalText = goal.isEmpty ? 'No career goal yet.' : goal;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${DummyUser.name}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Your career plan is ready to explore.',
                  style: TextStyle(color: AppColors.accent),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current goal',
                  style: TextStyle(color: AppColors.accent, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  goalText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                const _ScoreBar(label: 'Career Fit', score: careerFitScore),
                const SizedBox(height: 12),
                const _ScoreBar(
                  label: 'Future-Proof',
                  score: futureProofScore,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Quick actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        _ActionTile(
          icon: Icons.fact_check_outlined,
          title: 'Career Assessment',
          subtitle: 'Answer a few sample questions',
          onTap: () => onOpenTab(1),
        ),
        const SizedBox(height: 8),
        _ActionTile(
          icon: Icons.swap_horiz,
          title: 'Skill Gap / Pivot Bridge',
          subtitle: 'See sample gaps and next steps',
          onTap: () => _openResults(context),
        ),
        const SizedBox(height: 8),
        _ActionTile(
          icon: Icons.route_outlined,
          title: 'Roadmap',
          subtitle: 'Check off career phases',
          onTap: () => onOpenTab(2),
        ),
      ],
    );
  }
}

/// Label plus a rounded progress bar. [score] is a percent from 0 to 100.
class _ScoreBar extends StatelessWidget {
  const _ScoreBar({required this.label, required this.score});

  final String label;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text('$score', style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: score / 100,
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right, color: AppColors.accent),
        onTap: onTap,
      ),
    );
  }
}
