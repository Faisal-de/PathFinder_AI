import 'package:flutter/material.dart';
import 'package:pathfinder_ai/data/dummy_data.dart';
import 'package:pathfinder_ai/screens/login_screen.dart';
import 'package:pathfinder_ai/services/auth_service.dart';
import 'package:pathfinder_ai/theme/app_theme.dart';

/// Profile tab. [onGoalSaved] sends the new goal up to MainShell.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.goal,
    required this.onGoalSaved,
  });

  final String goal;
  final Future<String?> Function(String goal) onGoalSaved;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _goalController;

  /// Tags the user has tapped on. Starts with one sample selection.
  final Set<String> _selectedTags = {'Mobile apps'};

  @override
  void initState() {
    super.initState();
    _goalController = TextEditingController(text: widget.goal);
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final error = await widget.onGoalSaved(_goalController.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error ?? 'Career goal saved.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: error == null ? AppColors.primary : AppColors.error,
      ),
    );
  }

  Future<void> _logout() async {
    await AuthService.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      children: [
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DummyUser.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Text(DummyUser.email),
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
                  'Career goal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _goalController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Example: Close one skill gap and follow the roadmap',
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(onPressed: _save, child: const Text('Save')),
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
                  'Preferences',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final tag in preferenceTags)
                      FilterChip(
                        label: Text(tag),
                        selected: _selectedTags.contains(tag),
                        showCheckmark: true,
                        checkmarkColor: AppColors.primary,
                        selectedColor: const Color(0xFFF3EBE7),
                        labelStyle: const TextStyle(color: AppColors.text),
                        side: BorderSide(
                          color: _selectedTags.contains(tag)
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedTags.add(tag);
                            } else {
                              _selectedTags.remove(tag);
                            }
                          });
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(onPressed: _logout, child: const Text('Logout')),
      ],
    );
  }
}
