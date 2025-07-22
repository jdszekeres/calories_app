import 'package:firebase_database/firebase_database.dart';
import 'calculate_goals.dart';
import 'user_profile.dart';

class UserDatabase {
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  // Helper method to recursively convert LinkedMaps to Map<String, dynamic>
  Map<String, dynamic> _convertToMap(dynamic data) {
    if (data is Map) {
      return Map<String, dynamic>.from(
        data.map(
          (key, value) => MapEntry(key.toString(), _convertValue(value)),
        ),
      );
    }
    return data as Map<String, dynamic>;
  }

  dynamic _convertValue(dynamic value) {
    if (value is Map) {
      return _convertToMap(value);
    } else if (value is List) {
      return value.map((item) => _convertValue(item)).toList();
    }
    return value;
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    final ref = database.child('users/${profile.uid}/profile');
    await ref.set(profile.toJson());
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    final ref = database.child('users/$uid/profile');
    final val = await ref.once();
    final snapshot = val.snapshot;
    if (snapshot.exists) {
      final profileData = _convertToMap(snapshot.value);
      return UserProfile.fromJson(profileData);
    }
    return null;
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    final ref = database.child('users/${profile.uid}/profile');
    await ref.update(profile.toJson());
  }

  Future<void> saveNutritionGoals(String uid, NutrutionGoals goals) async {
    final ref = database.child('users/$uid/nutrition_goals');
    await ref.set(goals.toJson());
  }

  Future<NutrutionGoals?> getNutritionGoals(String uid) async {
    final ref = database.child('users/$uid/nutrition_goals');
    final val = await ref.once();
    final snapshot = val.snapshot;
    if (snapshot.exists) {
      final goalsData = _convertToMap(snapshot.value);
      return NutrutionGoals.fromJson(goalsData);
    }
    return null;
  }

  Future<void> updateNutritionGoals(String uid, NutrutionGoals goals) async {
    final ref = database.child('users/$uid/nutrition_goals');
    await ref.update(goals.toJson());
  }
}
