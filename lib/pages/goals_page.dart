import 'package:calories_app/l10n/app_localizations.dart';
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
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return IOSSettingsTile(
      tileType: SettingsTileType.simpleTile,
      leading: leading,
      title: Text(name),
      description: null,
      onPressed: (BuildContext context) {
        TextEditingController controller = TextEditingController(
          text: goal.roundToDouble() == goal
              ? goal.toString()
              : goal.toStringAsFixed(1),
        );
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(localizations.setGoalFor(name)),
              content: TextField(
                keyboardType: TextInputType.number,
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: localizations.goal,
                  hintText: localizations.enterGoal,
                  suffixText: unit,
                ),
                onSubmitted: (value) {
                  double? newGoal = double.tryParse(value);
                  if (newGoal != null) {
                    Navigator.of(context).pop();
                    onGoalChanged(newGoal);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(localizations.invalidInput)),
                    );
                  }
                },
              ),
              actions: [
                TextButton(
                  child: Text(localizations.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(localizations.setGoal),
                  onPressed: () {
                    double? newGoal = double.tryParse(controller.text);
                    if (newGoal != null) {
                      Navigator.of(context).pop();
                      onGoalChanged(newGoal);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(localizations.invalidInput)),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
      trailing: Row(
        children: [
          Text(
            achieved.roundToDouble() == achieved
                ? achieved.toString()
                : achieved.toStringAsFixed(1),
          ),
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
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  bool _isLoading = true;
  String? _errorMessage;
  NutrutionGoals? goals;
  List<FoodFacts> meals = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Fetch both goals and meals in parallel
      final futures = await Future.wait([
        UserDatabase().getNutritionGoals(Auth().currentUser!.uid),
        MealDatabase().getMealsByDate(Auth().currentUser!.uid, DateTime.now()),
      ]);

      final fetchedGoals = futures[0] as NutrutionGoals?;
      final fetchedMeals = futures[1] as List<FoodFacts>;

      if (!mounted) return;

      setState(() {
        goals = fetchedGoals;
        meals = fetchedMeals;
        _isLoading = false;
      });

      // Handle case where no goals are found
      if (fetchedGoals == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.noGoalsFound)),
          );
          context.go('/settings');
        }
      }
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = AppLocalizations.of(
          context,
        )!.errorLoadingData(error.toString());
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.errorLoadingGoals(error.toString()),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jsonGoals = goals?.toJson() ?? {};
    AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.dailyGoals),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      bottomNavigationBar: BottomNavbar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });
                      _loadData();
                    },
                    child: Text(localizations.retry),
                  ),
                ],
              ),
            )
          : goals != null
          ? SettingsList(
              lightTheme: SettingsThemeData(
                settingsListBackground: Colors.transparent,
              ),
              darkTheme: SettingsThemeData(
                settingsListBackground: Colors.transparent,
              ),
              key: ValueKey(goals),
              sections: jsonGoals.keys.toList().map((key) {
                return SettingsSection(
                  title: Text(NutrutionGoals.getName(context, key)),
                  tiles: jsonGoals[key].keys
                      .toList()
                      .map((goalName) {
                        return GoalAmount(
                          name: NutrutionGoals.getName(context, goalName),
                          // leading: Icon(Icons.check_circle_outline),
                          goal: (jsonGoals[key][goalName] as num).toDouble(),
                          achieved: meals.fold(0.0, (sum, meal) {
                            return sum +
                                ((meal.nutrutionInfo.toJson()[key][goalName]
                                                as num?)
                                            ?.toDouble() ??
                                        0.0) *
                                    (meal.numServings ?? 1);
                          }),
                          onGoalChanged: (newGoal) {
                            UserDatabase().updateNutritionGoal(
                              Auth().currentUser!.uid,
                              goalName,
                              newGoal,
                            );
                            setState(() {
                              // Update local goals by reconstructing the NutrutionGoals object
                              final currentGoals = goals!;
                              final goalsJson = currentGoals.toJson();
                              // Mutate the JSON map for this goal
                              goalsJson[key][goalName] = newGoal;
                              // Replace goals with new object
                              goals = NutrutionGoals.fromJson(goalsJson);
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
          : Center(
              child: Text(
                localizations.noGoalsFound,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
