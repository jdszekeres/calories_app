import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'tools/calculate_goals.dart';
import 'tools/user_profile.dart';
import 'tools/user_database.dart';

class Auth {
  static final Auth _instance = Auth._internal();
  factory Auth() => _instance;
  Auth._internal();

  bool get isInitialized => Firebase.apps.isNotEmpty;

  static String prettyPrintError(Object error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'network-request-failed':
          return 'Network error occurred. Please check your connection.';
        case 'user-not-found':
          return 'No user found for the provided email.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'weak-password':
          return 'The password is too weak. Please choose a stronger password.';
        case 'operation-not-allowed':
          return 'This operation is not allowed. Please contact support.';
        case 'too-many-requests':
          return 'Too many requests. Please try again later.';
        case 'user-disabled':
          return 'The user account has been disabled. Please contact support.';
        case 'invalid-credential':
          return 'The provided credential is invalid. Please check your input.';
        case 'requires-recent-login':
          return 'This operation requires recent authentication. Please log in again.';
        case 'unknown':
          return 'An unknown error occurred. Please try again later.';
        case 'invalid-verification-code':
          return 'The verification code is invalid. Please check and try again.';
        default:
          return error.message ?? 'An unknown error occurred.';
      }
    }
    return error.toString();
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (!isInitialized) {
      throw Exception('Firebase is not initialized');
    }
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  Future<void> signUpWithEmailAndPassword(
    String email,
    String username,
    String password,
    int age,
    double weight,
    double height,
    ActivityLevel activityLevel,
    String sex,
  ) async {
    if (!isInitialized) {
      throw Exception('Firebase is not initialized');
    }
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await credential.user?.updateDisplayName(username);
    await credential.user?.reload();

    // Save additional user profile information
    if (credential.user != null) {
      final userProfile = UserProfile(
        uid: credential.user!.uid,
        email: email,
        username: username,
        age: age,
        weight: weight,
        height: height,
        activityLevel: activityLevel,
        sex: sex,
      );
      await UserDatabase().saveUserProfile(userProfile);
      await UserDatabase().saveNutritionGoals(
        credential.user!.uid,
        calculateGoals(age, weight, height, activityLevel, sex == 'male'),
      );
    }
  }

  Future<void> signInAnonymously(
    int age,
    double weight,
    double height,
    ActivityLevel activityLevel,
    String sex,
  ) async {
    if (!isInitialized) {
      throw Exception('Firebase is not initialized');
    }
    UserCredential credential = await FirebaseAuth.instance.signInAnonymously();
    // Save anonymous user profile information
    final userProfile = UserProfile(
      uid: credential.user!.uid,
      email: '',
      username: '',
      age: age,
      weight: weight,
      height: height,
      activityLevel: activityLevel,
      sex: sex,
    );
    await UserDatabase().saveUserProfile(userProfile);
    await UserDatabase().saveNutritionGoals(
      credential.user!.uid,
      calculateGoals(age, weight, height, activityLevel, sex == 'male'),
    );
  }

  Future<void> convertAnonymousToEmail(
    String username,
    String email,
    String password,
  ) async {
    if (!isInitialized) {
      throw Exception('Firebase is not initialized');
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || !user.isAnonymous) {
      throw Exception('No anonymous user to convert');
    }
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await user.linkWithCredential(credential);
    await user.updateDisplayName(username);
    await user.reload();
  }

  Future<void> signOut() async {
    if (!isInitialized) {
      throw Exception('Firebase is not initialized');
    }
    await FirebaseAuth.instance.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    if (!isInitialized) {
      throw Exception('Firebase is not initialized');
    }
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  User? get currentUser {
    if (!isInitialized) {
      debugPrint('Firebase is not initialized');
      return null;
    }
    return FirebaseAuth.instance.currentUser;
  }

  bool get isLoggedIn => currentUser != null;

  String? get currentUserEmail => currentUser?.email;
  String? get currentUsername => currentUser?.displayName;
  String? get currentUserId => currentUser?.uid;

  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  // Get user profile information
  Future<UserProfile?> getCurrentUserProfile() async {
    final user = currentUser;
    if (user != null) {
      return await UserDatabase().getUserProfile(user.uid);
    }
    return null;
  }
}
