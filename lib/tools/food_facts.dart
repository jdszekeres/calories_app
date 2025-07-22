import 'dart:convert';
import 'package:calories_app/tools/calculate_goals.dart';
import 'package:http/http.dart';

class FoodFacts {
  final String name;
  final String servingSize;
  final double? numServings;
  final DateTime? uploaded;
  final String? image;
  final List<String> ingredients;
  final NutrutionGoals nutrutionInfo;

  FoodFacts({
    required this.name,
    required this.servingSize,
    this.numServings,
    this.uploaded,
    required this.image,
    required this.ingredients,
    required this.nutrutionInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'servingSize': servingSize,
      'numServings': numServings,
      'uploaded': uploaded?.toIso8601String(),
      'image': image,
      'ingredients': ingredients,
      'nutrutionInfo': nutrutionInfo.toJson(),
    };
  }

  static FoodFacts fromJson(Map<String, dynamic> json) {
    return FoodFacts(
      name: json['name'] as String,
      servingSize: json['servingSize'] as String,
      numServings: (json['numServings'] as num?)?.toDouble(),
      uploaded: json['uploaded'] != null
          ? DateTime.parse(json['uploaded'] as String)
          : null,
      image: json['image'] as String?,
      ingredients: List<String>.from(json['ingredients'] as List),
      nutrutionInfo: NutrutionGoals.fromJson(
        json['nutrutionInfo'] as Map<String, dynamic>,
      ),
    );
  }

  FoodFacts copyWith({
    double? numServings,
    String? name,
    String? servingSize,
    DateTime? uploaded,
    String? image,
    List<String>? ingredients,
    NutrutionGoals? nutrutionInfo,
  }) {
    return FoodFacts(
      name: name ?? this.name,
      servingSize: servingSize ?? this.servingSize,
      numServings: numServings ?? this.numServings,
      uploaded: uploaded ?? this.uploaded,
      image: image ?? this.image,
      ingredients: ingredients ?? List<String>.from(this.ingredients),
      nutrutionInfo: nutrutionInfo ?? this.nutrutionInfo,
    );
  }
}

const String _foodFactsApiUrl =
    'https://world.openfoodfacts.net/api/v2/product/';
Future<FoodFacts?> fetchFoodFacts(String barcode) async {
  final Uri url = Uri.parse('$_foodFactsApiUrl$barcode');
  final Response response = await get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;
    if (data.containsKey('product')) {
      final Map<String, dynamic> product =
          data['product'] as Map<String, dynamic>;

      return FoodFacts(
        name: product['product_name'] ?? 'Unknown Product',
        servingSize: product['serving_size'] ?? 'Unknown Serving Size',
        image: product['image_url'] as String?,
        ingredients:
            (product['ingredients_text'] as String?)
                ?.split(', ')
                .map((ingredient) => ingredient.trim())
                .toList() ??
            [],
        nutrutionInfo: NutrutionGoals(
          calorieGoal:
              (product['nutriments']['energy-kcal_serving'] as num?)
                  ?.toDouble() ??
              0.0,
          macroNutrientGoals: MacroNutrientGoals(
            carbohydrates:
                (product['nutriments']['carbohydrates_serving'] as num?)
                    ?.toDouble() ??
                0.0,
            fiber:
                (product['nutriments']['fiber_serving'] as num?)?.toDouble() ??
                0.0,
            protein:
                (product['nutriments']['proteins_serving'] as num?)
                    ?.toDouble() ??
                0.0,
            fat:
                (product['nutriments']['fat_serving'] as num?)?.toDouble() ??
                0.0,
            sugar:
                (product['nutriments']['sugars_serving'] as num?)?.toDouble() ??
                0.0,
            water:
                (product['nutriments']['water_serving'] as num?)?.toDouble() ??
                0.0,
          ),
          vitaminGoals: VitaminGoals(
            vitaminA:
                ((product['nutriments']['vitamin_a_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000000, // Convert to micrograms
            vitaminD:
                ((product['nutriments']['vitamin_d_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // convert to mg
            vitaminE:
                ((product['nutriments']['vitamin_e_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // convert to mg
            vitaminK:
                ((product['nutriments']['vitamin_k_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000000, // Convert to micrograms
            vitaminC:
                ((product['nutriments']['vitamin_c_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to milligrams
            thiamin:
                ((product['nutriments']['thiamin_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to milligrams
            riboflavin:
                ((product['nutriments']['riboflavin_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to milligrams
            niacin:
                ((product['nutriments']['niacin_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to milligrams
            pantothenicAcid:
                ((product['nutriments']['pantothenic-acid_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to milligrams
            vitaminB6:
                ((product['nutriments']['vitamin-b6_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to milligrams
            folate:
                ((product['nutriments']['folate_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000000, // Convert to micrograms
            vitaminB12:
                ((product['nutriments']['vitamin-b12_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to micrograms
            choline:
                ((product['nutriments']['choline_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to milligrams
          ),
          microNutrientGoals: MicroNutrientGoals(
            calcium:
                ((product['nutriments']['calcium_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to milligrams
            chlorine:
                ((product['nutriments']['chlorine_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to milligrams
            copper:
                ((product['nutriments']['copper_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to milligrams
            flouride:
                ((product['nutriments']['flouride_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to milligrams
            iodine:
                ((product['nutriments']['iodine_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000000, // Convert to micrograms
            iron:
                ((product['nutriments']['iron_serving'] as num?)?.toDouble() ??
                    0.0) *
                1000, // Convert to micrograms
            magnesium:
                ((product['nutriments']['magnesium_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to micrograms
            manganese:
                ((product['nutriments']['manganese_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to micrograms
            molybdenum:
                ((product['nutriments']['molybdenum_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000000, // Convert to micrograms
            phosphorus:
                ((product['nutriments']['phosphorus_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to micrograms
            potassium:
                ((product['nutriments']['potassium_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to micrograms
            selenium:
                ((product['nutriments']['selenium_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000000, // Convert to micrograms
            sodium:
                ((product['nutriments']['sodium_serving'] as num?)
                        ?.toDouble() ??
                    0.0) *
                1000, // Convert to micrograms
            zinc:
                ((product['nutriments']['zinc_serving'] as num?)?.toDouble() ??
                    0.0) *
                1000, // Convert to micrograms
          ),
        ),
      );
    } else {
      throw Exception('Product not found');
    }
  } else {
    throw Exception('Failed to load food facts');
  }
}
