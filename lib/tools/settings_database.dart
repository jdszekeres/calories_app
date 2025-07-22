import 'package:firebase_database/firebase_database.dart';

class SettingsDatabase {
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  Future<void> saveSettings(
    String userId,
    Map<String, dynamic> settings,
  ) async {
    // Save user settings to the database
    final ref = database.child('users/$userId/settings');
    await ref.set(settings);
  }

  Future<Map<String, dynamic>?> getSettings(String userId) async {
    // Retrieve user settings from the database
    final ref = database.child('users/$userId/settings');
    final val = await ref.once();
    final snapshot = val.snapshot;
    if (snapshot.exists) {
      final settingsData = _convertToMap(snapshot.value);
      return settingsData;
    }
    return null;
  }

  Future<void> updateSetting(String userId, String key, dynamic value) async {
    // Update a specific setting for the user
    final settings = await getSettings(userId);
    if (settings != null) {
      settings[key] = value;
      await saveSettings(userId, settings);
    }
  }

  Future<dynamic> getSetting(String userId, String key) async {
    // Retrieve a specific setting for the user
    final settings = await getSettings(userId);
    return settings?[key];
  }

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
}
