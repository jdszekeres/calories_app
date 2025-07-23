import 'package:calories_app/tools/food_facts.dart';
import 'package:calories_app/tools/meal_database.dart';
import 'package:calories_app/widgets/nutri_facts.dart';
import 'package:flutter/material.dart';

import '../auth.dart';

class MealDetails extends StatefulWidget {
  final FoodFacts foodFacts;
  const MealDetails({Key? key, required this.foodFacts}) : super(key: key);
  @override
  _MealDetailsState createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  final Auth auth = Auth();
  late FoodFacts foodFacts;

  @override
  void initState() {
    super.initState();
    foodFacts = widget.foodFacts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meal Details')),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (foodFacts.image != null && foodFacts.image!.isNotEmpty)
              Image.network(foodFacts.image!, height: 200, fit: BoxFit.cover),
            NutriFacts(
              foodFacts: foodFacts,
              servings: foodFacts.numServings ?? 1,
              onEdit: (newFoodFacts) {
                setState(() {
                  foodFacts = newFoodFacts;
                });
                MealDatabase().updateMeal(
                  auth.currentUser!.uid,
                  foodFacts.uploaded!,
                  newFoodFacts,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
