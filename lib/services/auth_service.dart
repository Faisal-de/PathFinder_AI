import 'package:firebase_auth/firebase_auth.dart';

/// Email and password auth through Firebase Auth.
class AuthService {
  /// The signed-in Firebase user, or null on the login screen.
  static User? get currentUser => FirebaseAuth.instance.currentUser;

  /// Returns null on success, or a short message for the login banner.
  static Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (error) {
      return _message(error);
    } catch (_) {
      return 'Something went wrong. Try again.';
    }
  }

  /// Returns null on success, or a short message for the login banner.
  static Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (error) {
      return _message(error);
    } catch (_) {
      return 'Something went wrong. Try again.';
    }
  }

  /// Ends the Firebase session. The profile screen then returns to login.
  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {
      // The screen still leaves the shell if sign-out fails.
    }
  }

  static String _message(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'Enter a valid email address.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Could not sign in. Check your email and password.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return 'Something went wrong. Try again.';
    }
  }
}
