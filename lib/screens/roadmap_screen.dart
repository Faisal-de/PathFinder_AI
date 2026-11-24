import 'package:flutter/material.dart';
import 'package:pathfinder_ai/data/dummy_data.dart';
import 'package:pathfinder_ai/theme/app_theme.dart';

/// Roadmap tab. [_done] is one checkbox per phase. The first phase starts done.
class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  late final List<bool> _done = [
    for (var i = 0; i < roadmapPhases.length; i++) i == 0,
  ];

  @override
  Widget build(BuildContext context) {
    final doneCount = _done.where((done) => done).length;
    final progress = doneCount / roadmapPhases.length;

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
                  '$doneCount of ${roadmapPhases.length} complete',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(value: progress, minHeight: 8),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < roadmapPhases.length; i++) ...[
          Card(
            child: CheckboxListTile(
              value: _done[i],
              activeColor: AppColors.primary,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(roadmapPhases[i].title),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(roadmapPhases[i].detail),
              ),
              onChanged: (value) {
                setState(() => _done[i] = value ?? false);
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
