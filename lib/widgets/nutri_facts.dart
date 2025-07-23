import 'package:calories_app/tools/food_facts.dart';
import 'package:calories_app/tools/calculate_goals.dart';
import 'package:flutter/material.dart';

class NutriFacts extends StatefulWidget {
  final FoodFacts foodFacts;
  final double servings;
  final Function(FoodFacts)? onEdit;

  const NutriFacts({
    super.key,
    required this.foodFacts,
    required this.servings,
    this.onEdit,
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
    if (widget.onEdit != null) {
      widget.onEdit!(_editableFoodFacts);
    }
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
          if (widget.onEdit != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_isEditing) ...[
                  TextButton(
                    onPressed: _cancelEdit,
                    child: const Text('Cancel'),
                  ),
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

          const Divider(color: Colors.black, thickness: 2),

          // Vitamins and minerals (only show if values > 0)
          // Vitamins
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminA > 0)
            _buildNutrientRow(
              'Vitamin A',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminA * widget.servings) / 1000000).toStringAsFixed(1)}µg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminC > 0)
            _buildNutrientRow(
              'Vitamin C',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminC * widget.servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminD > 0)
            _buildNutrientRow(
              'Vitamin D',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminD * widget.servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminE > 0)
            _buildNutrientRow(
              'Vitamin E',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminE * widget.servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminK > 0)
            _buildNutrientRow(
              'Vitamin K',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminK * widget.servings) / 1000000).toStringAsFixed(1)}µg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.thiamin > 0)
            _buildNutrientRow(
              'Thiamin (B1)',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.thiamin * widget.servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.riboflavin > 0)
            _buildNutrientRow(
              'Riboflavin (B2)',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.riboflavin * widget.servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.niacin > 0)
            _buildNutrientRow(
              'Niacin (B3)',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.niacin * widget.servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.pantothenicAcid > 0)
            _buildNutrientRow(
              'Pantothenic Acid (B5)',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.pantothenicAcid * widget.servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminB6 > 0)
            _buildNutrientRow(
              'Vitamin B6',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminB6 * widget.servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.folate > 0)
            _buildNutrientRow(
              'Folate',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.folate * widget.servings) / 1000000).toStringAsFixed(1)}µg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminB12 > 0)
            _buildNutrientRow(
              'Vitamin B12',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.vitaminB12 * widget.servings) / 1000000).toStringAsFixed(1)}µg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.vitaminGoals.choline > 0)
            _buildNutrientRow(
              'Choline',
              '${((_editableFoodFacts.nutrutionInfo.vitaminGoals.choline * widget.servings) / 1000).toStringAsFixed(1)}mg',
              '',
            ),

          // Minerals
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.calcium > 0)
            _buildEditableNutrientRow(
              'Calcium',
              _editableFoodFacts.nutrutionInfo.microNutrientGoals.calcium,
              'mg',
              (value) => _updateMicroNutrient('calcium', value),
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.iron > 0)
            _buildEditableNutrientRow(
              'Iron',
              _editableFoodFacts.nutrutionInfo.microNutrientGoals.iron,
              'mg',
              (value) => _updateMicroNutrient('iron', value),
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.magnesium > 0)
            _buildNutrientRow(
              'Magnesium',
              '${(_editableFoodFacts.nutrutionInfo.microNutrientGoals.magnesium * widget.servings).toStringAsFixed(0)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.phosphorus >
              0)
            _buildNutrientRow(
              'Phosphorus',
              '${(_editableFoodFacts.nutrutionInfo.microNutrientGoals.phosphorus * widget.servings).toStringAsFixed(0)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.potassium > 0)
            _buildEditableNutrientRow(
              'Potassium',
              _editableFoodFacts.nutrutionInfo.microNutrientGoals.potassium,
              'mg',
              (value) => _updateMicroNutrient('potassium', value),
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.sodium > 0)
            _buildEditableNutrientRow(
              'Sodium',
              _editableFoodFacts.nutrutionInfo.microNutrientGoals.sodium,
              'mg',
              (value) => _updateMicroNutrient('sodium', value),
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.zinc > 0)
            _buildNutrientRow(
              'Zinc',
              '${(_editableFoodFacts.nutrutionInfo.microNutrientGoals.zinc * widget.servings).toStringAsFixed(1)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.copper > 0)
            _buildNutrientRow(
              'Copper',
              '${(_editableFoodFacts.nutrutionInfo.microNutrientGoals.copper * widget.servings).toStringAsFixed(1)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.manganese > 0)
            _buildNutrientRow(
              'Manganese',
              '${(_editableFoodFacts.nutrutionInfo.microNutrientGoals.manganese * widget.servings).toStringAsFixed(1)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.selenium > 0)
            _buildNutrientRow(
              'Selenium',
              '${(_editableFoodFacts.nutrutionInfo.microNutrientGoals.selenium * widget.servings).toStringAsFixed(1)}µg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.iodine > 0)
            _buildNutrientRow(
              'Iodine',
              '${(_editableFoodFacts.nutrutionInfo.microNutrientGoals.iodine * widget.servings).toStringAsFixed(1)}µg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.molybdenum >
              0)
            _buildNutrientRow(
              'Molybdenum',
              '${(_editableFoodFacts.nutrutionInfo.microNutrientGoals.molybdenum * widget.servings).toStringAsFixed(1)}µg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.chlorine > 0)
            _buildNutrientRow(
              'Chloride',
              '${(_editableFoodFacts.nutrutionInfo.microNutrientGoals.chlorine * widget.servings).toStringAsFixed(0)}mg',
              '',
            ),
          if (_editableFoodFacts.nutrutionInfo.microNutrientGoals.flouride > 0)
            _buildNutrientRow(
              'Fluoride',
              '${(_editableFoodFacts.nutrutionInfo.microNutrientGoals.flouride * widget.servings).toStringAsFixed(1)}mg',
              '',
            ),

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
}
