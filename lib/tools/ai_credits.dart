import 'package:firebase_database/firebase_database.dart';

class AiCreditManager {
  Future<double> getCredits(String userId) async {
    try {
      final DatabaseReference database = FirebaseDatabase.instance.ref();
      final ref = database.child('users/$userId/ai_credits');

      final snapshot = await ref.once();

      if (!snapshot.snapshot.exists || snapshot.snapshot.value == null) {
        // Set default credits in database for first-time users
        await ref.set(10.0);
        return 10.0;
      }

      final value = snapshot.snapshot.value;
      final credits = double.tryParse(value.toString()) ?? 10.0;
      return credits;
    } catch (e) {
      return 10.0;
    }
  }

  Future<double> addCredits(String userId, double credits) async {
    final DatabaseReference database = FirebaseDatabase.instance.ref();
    final ref = database.child('users/$userId/ai_credits');
    final currentCredits = await getCredits(userId);
    await ref.set(currentCredits + credits);
    return currentCredits + credits;
  }

  Future<void> deductCredits(String userId, double credits) async {
    final DatabaseReference database = FirebaseDatabase.instance.ref();
    final ref = database.child('users/$userId/ai_credits');
    final currentCredits = await getCredits(userId);

    if (currentCredits >= credits) {
      final newCredits = currentCredits - credits;
      await ref.set(newCredits);
    } else {
      print(
        'Insufficient credits. Current: $currentCredits, Required: $credits',
      );
      throw Exception('Not enough AI credits');
    }
  }
}
