import 'package:firebase_database/firebase_database.dart';

class AiCreditManager {
  Future<double> getCredits(String userId) async {
    final DatabaseReference database = FirebaseDatabase.instance.ref();
    final ref = database.child('users/$userId/ai_credits');
    final snapshot = await ref.once();
    return double.tryParse(snapshot.snapshot.value.toString()) ??
        10.0; // give 10 credits to start
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
      await ref.set(currentCredits - credits);
    } else {
      throw Exception('Not enough AI credits');
    }
  }
}
