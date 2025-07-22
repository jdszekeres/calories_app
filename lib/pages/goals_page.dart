import 'package:calories_app/pages/home_page.dart';
import 'package:calories_app/tools/calculate_goals.dart';
import 'package:calories_app/tools/meal_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:settings_ui/src/tiles/platforms/ios_settings_tile.dart';

import '../auth.dart';
import '../tools/camel_to_normal.dart';
import '../tools/food_facts.dart';
import '../tools/user_database.dart' show UserDatabase;
import '../widgets/bottom_navbar.dart';

class GoalAmount extends AbstractSettingsTile {
  final String name;
  final Widget? leading;

  final double goal;
  final double achieved;
  final String? unit;

  final Function(double) onGoalChanged;

  const GoalAmount({
    required this.name,

    required this.onGoalChanged,
    this.goal = 0.0,
    this.achieved = 0.0,
    this.unit,
    this.leading,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IOSSettingsTile(
      tileType: SettingsTileType.simpleTile,
      leading: leading,
      title: Text(name),
      description: null,
      onPressed: (BuildContext context) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Set Goal for ${name.toString()}'),
              content: TextField(
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: 'Goal',
                  hintText: 'Enter your goal',
                  suffixText: unit,
                ),
                onSubmitted: (value) {
                  double? newGoal = double.tryParse(value);
                  if (newGoal != null) {
                    Navigator.of(context).pop();
                    onGoalChanged(newGoal);
                    // Removed navigation to allow immediate UI update
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Invalid input')));
                  }
                },
              ),
            );
          },
        );
      },
      trailing: Row(
        children: [
          Text(achieved.toString()),
          Text("/"),
          Text(
            (goal.roundToDouble() == goal
                    ? goal.toString()
                    : goal.toStringAsFixed(1)) +
                (unit != null ? " $unit" : "").toString(),
          ),
        ],
      ),
      onToggle: (bool value) {},
      value: null,
      initialValue: null,
      activeSwitchColor: null,
      enabled: true,
    );
  }
}

class GoalsPage extends StatefulWidget {
  GoalsPage({super.key});

  NutrutionGoals? goals;
  List<FoodFacts> meals = [];

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch the user's nutrition goals from the database
    UserDatabase().getNutritionGoals(Auth().currentUser!.uid).then((goals) {
      if (goals != null) {
        setState(() {
          widget.goals = goals;
        });
      } else {
        // If no goals are found, redirect to the home page
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No goals found. Please set your goals.')),
          );
          context.go('/settings');
        }
      }
    });
    MealDatabase().getMealsByDate(Auth().currentUser!.uid, DateTime.now()).then(
      (meals) {
        setState(() {
          widget.meals = meals;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jsonGoals = widget.goals?.toJson() ?? {};

    return Scaffold(
      appBar: AppBar(title: const Text('Daily Goals')),
      bottomNavigationBar: BottomNavbar(),
      body: (widget.goals != null)
          ? SettingsList(
              key: ValueKey(widget.goals),
              sections: jsonGoals.keys.toList().map((key) {
                return SettingsSection(
                  title: Text(camelToNormal(key)),
                  tiles: jsonGoals[key].keys
                      .toList()
                      .map((goalName) {
                        return GoalAmount(
                          name: camelToNormal(goalName),
                          // leading: Icon(Icons.check_circle_outline),
                          goal: jsonGoals[key][goalName] as double,
                          achieved: widget.meals.fold(0.0, (sum, meal) {
                            return sum +
                                (meal.nutrutionInfo.toJson()[key][goalName] ??
                                    0.0);
                          }),
                          onGoalChanged: (newGoal) {
                            UserDatabase().updateNutritionGoal(
                              Auth().currentUser!.uid,
                              goalName,
                              newGoal,
                            );
                            setState(() {
                              // Update local goals by reconstructing the NutrutionGoals object
                              final currentGoals = widget.goals!;
                              final goalsJson = currentGoals.toJson();
                              // Mutate the JSON map for this goal
                              goalsJson[key][goalName] = newGoal;
                              // Replace widget.goals with new object
                              widget.goals = NutrutionGoals.fromJson(goalsJson);
                            });
                          },
                          unit: NutrutionGoals.getUnit(
                            goalName,
                          ).replaceAll("kcal", "cal"),
                        );
                      })
                      .toList()
                      .cast<AbstractSettingsTile>(),
                );
              }).toList(),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
