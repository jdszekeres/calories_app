import 'package:calories_app/tools/food_facts.dart';
import 'package:firebase_database/firebase_database.dart';

class MealDatabase {
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

  Future<void> addMeal(String uid, FoodFacts meal) async {
    final ref = database.child('users/$uid/meals');
    await ref.push().set(meal.toJson());
  }

  Future<List<FoodFacts>> getMeals(String uid) async {
    final ref = database.child('users/$uid/meals');
    final val = await ref.once();
    final snapshot = val.snapshot;
    if (snapshot.exists) {
      final mealsData = _convertToMap(snapshot.value);

      return mealsData.keys.map((key) {
        final mealData = _convertToMap(mealsData[key]);
        return FoodFacts.fromJson(mealData);
      }).toList();
    }
    return [];
  }

  Future<List<FoodFacts>> getMealsByDate(String uid, DateTime date) async {
    final ref = database.child('users/$uid/meals');
    final val = await ref.once();
    final snapshot = val.snapshot;
    if (snapshot.exists) {
      final mealsData = _convertToMap(snapshot.value);

      // Normalize the target date to remove time component
      final targetDate = DateTime(date.year, date.month, date.day);

      return mealsData.keys
          .map((key) {
            final mealData = _convertToMap(mealsData[key]);
            if (mealData['uploaded'] != null) {
              final mealDateTime = DateTime.parse(mealData['uploaded']);
              // Normalize the meal date to remove time component
              final mealDate = DateTime(
                mealDateTime.year,
                mealDateTime.month,
                mealDateTime.day,
              );

              // Compare only the date part, ignoring time
              if (mealDate.isAtSameMomentAs(targetDate)) {
                return FoodFacts.fromJson(mealData);
              }
            }
            return null;
          })
          .whereType<FoodFacts>()
          .toList();
    }
    return [];
  }
}
