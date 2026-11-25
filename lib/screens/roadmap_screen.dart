import 'package:flutter/material.dart';
import 'package:pathfinder_ai/data/dummy_data.dart';
import 'package:pathfinder_ai/services/user_data_service.dart';
import 'package:pathfinder_ai/theme/app_theme.dart';

/// Roadmap tab. [_done] is one checkbox per phase, based on saved phase ids.
class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key, required this.completedPhaseIds});

  final List<String> completedPhaseIds;

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  late final List<bool> _done;

  @override
  void initState() {
    super.initState();
    _done = [
      for (final phase in roadmapPhases)
        widget.completedPhaseIds.contains(phase.id),
    ];
  }

  Future<void> _toggle(int index, bool value) async {
    setState(() => _done[index] = value);
    final ids = [
      for (var i = 0; i < roadmapPhases.length; i++)
        if (_done[i]) roadmapPhases[i].id,
    ];
    final error = await UserDataService.saveCompletedPhaseIds(ids);
    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

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
              onChanged: (value) => _toggle(i, value ?? false),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
