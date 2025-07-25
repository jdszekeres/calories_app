import 'package:calories_app/tools/calculate_goals.dart';

class UserProfile {
  final String uid;
  final String email;
  final String username;
  final int age;
  final double weight; // in kg
  final double height; // in cm
  final ActivityLevel activityLevel; // Enum for activity level
  final String sex; // 'male' or 'female'

  UserProfile({
    required this.uid,
    required this.email,
    required this.username,
    required this.age,
    required this.weight,
    required this.height,
    required this.activityLevel,
    required this.sex,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'age': age,
      'weight': weight,
      'height': height,
      'activityLevel': activityLevel
          .toString()
          .split('.')
          .last, // Convert enum to string
      'sex': sex,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'],
      email: json['email'],
      username: json['username'],
      age: json['age'],
      weight: json['weight'].toDouble(),
      height: json['height'].toDouble(),
      activityLevel: ActivityLevel.values.firstWhere(
        (e) => e.toString().split('.').last == json['activityLevel'],
      ),
      sex: json['sex'],
    );
  }
}
