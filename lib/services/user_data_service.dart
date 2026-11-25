import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pathfinder_ai/data/dummy_data.dart';
import 'package:pathfinder_ai/services/auth_service.dart';

/// Career goal, scores, and completed roadmap phases for one signed-in user.
class UserRecord {
  const UserRecord({
    required this.careerGoal,
    required this.careerFit,
    required this.futureProof,
    required this.completedPhaseIds,
  });

  final String careerGoal;
  final int careerFit;
  final int futureProof;
  final List<String> completedPhaseIds;
}

/// Reads and writes the signed-in user's document at `users/{uid}`.
class UserDataService {
  static const _saveError = 'Could not save. Try again.';

  /// Null when nobody is signed in, so callers can fall back to sample data.
  static DocumentReference<Map<String, dynamic>>? get _doc {
    final uid = AuthService.currentUser?.uid;
    if (uid == null) return null;
    return FirebaseFirestore.instance.collection('users').doc(uid);
  }

  static UserRecord get _sample => const UserRecord(
    careerGoal: starterCareerGoal,
    careerFit: careerFitScore,
    futureProof: futureProofScore,
    completedPhaseIds: [],
  );

  /// Loads `users/{uid}`. Creates it with sample defaults when it is missing.
  static Future<UserRecord> loadUser() async {
    final doc = _doc;
    if (doc == null) return _sample;

    try {
      final snap = await doc.get();
      final data = snap.data();
      if (!snap.exists || data == null) {
        final created = _sample;
        await doc.set(_toMap(created));
        return created;
      }
      final goal = data['careerGoal'];
      return UserRecord(
        careerGoal: goal is String && goal.isNotEmpty ? goal : starterCareerGoal,
        careerFit: _asInt(data['careerFit'], careerFitScore),
        futureProof: _asInt(data['futureProof'], futureProofScore),
        completedPhaseIds: _asIds(data['completedPhaseIds']),
      );
    } catch (_) {
      return _sample;
    }
  }

  /// Returns null on success, or a short message the screen can show.
  static Future<String?> saveCareerGoal(String goal) {
    return _save({'careerGoal': goal});
  }

  /// Stores the Career Fit and Future-Proof scores from the assessment.
  static Future<String?> saveScores({
    required int careerFit,
    required int futureProof,
  }) {
    return _save({'careerFit': careerFit, 'futureProof': futureProof});
  }

  /// Stores the ids of the roadmap phases the user has checked.
  static Future<String?> saveCompletedPhaseIds(List<String> ids) {
    return _save({'completedPhaseIds': ids});
  }

  static Future<String?> _save(Map<String, Object> fields) async {
    final doc = _doc;
    if (doc == null) return _saveError;
    try {
      await doc.set(fields, SetOptions(merge: true));
      return null;
    } catch (_) {
      return _saveError;
    }
  }

  static Map<String, Object> _toMap(UserRecord user) {
    return {
      'careerGoal': user.careerGoal,
      'careerFit': user.careerFit,
      'futureProof': user.futureProof,
      'completedPhaseIds': user.completedPhaseIds,
    };
  }

  static int _asInt(Object? value, int fallback) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return fallback;
  }

  static List<String> _asIds(Object? value) {
    if (value is! List) return const [];
    return [for (final item in value) if (item is String) item];
  }
}
