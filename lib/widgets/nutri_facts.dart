import 'package:calories_app/tools/food_facts.dart';
import 'package:flutter/material.dart';

class NutriFacts extends StatelessWidget {
  final FoodFacts foodFacts;
  final double servings;

  const NutriFacts({
    super.key,
    required this.foodFacts,
    required this.servings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product name
          Center(
            child: Text(
              foodFacts.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),

          // Nutrition Facts Header
          const Text(
            'Nutrition Facts',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Divider(color: Colors.black, thickness: 2),

          // Serving size
          Text(
            'Serving size ${foodFacts.servingSize}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text('You ate ${servings.toStringAsFixed(1)} servings'),
          const Divider(color: Colors.black, thickness: 4),

          // Calories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Calories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                (foodFacts.nutrutionInfo.calorieGoal * servings)
                    .toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.black, thickness: 2),

          // Daily Value header
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Your Intake',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Divider(color: Colors.black, thickness: 1),

          // Macronutrients
          _buildNutrientRow(
            'Total Fat',
            '${(foodFacts.nutrutionInfo.macroNutrientGoals.fat * servings).toStringAsFixed(1)}g',
            '',
          ),
          _buildNutrientRow(
            'Total Carbohydrate',
            '${(foodFacts.nutrutionInfo.macroNutrientGoals.carbohydrates * servings).toStringAsFixed(1)}g',
            '',
          ),
          _buildIndentedNutrientRow(
            'Dietary Fiber',
            '${(foodFacts.nutrutionInfo.macroNutrientGoals.fiber * servings).toStringAsFixed(1)}g',
            '',
          ),
          _buildIndentedNutrientRow(
            'Total Sugars',
            '${(foodFacts.nutrutionInfo.macroNutrientGoals.sugar * servings).toStringAsFixed(1)}g',
            '',
          ),
          _buildNutrientRow(
            'Protein',
            '${(foodFacts.nutrutionInfo.macroNutrientGoals.protein * servings).toStringAsFixed(1)}g',
            '',
          ),

          const Divider(color: Colors.black, thickness: 2),

          // Vitamins and minerals (only show if values > 0)
          // Vitamins
          if (foodFacts.nutrutionInfo.vitaminGoals.vitaminA > 0)
            _buildNutrientRow(
              'Vitamin A',
              '${((foodFacts.nutrutionInfo.vitaminGoals.vitaminA * servings) / 1000000).toStringAsFixed(1)}µg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.vitaminC > 0)
            _buildNutrientRow(
              'Vitamin C',
              '${((foodFacts.nutrutionInfo.vitaminGoals.vitaminC * servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.vitaminD > 0)
            _buildNutrientRow(
              'Vitamin D',
              '${((foodFacts.nutrutionInfo.vitaminGoals.vitaminD * servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.vitaminE > 0)
            _buildNutrientRow(
              'Vitamin E',
              '${((foodFacts.nutrutionInfo.vitaminGoals.vitaminE * servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.vitaminK > 0)
            _buildNutrientRow(
              'Vitamin K',
              '${((foodFacts.nutrutionInfo.vitaminGoals.vitaminK * servings) / 1000000).toStringAsFixed(1)}µg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.thiamin > 0)
            _buildNutrientRow(
              'Thiamin (B1)',
              '${((foodFacts.nutrutionInfo.vitaminGoals.thiamin * servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.riboflavin > 0)
            _buildNutrientRow(
              'Riboflavin (B2)',
              '${((foodFacts.nutrutionInfo.vitaminGoals.riboflavin * servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.niacin > 0)
            _buildNutrientRow(
              'Niacin (B3)',
              '${((foodFacts.nutrutionInfo.vitaminGoals.niacin * servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.pantothenicAcid > 0)
            _buildNutrientRow(
              'Pantothenic Acid (B5)',
              '${((foodFacts.nutrutionInfo.vitaminGoals.pantothenicAcid * servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.vitaminB6 > 0)
            _buildNutrientRow(
              'Vitamin B6',
              '${((foodFacts.nutrutionInfo.vitaminGoals.vitaminB6 * servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.folate > 0)
            _buildNutrientRow(
              'Folate',
              '${((foodFacts.nutrutionInfo.vitaminGoals.folate * servings) / 1000000).toStringAsFixed(1)}µg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.vitaminB12 > 0)
            _buildNutrientRow(
              'Vitamin B12',
              '${((foodFacts.nutrutionInfo.vitaminGoals.vitaminB12 * servings) / 1000000).toStringAsFixed(1)}µg',
              '',
            ),
          if (foodFacts.nutrutionInfo.vitaminGoals.choline > 0)
            _buildNutrientRow(
              'Choline',
              '${((foodFacts.nutrutionInfo.vitaminGoals.choline * servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),

          // Minerals
          if (foodFacts.nutrutionInfo.microNutrientGoals.calcium > 0)
            _buildNutrientRow(
              'Calcium',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.calcium * servings).toStringAsFixed(0)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.iron > 0)
            _buildNutrientRow(
              'Iron',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.iron * servings).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.magnesium > 0)
            _buildNutrientRow(
              'Magnesium',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.magnesium * servings).toStringAsFixed(0)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.phosphorus > 0)
            _buildNutrientRow(
              'Phosphorus',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.phosphorus * servings).toStringAsFixed(0)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.potassium > 0)
            _buildNutrientRow(
              'Potassium',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.potassium * servings).toStringAsFixed(0)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.sodium > 0)
            _buildNutrientRow(
              'Sodium',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.sodium * servings).toStringAsFixed(0)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.zinc > 0)
            _buildNutrientRow(
              'Zinc',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.zinc * servings).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.copper > 0)
            _buildNutrientRow(
              'Copper',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.copper * servings).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.manganese > 0)
            _buildNutrientRow(
              'Manganese',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.manganese * servings).toStringAsFixed(1)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.selenium > 0)
            _buildNutrientRow(
              'Selenium',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.selenium * servings).toStringAsFixed(1)}µg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.iodine > 0)
            _buildNutrientRow(
              'Iodine',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.iodine * servings).toStringAsFixed(1)}µg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.molybdenum > 0)
            _buildNutrientRow(
              'Molybdenum',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.molybdenum * servings).toStringAsFixed(1)}µg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.chlorine > 0)
            _buildNutrientRow(
              'Chloride',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.chlorine * servings).toStringAsFixed(0)}mg',
              '',
            ),
          if (foodFacts.nutrutionInfo.microNutrientGoals.flouride > 0)
            _buildNutrientRow(
              'Fluoride',
              '${(foodFacts.nutrutionInfo.microNutrientGoals.flouride * servings).toStringAsFixed(1)}mg',
              '',
            ),

          const Divider(color: Colors.black, thickness: 2),

          // Ingredients section
          if (foodFacts.ingredients.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text(
              'INGREDIENTS:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              foodFacts.ingredients.join(', ').toUpperCase(),
              style: const TextStyle(fontSize: 11, color: Colors.black),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNutrientRow(String nutrient, String amount, String dailyValue) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                nutrient,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            if (dailyValue.isNotEmpty)
              SizedBox(
                width: 40,
                child: Text(
                  dailyValue,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
          ],
        ),
        const Divider(color: Colors.black, thickness: 1),
      ],
    );
  }

  Widget _buildIndentedNutrientRow(
    String nutrient,
    String amount,
    String dailyValue,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  nutrient,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
            Text(
              amount,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            if (dailyValue.isNotEmpty)
              SizedBox(
                width: 40,
                child: Text(
                  dailyValue,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  textAlign: TextAlign.right,
                ),
              ),
          ],
        ),
        const Divider(color: Colors.black, thickness: 1),
      ],
    );
  }
}
