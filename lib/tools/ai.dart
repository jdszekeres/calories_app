import 'dart:convert';
import 'dart:io';

import 'package:calories_app/tools/calculate_goals.dart';
import 'package:calories_app/tools/food_facts.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';

// create schema based on nutrition facts class
final jsonSchema = Schema.object(
  properties: {
    'info': Schema.object(
      properties: {
        'name': Schema.string(),
        'servingSize': Schema.number(),
        'servingCount': Schema.string(),
      },
    ),
    'ingredients': Schema.array(items: Schema.string()),
    'calorieGoals': Schema.object(properties: {'calories': Schema.number()}),
    'macroNutrientGoals': Schema.object(
      properties: {
        'carbohydrates': Schema.number(),
        'fiber': Schema.number(),
        'protein': Schema.number(),
        'fat': Schema.number(),
        'sugar': Schema.number(),
        'water': Schema.number(),
      },
    ),
    'vitaminGoals': Schema.object(
      properties: {
        'vitaminA': Schema.number(),
        'vitaminD': Schema.number(),
        'vitaminE': Schema.number(),
        'vitaminK': Schema.number(),
        'vitaminC': Schema.number(),
        'thiamin': Schema.number(),
        'riboflavin': Schema.number(),
        'niacin': Schema.number(),
        'pantothenicAcid': Schema.number(),
        'vitaminB6': Schema.number(),
        'folate': Schema.number(),
        'vitaminB12': Schema.number(),
        'choline': Schema.number(),
      },
    ),
    'microNutrientGoals': Schema.object(
      properties: {
        'calcium': Schema.number(),
        'chlorine': Schema.number(),
        'copper': Schema.number(),
        'flouride': Schema.number(),
        'iodine': Schema.number(),
        'iron': Schema.number(),
        'magnesium': Schema.number(),
        'manganese': Schema.number(),
        'molybdenum': Schema.number(),
        'phosphorus': Schema.number(),
        'potassium': Schema.number(),
        'selenium': Schema.number(),
        'sodium': Schema.number(),
        'zinc': Schema.number(),
      },
    ),
  },
);

class AiService {
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.0-flash-lite-001',
    generationConfig: GenerationConfig(
      responseSchema: jsonSchema,
      responseMimeType: 'application/json',
    ),
  );
  late final String units;
  AiService() {
    units = NutrutionGoals.keys.fold("", (previousValue, element) {
      return "$previousValue$element:${NutrutionGoals.getUnit(element)},";
    });
  }

  Future<FoodFacts?> getMealNutrition(Uint8List image) async {
    try {
      final imagePart = InlineDataPart('image/jpeg', image);
      final prompt = TextPart(
        'You are a nutrition expert. Analyze the meal in the image and provide the nutrition facts in JSON format.',
      );
      final textHint = TextPart(
        "Return each nutrient with its correct unit. $units. Include unit in serving size i.e. '1 burger' or '100g'.",
      );
      final response = await model.generateContent([
        Content.multi([prompt, textHint, imagePart]),
      ]);
      if (response.text == null || response.text!.isEmpty) {
        return null;
      }
      final jsonResponse = response.text;
      final data = jsonDecode(jsonResponse!) as Map<String, dynamic>;
      // Map AI JSON into our data models
      final info = data['info'] as Map<String, dynamic>? ?? {};
      final name = info['name'] as String? ?? 'Unknown';
      final numServings = info['servingSize'];
      final servingCount =
          info['servingCount'] as String? ?? numServings.toString();
      final ingredients =
          (data['ingredients'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [];
      final nutrInfo = NutrutionGoals.fromJson(data);
      return FoodFacts(
        name: name,
        servingSize: servingCount,
        numServings: numServings,
        uploaded: DateTime.now(),
        image:
            "https://placehold.co/600x400.png?text=Scanned%20With%20AI", // Placeholder for image URL
        ingredients: ingredients,
        nutrutionInfo: nutrInfo,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error in AI service: $e');
      }
      return null;
    }
  }
}
