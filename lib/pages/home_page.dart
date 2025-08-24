import 'package:calories_app/widgets/calorie_circle.dart';
import 'package:calories_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';

import '../auth.dart';
import '../tools/calculate_goals.dart';
import '../tools/food_facts.dart';
import '../tools/meal_database.dart';
import '../tools/settings_database.dart';
import '../tools/user_database.dart';
import '../widgets/bottom_navbar.dart';

class TypeIndicator extends StatelessWidget {
  final String type;
  final double goal;

  const TypeIndicator({super.key, required this.type, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              type,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onInverseSurface,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                minHeight: 8,
                value: goal.isNaN ? 0 : goal,
                backgroundColor: Theme.of(context).colorScheme.surfaceDim,
                color: Color.lerp(
                  Colors.white,
                  Theme.of(context).colorScheme.primary,
                  (0.4 + goal).clamp(0, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final SettingsDatabase settingsDatabase = SettingsDatabase();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NutrutionGoals? goals;
  List<FoodFacts> meals = [];
  List<String> selectedWidgets = [];
  Map<String, dynamic> settings = {};
  bool hasSeenOnboarding = false;
  bool showcaseStarted = false; // Add this to prevent duplicate triggers

  // Global keys for onboarding
  final GlobalKey calorieCircleKey = GlobalKey();
  final GlobalKey nutrientBarsKey = GlobalKey();
  final GlobalKey homeButtonKey = GlobalKey();
  final GlobalKey goalsButtonKey = GlobalKey();
  final GlobalKey addButtonKey = GlobalKey();
  final GlobalKey listButtonKey = GlobalKey();
  final GlobalKey settingsButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    UserDatabase().getNutritionGoals(Auth().currentUser!.uid).then((
      fetchedGoals,
    ) {
      if (fetchedGoals != null) {
        setState(() {
          goals = fetchedGoals;
        });
      } else {
        // If no goals are found, redirect to the home page
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.noGoalsFound)),
          );
          context.go('/settings');
        }
      }
    });
    MealDatabase().getMealsByDate(Auth().currentUser!.uid, DateTime.now()).then(
      (fetchedMeals) {
        setState(() {
          meals = fetchedMeals;
        });
      },
    );
    widget.settingsDatabase.getSettings(Auth().currentUserId!).then((
      fetchedSettings,
    ) {
      setState(() {
        settings = fetchedSettings;
        // Initialize selectedWidgets from settings or use default list
        selectedWidgets =
            settings['homePageWidgets']?.cast<String>() ??
            ['calories', 'protein', 'carbohydrates', 'fat'];
        // Check if user has seen onboarding
        hasSeenOnboarding = settings['hasSeenOnboarding'] ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      onStart: (index, key) {
        // Optional: Handle showcase start
      },
      onComplete: (index, key) {
        // Mark onboarding as completed when the showcase ends
        widget.settingsDatabase.updateSetting(
          Auth().currentUserId!,
          'hasSeenOnboarding',
          true,
        );
        setState(() {
          hasSeenOnboarding = true;
          showcaseStarted = false; // Reset for potential future use
        });
      },
      blurValue: 1,
      builder: (context) {
        // Trigger onboarding after the widget is built, but only if:
        // 1. User hasn't seen onboarding before
        // 2. Goals are loaded (so UI is ready)
        // 3. Showcase hasn't been started yet (prevent multiple triggers)
        // 4. Settings have been loaded (hasSeenOnboarding is determined)
        if (!hasSeenOnboarding &&
            goals != null &&
            !showcaseStarted &&
            settings.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              showcaseStarted = true;
            });
            ShowCaseWidget.of(context).startShowCase([
              calorieCircleKey,
              nutrientBarsKey,
              addButtonKey,
              goalsButtonKey,
              listButtonKey,
              settingsButtonKey,
            ]);
          });
        }

        return Scaffold(
          // appBar: AppBar(title: const Text('Home Page')),
          bottomNavigationBar: BottomNavbar(
            homeButtonKey: homeButtonKey,
            goalsButtonKey: goalsButtonKey,
            addButtonKey: addButtonKey,
            listButtonKey: listButtonKey,
            settingsButtonKey: settingsButtonKey,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,

          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Showcase(
                    key: calorieCircleKey,
                    title: AppLocalizations.of(context)!.onboardingWelcome,
                    description: AppLocalizations.of(
                      context,
                    )!.onboardingCalorieCircle,
                    child: CalorieCircle(
                      calories: meals.fold(
                        0,
                        (sum, meal) =>
                            sum +
                            (meal.nutrutionInfo.calorieGoal *
                                (meal.numServings ?? 1)),
                      ),
                      maxCalories: goals?.calorieGoal ?? 2000,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Showcase(
                    key: nutrientBarsKey,
                    title: AppLocalizations.of(
                      context,
                    )!.onboardingNutrientTitle,
                    description: AppLocalizations.of(
                      context,
                    )!.onboardingNutrientDescription,
                    child: Card.filled(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: selectedWidgets
                              .map(
                                (nutrient) => TypeIndicator(
                                  type: NutrutionGoals.getName(
                                    context,
                                    nutrient,
                                  ),
                                  goal: (goals == null)
                                      ? 1.0
                                      : (() {
                                          final key = NutrutionGoals.getKey(
                                            nutrient,
                                          );
                                          // Safely extract target or default to 0.0
                                          final target =
                                              (goals!.toJson()[key][nutrient]
                                                      as num?)
                                                  ?.toDouble() ??
                                              0.0;
                                          // Sum consumed amount for this nutrient
                                          final consumed = meals.fold(
                                            0.0,
                                            (sum, meal) =>
                                                sum +
                                                ((meal.nutrutionInfo.toJson()[key][nutrient]
                                                                as num?)
                                                            ?.toDouble() ??
                                                        0.0) *
                                                    (meal.numServings ?? 1),
                                          );
                                          // If target is zero, avoid division by zero
                                          return target > 0
                                              ? consumed / target
                                              : consumed / 0.000001;
                                        })(),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
