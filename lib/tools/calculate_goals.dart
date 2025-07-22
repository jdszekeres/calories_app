// ignore_for_file: non_constant_identifier_names

enum ActivityLevel {
  sedentary, // little or no exercise
  lightlyActive, // light exercise/sports 1-3 days a week
  moderatelyActive, // moderate exercise/sports 3-5 days a week
  veryActive, // hard exercise/sports 6-7 days a week
  extraActive, // very hard exercise/sports & physical job or training twice a day
}

class MacroNutrientGoals {
  double carbohydrates;
  double fiber;
  double protein;
  double fat;
  double sugar;
  double water;

  static const List<String> keys = [
    'carbohydrates',
    'fiber',
    'protein',
    'fat',
    'sugar',
    'water',
  ];

  MacroNutrientGoals({
    required this.carbohydrates,
    required this.fiber,
    required this.protein,
    required this.fat,
    required this.sugar,
    required this.water,
  });
}

class VitaminGoals {
  double vitaminA;
  double vitaminD;
  double vitaminE;
  double vitaminK;
  double vitaminC;
  double thiamin; //B1
  double riboflavin; //B2
  double niacin; //B3
  double pantothenicAcid; //B5
  double vitaminB6;
  double folate;
  double vitaminB12;
  double choline;

  VitaminGoals({
    required this.vitaminA,
    required this.vitaminD,
    required this.vitaminE,
    required this.vitaminK,
    required this.vitaminC,
    required this.thiamin,
    required this.riboflavin,
    required this.niacin,
    required this.pantothenicAcid,
    required this.vitaminB6,
    required this.folate,
    required this.vitaminB12,
    required this.choline,
  });
  static const List<String> keys = [
    'vitaminA',
    'vitaminD',
    'vitaminE',
    'vitaminK',
    'vitaminC',
    'thiamin',
    'riboflavin',
    'niacin',
    'pantothenicAcid',
    'vitaminB6',
    'folate',
    'vitaminB12',
    'choline',
  ];
}

class MicroNutrientGoals {
  double calcium;
  double chlorine;
  double copper;
  double flouride;
  double iodine;
  double iron;
  double magnesium;
  double manganese;
  double molybdenum;
  double phosphorus;
  double potassium;
  double selenium;
  double sodium;
  double zinc;

  MicroNutrientGoals({
    required this.calcium,
    required this.chlorine,
    required this.copper,
    required this.flouride,
    required this.iodine,
    required this.iron,
    required this.magnesium,
    required this.manganese,
    required this.molybdenum,
    required this.phosphorus,
    required this.potassium,
    required this.selenium,
    required this.sodium,
    required this.zinc,
  });

  static const List<String> keys = [
    'calcium',
    'chlorine',
    'copper',
    'flouride',
    'iodine',
    'iron',
    'magnesium',
    'manganese',
    'molybdenum',
    'phosphorus',
    'potassium',
    'selenium',
    'sodium',
    'zinc',
  ];
}

class NutrutionGoals {
  double calorieGoal;
  MacroNutrientGoals macroNutrientGoals;
  VitaminGoals vitaminGoals;
  MicroNutrientGoals microNutrientGoals;

  NutrutionGoals({
    required this.calorieGoal,
    required this.macroNutrientGoals,
    required this.vitaminGoals,
    required this.microNutrientGoals,
  });

  static List<String> keys = [
    'calories',
    ...MacroNutrientGoals.keys,
    ...VitaminGoals.keys,
    ...MicroNutrientGoals.keys,
  ];
  static String getKey(String nutrient) {
    // Returns the key for a given nutrient
    if (nutrient == 'calories') {
      return 'calorieGoals';
    } else if (MacroNutrientGoals.keys.contains(nutrient)) {
      return 'macroNutrientGoals';
    } else if (VitaminGoals.keys.contains(nutrient)) {
      return 'vitaminGoals';
    } else if (MicroNutrientGoals.keys.contains(nutrient)) {
      return 'microNutrientGoals';
    }
    return '';
  }

  Map<String, dynamic> toJson() {
    return {
      'calorieGoals': {'calories': calorieGoal},
      'macroNutrientGoals': {
        'carbohydrates': macroNutrientGoals.carbohydrates,
        'fiber': macroNutrientGoals.fiber,
        'protein': macroNutrientGoals.protein,
        'fat': macroNutrientGoals.fat,
        'sugar': macroNutrientGoals.sugar,
        'water': macroNutrientGoals.water,
      },
      'vitaminGoals': {
        'vitaminA': vitaminGoals.vitaminA,
        'vitaminD': vitaminGoals.vitaminD,
        'vitaminE': vitaminGoals.vitaminE,
        'vitaminK': vitaminGoals.vitaminK,
        'vitaminC': vitaminGoals.vitaminC,
        'thiamin': vitaminGoals.thiamin,
        'riboflavin': vitaminGoals.riboflavin,
        'niacin': vitaminGoals.niacin,
        'pantothenicAcid': vitaminGoals.pantothenicAcid,
        'vitaminB6': vitaminGoals.vitaminB6,
        'folate': vitaminGoals.folate,
        'vitaminB12': vitaminGoals.vitaminB12,
        'choline': vitaminGoals.choline,
      },
      'microNutrientGoals': {
        'calcium': microNutrientGoals.calcium,
        'chlorine': microNutrientGoals.chlorine,
        'copper': microNutrientGoals.copper,
        'flouride': microNutrientGoals.flouride,
        'iodine': microNutrientGoals.iodine,
        'iron': microNutrientGoals.iron,
        'magnesium': microNutrientGoals.magnesium,
        'manganese': microNutrientGoals.manganese,
        'molybdenum': microNutrientGoals.molybdenum,
        'phosphorus': microNutrientGoals.phosphorus,
        'potassium': microNutrientGoals.potassium,
        'selenium': microNutrientGoals.selenium,
        'sodium': microNutrientGoals.sodium,
        'zinc': microNutrientGoals.zinc,
      },
    };
  }

  static NutrutionGoals fromJson(Map<String, dynamic> json) {
    return NutrutionGoals(
      calorieGoal: json['calorieGoals']['calories'],
      macroNutrientGoals: MacroNutrientGoals(
        carbohydrates: json['macroNutrientGoals']['carbohydrates'],
        fiber: json['macroNutrientGoals']['fiber'],
        protein: json['macroNutrientGoals']['protein'],
        fat: json['macroNutrientGoals']['fat'],
        sugar: json['macroNutrientGoals']['sugar'],
        water: json['macroNutrientGoals']['water'],
      ),
      vitaminGoals: VitaminGoals(
        vitaminA: json['vitaminGoals']['vitaminA'],
        vitaminD: json['vitaminGoals']['vitaminD'],
        vitaminE: json['vitaminGoals']['vitaminE'],
        vitaminK: json['vitaminGoals']['vitaminK'],
        vitaminC: json['vitaminGoals']['vitaminC'],
        thiamin: json['vitaminGoals']['thiamin'],
        riboflavin: json['vitaminGoals']['riboflavin'],
        niacin: json['vitaminGoals']['niacin'],
        pantothenicAcid: json['vitaminGoals']['pantothenicAcid'],
        vitaminB6: json['vitaminGoals']['vitaminB6'],
        folate: json['vitaminGoals']['folate'],
        vitaminB12: json['vitaminGoals']['vitaminB12'],
        choline: json['vitaminGoals']['choline'],
      ),
      microNutrientGoals: MicroNutrientGoals(
        calcium: json['microNutrientGoals']['calcium'],
        chlorine: json['microNutrientGoals']['chlorine'],
        copper: json['microNutrientGoals']['copper'],
        flouride: json['microNutrientGoals']['flouride'],
        iodine: json['microNutrientGoals']['iodine'],
        iron: json['microNutrientGoals']['iron'],
        magnesium: json['microNutrientGoals']['magnesium'],
        manganese: json['microNutrientGoals']['manganese'],
        molybdenum: json['microNutrientGoals']['molybdenum'],
        phosphorus: json['microNutrientGoals']['phosphorus'],
        potassium: json['microNutrientGoals']['potassium'],
        selenium: json['microNutrientGoals']['selenium'],
        sodium: json['microNutrientGoals']['sodium'],
        zinc: json['microNutrientGoals']['zinc'],
      ),
    );
  }

  static String getUnit(String nutrient) {
    // Returns the unit for a given nutrient
    switch (nutrient) {
      case 'calories':
        return 'kcal';
      case 'carbohydrates':
      case 'fiber':
      case 'protein':
      case 'fat':
      case 'sugar':
        return 'g';
      case 'water':
        return 'L';
      case 'vitaminA':
      case 'vitaminK':
      case 'folate':
      case 'iodine':
      case 'molybdenum':
      case 'selenium':
        return 'mcg';
      case 'vitaminD':
      case 'vitaminE':
      case 'vitaminC':
      case 'thiamin':
      case 'riboflavin':
      case 'niacin':
      case 'pantothenicAcid':
      case 'vitaminB6':
      case 'vitaminB12':
      case 'choline':
      case 'calcium':
      case 'chlorine':
      case 'copper':
      case 'flouride':
      case 'iron':
      case 'magnesium':
      case 'manganese':
      case 'phosphorus':
      case 'potassium':
      case 'sodium':
      case 'zinc':
        return 'mg';
      default:
        return '';
    }
  }
}

double _getAgeBasedNutrients(
  int age,
  double adult,
  double child,
  double infant,
) {
  // Returns different nutrient values based on age
  if (age < 1) {
    return infant; // Infant
  } else if (age < 4) {
    return child; // Child
  } else {
    return adult; // Adult
  }
}

double _getCalorieMultiplier(ActivityLevel activityLevel) {
  // Returns a multiplier based on the activity level
  switch (activityLevel) {
    case ActivityLevel.sedentary:
      return 1.2;
    case ActivityLevel.lightlyActive:
      return 1.375;
    case ActivityLevel.moderatelyActive:
      return 1.55;
    case ActivityLevel.veryActive:
      return 1.725;
    case ActivityLevel.extraActive:
      return 1.9;
  }
}

NutrutionGoals calculateGoals(
  int age,
  double weight,
  double height,
  ActivityLevel activityLevel,
  bool isMale,
) {
  //@PARAM age: Age in years
  //@PARAM weight: Weight in kg
  //@PARAM height: Height in cm

  // Example calculation logic for goals based on age, weight, and height
  double calorieGoal =
      (10 * weight) +
      (6.25 * height) -
      (5 * age) +
      5; // Mifflin-St Jeor Equation

  if (!isMale) {
    calorieGoal -= 161; // Adjust for women
  }

  calorieGoal *= _getCalorieMultiplier(activityLevel);

  calorieGoal = calorieGoal.roundToDouble(); // Round to nearest whole number

  double proteinCalories = (calorieGoal * (age < 3 ? 0.125 : 0.20));
  double proteinGrams = (proteinCalories / 4)
      .roundToDouble(); // 1g protein = 4 calories
  double fatCalories =
      (calorieGoal * age < 3
              ? 0.35
              : age > 18
              ? 0.275
              : 0.30)
          .roundToDouble();
  double fatGrams = (fatCalories / 9).roundToDouble(); // 1g fat = 9 calories

  double carbCalories = calorieGoal - (proteinCalories + fatCalories);
  double carbGrams = (carbCalories / 4).roundToDouble(); // 1g carb = 4 calories

  double fiberGrams = (calorieGoal / 1000 * 14)
      .roundToDouble(); // 14g per 1000 calories

  double sugarCalories = ((calorieGoal / 40 * 4)).roundToDouble();

  double sugarGrams = (sugarCalories / 4)
      .roundToDouble(); // 1g sugar = 4 calories

  double waterIntake = calorieGoal / 1000; // 30ml per kg of body weight

  MacroNutrientGoals macroNutrientGoals = MacroNutrientGoals(
    carbohydrates: carbGrams,
    fiber: fiberGrams, // Recommended daily intake
    protein: proteinGrams,
    fat: fatGrams,
    sugar: sugarGrams, // Recommended daily intake
    water: waterIntake, // Average daily water intake in liters
  );

  double vitaminA = _getAgeBasedNutrients(age, 900, 300, 500); // mcg
  double vitaminD = _getAgeBasedNutrients(age, 20, 15, 10); // mcg
  double vitaminE = _getAgeBasedNutrients(age, 15, 6, 5); // mg
  double vitaminK = _getAgeBasedNutrients(age, 120, 30, 2.5); // mcg
  double vitaminC = _getAgeBasedNutrients(age, 90, 15, 50); // mg
  double thiamin = _getAgeBasedNutrients(age, 1.2, 0.5, 0.3); // mg
  double riboflavin = _getAgeBasedNutrients(age, 1.3, 0.5, 0.4); // mg
  double niacin = _getAgeBasedNutrients(age, 16, 6, 3); // mg
  double pantothenicAcid = _getAgeBasedNutrients(age, 5, 2, 1.8); // mg
  double vitaminB6 = _getAgeBasedNutrients(age, 1.7, 0.5, 0.3); // mg
  double folate = _getAgeBasedNutrients(age, 400, 150, 80); // mcg
  double vitaminB12 = _getAgeBasedNutrients(age, 2.4, 0.9, 0.5); // mcg
  double choline = _getAgeBasedNutrients(age, 550, 200, 150); // mg

  VitaminGoals vitaminGoals = VitaminGoals(
    vitaminA: vitaminA, // Recommended daily intake in mcg
    vitaminD: vitaminD, // Recommended daily intake in mcg
    vitaminE: vitaminE, // Recommended daily intake in mg
    vitaminK: vitaminK, // Recommended daily intake in mcg
    vitaminC: vitaminC, // Recommended daily intake in mg
    thiamin: thiamin, // Recommended daily intake in mg
    riboflavin: riboflavin, // Recommended daily intake in mg
    niacin: niacin, // Recommended daily intake in mg
    pantothenicAcid: pantothenicAcid, // Recommended daily intake in mg
    vitaminB6: vitaminB6, // Recommended daily intake in mg
    folate: folate, // Recommended daily intake in mcg
    vitaminB12: vitaminB12, // Recommended daily intake in mcg
    choline: choline, // Recommended daily intake in mg
  );

  double calcium = _getAgeBasedNutrients(age, 1300, 700, 260); // mg
  double chlorine = _getAgeBasedNutrients(age, 2300, 1500, 570); // mg
  double copper = _getAgeBasedNutrients(age, 900, 340, 200); // mcg
  double flouride = _getAgeBasedNutrients(age, 400, 50, 0); // mcg
  double iodine = _getAgeBasedNutrients(age, 150, 90, 130); // mcg
  double iron = _getAgeBasedNutrients(age, 18, 7, 11); // mg
  double magnesium = _getAgeBasedNutrients(age, 420, 80, 75); // mg
  double manganese = _getAgeBasedNutrients(age, 2.3, 1.2, 0.6); // mg
  double molybdenum = _getAgeBasedNutrients(age, 45, 17, 3); // mcg
  double phosphorus = _getAgeBasedNutrients(age, 1250, 460, 275); // mg
  double potassium = _getAgeBasedNutrients(age, 4700, 3000, 700); // mg
  double selenium = _getAgeBasedNutrients(age, 55, 20, 20); // mcg
  double sodium = _getAgeBasedNutrients(age, 2300, 1200, 1200); // mg
  double zinc = _getAgeBasedNutrients(age, 11, 3, 3); // mg

  MicroNutrientGoals microNutrientGoals = MicroNutrientGoals(
    calcium: calcium, // Recommended daily intake in mg
    chlorine: chlorine, // Recommended daily intake in mg
    copper: copper, // Recommended daily intake in mcg
    flouride: flouride, // Recommended daily intake in mcg
    iodine: iodine, // Recommended daily intake in mcg
    iron: iron, // Recommended daily intake in mg
    magnesium: magnesium, // Recommended daily intake in mg
    manganese: manganese, // Recommended daily intake in mg
    molybdenum: molybdenum, // Recommended daily intake in mcg
    phosphorus: phosphorus, // Recommended daily intake in mg
    potassium: potassium, // Recommended daily intake in mg
    selenium: selenium, // Recommended daily intake in mcg
    sodium: sodium, // Recommended daily intake in mg
    zinc: zinc, // Recommended daily intake in mg
  );

  return NutrutionGoals(
    calorieGoal: calorieGoal,
    macroNutrientGoals: macroNutrientGoals,
    vitaminGoals: vitaminGoals,
    microNutrientGoals: microNutrientGoals,
  );
}
