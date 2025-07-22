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
