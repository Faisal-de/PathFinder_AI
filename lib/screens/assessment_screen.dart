import 'package:flutter/material.dart';
import 'package:pathfinder_ai/data/dummy_data.dart';
import 'package:pathfinder_ai/screens/results_screen.dart';
import 'package:pathfinder_ai/services/user_data_service.dart';
import 'package:pathfinder_ai/theme/app_theme.dart';

/// Assessment tab. [_step] is the current question. [_answers] stores
/// the selected option index for each question.
class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key, required this.onScoresSaved});

  /// Called after scores are stored so Home can reload them.
  final Future<void> Function() onScoresSaved;

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _step = 0;
  late final List<int?> _answers = List<int?>.filled(
    assessmentQuestions.length,
    null,
  );

  Future<void> _openResults() async {
    final error = await UserDataService.saveScores(
      careerFit: careerFitScore,
      futureProof: futureProofScore,
    );
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    await widget.onScoresSaved();
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ResultsScreen(
          careerFit: careerFitScore,
          futureProof: futureProofScore,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = assessmentQuestions[_step];
    final lastStep = _step == assessmentQuestions.length - 1;
    final progress = (_step + 1) / assessmentQuestions.length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      children: [
        Text(
          'Question ${_step + 1} of ${assessmentQuestions.length}',
          style: const TextStyle(color: AppColors.accent),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(value: progress, minHeight: 8),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.prompt,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                for (var i = 0; i < question.options.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _OptionTile(
                      label: question.options[i],
                      selected: _answers[_step] == i,
                      onTap: () => setState(() => _answers[_step] = i),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (_step > 0) ...[
          OutlinedButton(
            onPressed: () => setState(() => _step -= 1),
            child: const Text('Back'),
          ),
          const SizedBox(height: 8),
        ],
        if (!lastStep)
          ElevatedButton(
            onPressed: () => setState(() => _step += 1),
            child: const Text('Next'),
          ),
        if (lastStep)
          ElevatedButton(
            onPressed: _openResults,
            child: const Text('View Career Fit & Pivot Bridge'),
          ),
      ],
    );
  }
}

/// One tappable answer. [selected] changes the border and fill.
class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFFF3EBE7) : AppColors.card,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}
