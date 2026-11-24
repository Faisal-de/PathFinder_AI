import 'package:flutter/material.dart';
import 'package:pathfinder_ai/data/dummy_data.dart';
import 'package:pathfinder_ai/theme/app_theme.dart';

/// Sample Career Fit scores, skill gaps, and pivot steps. Opened with Navigator.push.
class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Career Fit & Pivot Bridge')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _ScoreBar(label: 'Career Fit', score: careerFitScore),
                  SizedBox(height: 12),
                  _ScoreBar(label: 'Future-Proof', score: futureProofScore),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Skill gaps',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          for (final gap in skillGaps) ...[
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.radio_button_unchecked,
                  color: AppColors.primary,
                ),
                title: Text(gap),
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 8),
          const Text(
            'Pivot bridge',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < pivotBridgeSteps.length; i++) ...[
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFF3EBE7),
                  foregroundColor: AppColors.primary,
                  child: Text('${i + 1}'),
                ),
                title: Text(pivotBridgeSteps[i]),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
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
          child: LinearProgressIndicator(value: score / 100, minHeight: 8),
        ),
      ],
    );
  }
}
