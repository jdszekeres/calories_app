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
  final Widget name;
  final Widget? leading;

  final double goal;
  final double achieved;
  final String? unit;

  final dynamic onGoalChanged;

  const GoalAmount({
    required this.name,

    this.onGoalChanged,
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
      title: name,
      description: null,
      onPressed: onGoalChanged != null
          ? (BuildContext context) {
              onGoalChanged();
            }
          : null,
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
              sections: jsonGoals.keys.toList().map((key) {
                return SettingsSection(
                  title: Text(camelToNormal(key)),
                  tiles: jsonGoals[key].keys
                      .toList()
                      .map((goalName) {
                        return GoalAmount(
                          name: Text(camelToNormal(goalName)),
                          // leading: Icon(Icons.check_circle_outline),
                          goal: jsonGoals[key][goalName] as double,
                          achieved: widget.meals.fold(0.0, (sum, meal) {
                            return sum +
                                (meal.nutrutionInfo.toJson()[key][goalName] ??
                                    0.0);
                          }),
                          unit: NutrutionGoals.getUnit(goalName),
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
