import 'package:calories_app/tools/food_facts.dart';
import 'package:calories_app/tools/calculate_goals.dart';
import 'package:flutter/material.dart';

class NutriFacts extends StatefulWidget {
  final FoodFacts foodFacts;
  final double servings;
  final Function(FoodFacts) onEdit;

  const NutriFacts({
    super.key,
    required this.foodFacts,
    required this.servings,
    required this.onEdit,
  });

  @override
  State<NutriFacts> createState() => _NutriFactsState();
}

class _NutriFactsState extends State<NutriFacts> {
  bool _isEditing = false;
  late FoodFacts _editableFoodFacts;

  @override
  void initState() {
    super.initState();
    _editableFoodFacts = widget.foodFacts;
  }

  void _saveChanges() {
    widget.onEdit(_editableFoodFacts);

    setState(() {
      _isEditing = false;
    });
  }

  void _cancelEdit() {
    setState(() {
      _editableFoodFacts = widget.foodFacts;
      _isEditing = false;
    });
  }

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
          // Edit button row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_isEditing) ...[
                TextButton(onPressed: _cancelEdit, child: const Text('Cancel')),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveChanges,
                  child: const Text('Save'),
                ),
              ] else
                IconButton(
                  onPressed: () => setState(() => _isEditing = true),
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit nutrition facts',
                ),
            ],
          ),

          // Product name
          Center(
            child: _isEditing
                ? TextFormField(
                    initialValue: _editableFoodFacts.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (value) {
                      _editableFoodFacts = _editableFoodFacts.copyWith(
                        name: value,
                      );
                    },
                  )
                : Text(
                    _editableFoodFacts.name,
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
          _isEditing
              ? TextFormField(
                  initialValue: _editableFoodFacts.servingSize,
                  decoration: const InputDecoration(
                    labelText: 'Serving size',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    _editableFoodFacts = _editableFoodFacts.copyWith(
                      servingSize: value,
                    );
                  },
                )
              : Text(
                  'Serving size ${_editableFoodFacts.servingSize}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
          Text('You ate ${widget.servings.toStringAsFixed(1)} servings'),
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
              _isEditing
                  ? SizedBox(
                      width: 80,
                      child: TextFormField(
                        initialValue: _editableFoodFacts
                            .nutrutionInfo
                            .calorieGoal
                            .toStringAsFixed(0),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final calories = double.tryParse(value) ?? 0.0;
                          _editableFoodFacts = _editableFoodFacts.copyWith(
                            nutrutionInfo: NutrutionGoals(
                              calorieGoal: calories,
                              macroNutrientGoals: _editableFoodFacts
                                  .nutrutionInfo
                                  .macroNutrientGoals,
                              vitaminGoals:
                                  _editableFoodFacts.nutrutionInfo.vitaminGoals,
                              microNutrientGoals: _editableFoodFacts
                                  .nutrutionInfo
                                  .microNutrientGoals,
                            ),
                          );
                        },
                      ),
                    )
                  : Text(
                      (_editableFoodFacts.nutrutionInfo.calorieGoal *
                              widget.servings)
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
          _buildEditableNutrientRow(
            'Total Fat',
            _editableFoodFacts.nutrutionInfo.macroNutrientGoals.fat,
            'g',
            (value) => _updateMacroNutrient('fat', value),
          ),
          _buildEditableNutrientRow(
            'Total Carbohydrate',
            _editableFoodFacts.nutrutionInfo.macroNutrientGoals.carbohydrates,
            'g',
            (value) => _updateMacroNutrient('carbohydrates', value),
          ),
          _buildEditableIndentedNutrientRow(
            'Dietary Fiber',
            _editableFoodFacts.nutrutionInfo.macroNutrientGoals.fiber,
            'g',
            (value) => _updateMacroNutrient('fiber', value),
          ),
          _buildEditableIndentedNutrientRow(
            'Total Sugars',
            _editableFoodFacts.nutrutionInfo.macroNutrientGoals.sugar,
            'g',
            (value) => _updateMacroNutrient('sugar', value),
          ),
          _buildEditableNutrientRow(
            'Protein',
            _editableFoodFacts.nutrutionInfo.macroNutrientGoals.protein,
            'g',
            (value) => _updateMacroNutrient('protein', value),
          ),
          _buildEditableIndentedNutrientRow(
            'Water',
            _editableFoodFacts.nutrutionInfo.macroNutrientGoals.water,
            'L',
            (value) => _updateMacroNutrient('water', value),
          ),

          const Divider(color: Colors.black, thickness: 2),

          // Vitamins and minerals (all now editable)
          ..._buildNutrientRows(),

          const Divider(color: Colors.black, thickness: 2),

          // Ingredients section
          if (_editableFoodFacts.ingredients.isNotEmpty) ...[
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
              _editableFoodFacts.ingredients.join(', ').toUpperCase(),
              style: const TextStyle(fontSize: 11, color: Colors.black),
            ),
          ],
        ],
      ),
    );
  }

  void _updateMicroNutrient(String nutrientName, double value) {
    setState(() {
      final micro = _editableFoodFacts.nutrutionInfo.microNutrientGoals;
      MicroNutrientGoals updatedMicro;

      switch (nutrientName) {
        case 'calcium':
          updatedMicro = MicroNutrientGoals(
            calcium: value,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        case 'iron':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: value,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        case 'sodium':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: value,
            zinc: micro.zinc,
          );
          break;
        case 'potassium':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: value,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        case 'magnesium':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: value,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        case 'phosphorus':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: value,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        case 'zinc':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: value,
          );
          break;
        case 'copper':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: value,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        case 'manganese':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: value,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        case 'selenium':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: value,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        case 'iodine':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: value,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        case 'molybdenum':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: value,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        case 'chlorine':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: value,
            copper: micro.copper,
            flouride: micro.flouride,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        case 'flouride':
          updatedMicro = MicroNutrientGoals(
            calcium: micro.calcium,
            chlorine: micro.chlorine,
            copper: micro.copper,
            flouride: value,
            iodine: micro.iodine,
            iron: micro.iron,
            magnesium: micro.magnesium,
            manganese: micro.manganese,
            molybdenum: micro.molybdenum,
            phosphorus: micro.phosphorus,
            potassium: micro.potassium,
            selenium: micro.selenium,
            sodium: micro.sodium,
            zinc: micro.zinc,
          );
          break;
        default:
          return;
      }

      _editableFoodFacts = _editableFoodFacts.copyWith(
        nutrutionInfo: NutrutionGoals(
          calorieGoal: _editableFoodFacts.nutrutionInfo.calorieGoal,
          macroNutrientGoals:
              _editableFoodFacts.nutrutionInfo.macroNutrientGoals,
          vitaminGoals: _editableFoodFacts.nutrutionInfo.vitaminGoals,
          microNutrientGoals: updatedMicro,
        ),
      );
    });
  }

  void _updateVitamin(String vitaminName, double value) {
    setState(() {
      final vitamins = _editableFoodFacts.nutrutionInfo.vitaminGoals;
      VitaminGoals updatedVitamins;

      switch (vitaminName) {
        case 'vitaminA':
          updatedVitamins = VitaminGoals(
            vitaminA: value,
            vitaminC: vitamins.vitaminC,
            vitaminD: vitamins.vitaminD,
            vitaminE: vitamins.vitaminE,
            vitaminK: vitamins.vitaminK,
            thiamin: vitamins.thiamin,
            riboflavin: vitamins.riboflavin,
            niacin: vitamins.niacin,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: vitamins.vitaminB6,
            folate: vitamins.folate,
            vitaminB12: vitamins.vitaminB12,
            choline: vitamins.choline,
          );
          break;
        case 'vitaminC':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: value,
            vitaminD: vitamins.vitaminD,
            vitaminE: vitamins.vitaminE,
            vitaminK: vitamins.vitaminK,
            thiamin: vitamins.thiamin,
            riboflavin: vitamins.riboflavin,
            niacin: vitamins.niacin,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: vitamins.vitaminB6,
            folate: vitamins.folate,
            vitaminB12: vitamins.vitaminB12,
            choline: vitamins.choline,
          );
          break;
        case 'vitaminD':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: vitamins.vitaminC,
            vitaminD: value,
            vitaminE: vitamins.vitaminE,
            vitaminK: vitamins.vitaminK,
            thiamin: vitamins.thiamin,
            riboflavin: vitamins.riboflavin,
            niacin: vitamins.niacin,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: vitamins.vitaminB6,
            folate: vitamins.folate,
            vitaminB12: vitamins.vitaminB12,
            choline: vitamins.choline,
          );
          break;
        case 'vitaminE':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: vitamins.vitaminC,
            vitaminD: vitamins.vitaminD,
            vitaminE: value,
            vitaminK: vitamins.vitaminK,
            thiamin: vitamins.thiamin,
            riboflavin: vitamins.riboflavin,
            niacin: vitamins.niacin,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: vitamins.vitaminB6,
            folate: vitamins.folate,
            vitaminB12: vitamins.vitaminB12,
            choline: vitamins.choline,
          );
          break;
        case 'vitaminK':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: vitamins.vitaminC,
            vitaminD: vitamins.vitaminD,
            vitaminE: vitamins.vitaminE,
            vitaminK: value,
            thiamin: vitamins.thiamin,
            riboflavin: vitamins.riboflavin,
            niacin: vitamins.niacin,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: vitamins.vitaminB6,
            folate: vitamins.folate,
            vitaminB12: vitamins.vitaminB12,
            choline: vitamins.choline,
          );
          break;
        case 'thiamin':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: vitamins.vitaminC,
            vitaminD: vitamins.vitaminD,
            vitaminE: vitamins.vitaminE,
            vitaminK: vitamins.vitaminK,
            thiamin: value,
            riboflavin: vitamins.riboflavin,
            niacin: vitamins.niacin,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: vitamins.vitaminB6,
            folate: vitamins.folate,
            vitaminB12: vitamins.vitaminB12,
            choline: vitamins.choline,
          );
          break;
        case 'riboflavin':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: vitamins.vitaminC,
            vitaminD: vitamins.vitaminD,
            vitaminE: vitamins.vitaminE,
            vitaminK: vitamins.vitaminK,
            thiamin: vitamins.thiamin,
            riboflavin: value,
            niacin: vitamins.niacin,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: vitamins.vitaminB6,
            folate: vitamins.folate,
            vitaminB12: vitamins.vitaminB12,
            choline: vitamins.choline,
          );
          break;
        case 'niacin':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: vitamins.vitaminC,
            vitaminD: vitamins.vitaminD,
            vitaminE: vitamins.vitaminE,
            vitaminK: vitamins.vitaminK,
            thiamin: vitamins.thiamin,
            riboflavin: vitamins.riboflavin,
            niacin: value,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: vitamins.vitaminB6,
            folate: vitamins.folate,
            vitaminB12: vitamins.vitaminB12,
            choline: vitamins.choline,
          );
          break;
        case 'pantothenicAcid':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: vitamins.vitaminC,
            vitaminD: vitamins.vitaminD,
            vitaminE: vitamins.vitaminE,
            vitaminK: vitamins.vitaminK,
            thiamin: vitamins.thiamin,
            riboflavin: vitamins.riboflavin,
            niacin: vitamins.niacin,
            pantothenicAcid: value,
            vitaminB6: vitamins.vitaminB6,
            folate: vitamins.folate,
            vitaminB12: vitamins.vitaminB12,
            choline: vitamins.choline,
          );
          break;
        case 'vitaminB6':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: vitamins.vitaminC,
            vitaminD: vitamins.vitaminD,
            vitaminE: vitamins.vitaminE,
            vitaminK: vitamins.vitaminK,
            thiamin: vitamins.thiamin,
            riboflavin: vitamins.riboflavin,
            niacin: vitamins.niacin,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: value,
            folate: vitamins.folate,
            vitaminB12: vitamins.vitaminB12,
            choline: vitamins.choline,
          );
          break;
        case 'folate':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: vitamins.vitaminC,
            vitaminD: vitamins.vitaminD,
            vitaminE: vitamins.vitaminE,
            vitaminK: vitamins.vitaminK,
            thiamin: vitamins.thiamin,
            riboflavin: vitamins.riboflavin,
            niacin: vitamins.niacin,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: vitamins.vitaminB6,
            folate: value,
            vitaminB12: vitamins.vitaminB12,
            choline: vitamins.choline,
          );
          break;
        case 'vitaminB12':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: vitamins.vitaminC,
            vitaminD: vitamins.vitaminD,
            vitaminE: vitamins.vitaminE,
            vitaminK: vitamins.vitaminK,
            thiamin: vitamins.thiamin,
            riboflavin: vitamins.riboflavin,
            niacin: vitamins.niacin,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: vitamins.vitaminB6,
            folate: vitamins.folate,
            vitaminB12: value,
            choline: vitamins.choline,
          );
          break;
        case 'choline':
          updatedVitamins = VitaminGoals(
            vitaminA: vitamins.vitaminA,
            vitaminC: vitamins.vitaminC,
            vitaminD: vitamins.vitaminD,
            vitaminE: vitamins.vitaminE,
            vitaminK: vitamins.vitaminK,
            thiamin: vitamins.thiamin,
            riboflavin: vitamins.riboflavin,
            niacin: vitamins.niacin,
            pantothenicAcid: vitamins.pantothenicAcid,
            vitaminB6: vitamins.vitaminB6,
            folate: vitamins.folate,
            vitaminB12: vitamins.vitaminB12,
            choline: value,
          );
          break;
        default:
          return;
      }

      _editableFoodFacts = _editableFoodFacts.copyWith(
        nutrutionInfo: NutrutionGoals(
          calorieGoal: _editableFoodFacts.nutrutionInfo.calorieGoal,
          macroNutrientGoals:
              _editableFoodFacts.nutrutionInfo.macroNutrientGoals,
          vitaminGoals: updatedVitamins,
          microNutrientGoals:
              _editableFoodFacts.nutrutionInfo.microNutrientGoals,
        ),
      );
    });
  }

  void _updateMacroNutrient(String nutrientName, double value) {
    setState(() {
      final macro = _editableFoodFacts.nutrutionInfo.macroNutrientGoals;
      MacroNutrientGoals updatedMacro;

      switch (nutrientName) {
        case 'fat':
          updatedMacro = MacroNutrientGoals(
            carbohydrates: macro.carbohydrates,
            fiber: macro.fiber,
            protein: macro.protein,
            fat: value,
            sugar: macro.sugar,
            water: macro.water,
          );
          break;
        case 'carbohydrates':
          updatedMacro = MacroNutrientGoals(
            carbohydrates: value,
            fiber: macro.fiber,
            protein: macro.protein,
            fat: macro.fat,
            sugar: macro.sugar,
            water: macro.water,
          );
          break;
        case 'fiber':
          updatedMacro = MacroNutrientGoals(
            carbohydrates: macro.carbohydrates,
            fiber: value,
            protein: macro.protein,
            fat: macro.fat,
            sugar: macro.sugar,
            water: macro.water,
          );
          break;
        case 'sugar':
          updatedMacro = MacroNutrientGoals(
            carbohydrates: macro.carbohydrates,
            fiber: macro.fiber,
            protein: macro.protein,
            fat: macro.fat,
            sugar: value,
            water: macro.water,
          );
          break;
        case 'protein':
          updatedMacro = MacroNutrientGoals(
            carbohydrates: macro.carbohydrates,
            fiber: macro.fiber,
            protein: value,
            fat: macro.fat,
            sugar: macro.sugar,
            water: macro.water,
          );
          break;
        case 'water':
          updatedMacro = MacroNutrientGoals(
            carbohydrates: macro.carbohydrates,
            fiber: macro.fiber,
            protein: macro.protein,
            fat: macro.fat,
            sugar: macro.sugar,
            water: value,
          );
          break;
        default:
          return;
      }

      _editableFoodFacts = _editableFoodFacts.copyWith(
        nutrutionInfo: NutrutionGoals(
          calorieGoal: _editableFoodFacts.nutrutionInfo.calorieGoal,
          macroNutrientGoals: updatedMacro,
          vitaminGoals: _editableFoodFacts.nutrutionInfo.vitaminGoals,
          microNutrientGoals:
              _editableFoodFacts.nutrutionInfo.microNutrientGoals,
        ),
      );
    });
  }

  Widget _buildEditableNutrientRow(
    String nutrient,
    double currentValue,
    String unit,
    Function(double) onChanged,
  ) {
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
            _isEditing
                ? SizedBox(
                    width: 80,
                    child: TextFormField(
                      initialValue: (currentValue * widget.servings)
                          .toStringAsFixed(1),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(4),
                        suffix: Text(unit),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final totalValue = double.tryParse(value) ?? 0.0;
                        final perServingValue = totalValue / widget.servings;
                        onChanged(perServingValue);
                      },
                    ),
                  )
                : Text(
                    '${(currentValue * widget.servings).toStringAsFixed(1)}$unit',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
          ],
        ),
        const Divider(color: Colors.black, thickness: 1),
      ],
    );
  }

  Widget _buildEditableIndentedNutrientRow(
    String nutrient,
    double currentValue,
    String unit,
    Function(double) onChanged,
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
            _isEditing
                ? SizedBox(
                    width: 80,
                    child: TextFormField(
                      initialValue: (currentValue * widget.servings)
                          .toStringAsFixed(1),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(4),
                        suffix: Text(unit),
                      ),
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final totalValue = double.tryParse(value) ?? 0.0;
                        final perServingValue = totalValue / widget.servings;
                        onChanged(perServingValue);
                      },
                    ),
                  )
                : Text(
                    '${(currentValue * widget.servings).toStringAsFixed(1)}$unit',
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
          ],
        ),
        const Divider(color: Colors.black, thickness: 1),
      ],
    );
  }

  List<Widget> _buildNutrientRows() {
    final List<Widget> rows = [];

    // Vitamins (convert to micrograms or milligrams and use appropriate units)
    rows.add(
      _buildEditableNutrientRow(
        'Vitamin A',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminA /
            1000000, // Convert to µg
        'µg',
        (value) => _updateVitamin(
          'vitaminA',
          value * 1000000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Vitamin C',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminC /
            1000, // Convert to mg
        'mg',
        (value) => _updateVitamin(
          'vitaminC',
          value * 1000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Vitamin D',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminD /
            1000, // Convert to mg
        'mg',
        (value) => _updateVitamin(
          'vitaminD',
          value * 1000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Vitamin E',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminE /
            1000, // Convert to mg
        'mg',
        (value) => _updateVitamin(
          'vitaminE',
          value * 1000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Vitamin K',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminK /
            1000000, // Convert to µg
        'µg',
        (value) => _updateVitamin(
          'vitaminK',
          value * 1000000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Thiamin (B1)',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.thiamin /
            1000, // Convert to mg
        'mg',
        (value) => _updateVitamin(
          'thiamin',
          value * 1000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Riboflavin (B2)',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.riboflavin /
            1000, // Convert to mg
        'mg',
        (value) => _updateVitamin(
          'riboflavin',
          value * 1000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Niacin (B3)',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.niacin /
            1000, // Convert to mg
        'mg',
        (value) => _updateVitamin(
          'niacin',
          value * 1000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Pantothenic Acid (B5)',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.pantothenicAcid /
            1000, // Convert to mg
        'mg',
        (value) => _updateVitamin(
          'pantothenicAcid',
          value * 1000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Vitamin B6',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminB6 /
            1000, // Convert to mg
        'mg',
        (value) => _updateVitamin(
          'vitaminB6',
          value * 1000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Folate',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.folate /
            1000000, // Convert to µg
        'µg',
        (value) => _updateVitamin(
          'folate',
          value * 1000000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Vitamin B12',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminB12 /
            1000000, // Convert to µg
        'µg',
        (value) => _updateVitamin(
          'vitaminB12',
          value * 1000000,
        ), // Convert back to original units
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Choline',
        _editableFoodFacts.nutrutionInfo.vitaminGoals.choline /
            1000, // Convert to mg
        'mg',
        (value) => _updateVitamin(
          'choline',
          value * 1000,
        ), // Convert back to original units
      ),
    );

    // Minerals (all editable)
    rows.add(
      _buildEditableNutrientRow(
        'Calcium',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.calcium,
        'mg',
        (value) => _updateMicroNutrient('calcium', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Iron',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.iron,
        'mg',
        (value) => _updateMicroNutrient('iron', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Magnesium',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.magnesium,
        'mg',
        (value) => _updateMicroNutrient('magnesium', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Phosphorus',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.phosphorus,
        'mg',
        (value) => _updateMicroNutrient('phosphorus', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Potassium',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.potassium,
        'mg',
        (value) => _updateMicroNutrient('potassium', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Sodium',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.sodium,
        'mg',
        (value) => _updateMicroNutrient('sodium', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Zinc',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.zinc,
        'mg',
        (value) => _updateMicroNutrient('zinc', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Copper',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.copper,
        'mg',
        (value) => _updateMicroNutrient('copper', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Manganese',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.manganese,
        'mg',
        (value) => _updateMicroNutrient('manganese', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Selenium',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.selenium,
        'µg',
        (value) => _updateMicroNutrient('selenium', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Iodine',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.iodine,
        'µg',
        (value) => _updateMicroNutrient('iodine', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Molybdenum',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.molybdenum,
        'µg',
        (value) => _updateMicroNutrient('molybdenum', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Chloride',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.chlorine,
        'mg',
        (value) => _updateMicroNutrient('chlorine', value),
      ),
    );

    rows.add(
      _buildEditableNutrientRow(
        'Fluoride',
        _editableFoodFacts.nutrutionInfo.microNutrientGoals.flouride,
        'mg',
        (value) => _updateMicroNutrient('flouride', value),
      ),
    );

    return rows;
  }
}
