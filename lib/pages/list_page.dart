import 'package:calories_app/l10n/app_localizations.dart';
import 'package:calories_app/tools/meal_database.dart';
import 'package:calories_app/widgets/meal_component.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../auth.dart';
import '../tools/food_facts.dart';
import '../widgets/bottom_navbar.dart';
import 'meal_details.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final auth = Auth();
  final List<FoodFacts> items = [];
  final MealDatabase mealDatabase = MealDatabase();
  final ScrollController _scrollController = ScrollController();
  DateFormat? dateFormat;
  // Format for day headers
  DateFormat? headerDateFormat;
  @override
  void initState() {
    super.initState();
    mealDatabase.getMeals(auth.currentUser!.uid).then((fetchedItems) {
      setState(() {
        items.addAll(fetchedItems);
        items.sort((a, b) => b.uploaded!.compareTo(a.uploaded!));
      });
    });
  }

  Future<void> _reAddMeal(FoodFacts originalMeal) async {
    try {
      // Create a copy of the meal with current timestamp
      final copiedMeal = FoodFacts(
        name: originalMeal.name,
        servingSize: originalMeal.servingSize,
        numServings: originalMeal.numServings,
        uploaded: DateTime.now(),
        image: originalMeal.image,
        ingredients: originalMeal.ingredients,
        nutrutionInfo: originalMeal.nutrutionInfo,
      );

      // Add the copied meal to the database
      await mealDatabase.addMeal(auth.currentUser!.uid, copiedMeal);

      // Add to local list and refresh the UI
      setState(() {
        items.add(copiedMeal);
        items.sort((a, b) => b.uploaded!.compareTo(a.uploaded!));
      });
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    // Initialize locale-aware formats once context is available
    dateFormat ??= DateFormat.yMd(
      Localizations.localeOf(context).toString(),
    ).add_jm();
    headerDateFormat ??= DateFormat.yMd(
      Localizations.localeOf(context).toString(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(local.myMeals),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      bottomNavigationBar: BottomNavbar(),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(local.noMealsFound),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.go("/add");
                    },
                    child: Text(local.addMeal),
                  ),
                ],
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final currentDay = DateTime(
                  item.uploaded!.year,
                  item.uploaded!.month,
                  item.uploaded!.day,
                );
                final showHeader =
                    index == 0 ||
                    DateTime(
                          items[index - 1].uploaded!.year,
                          items[index - 1].uploaded!.month,
                          items[index - 1].uploaded!.day,
                        ) !=
                        currentDay;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showHeader)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: Text(
                          headerDateFormat!.format(item.uploaded!),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    MealComponent(
                      mealName: item.name,
                      mealTime: dateFormat!.format(item.uploaded!),
                      calories:
                          ((item.nutrutionInfo.calorieGoal as num) *
                          (item.numServings ?? 1)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MealDetails(
                              foodFacts: item,
                              onEdit: (editedFoodFacts) {
                                setState(() {
                                  items[index] = editedFoodFacts;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      onReAdd: () => _reAddMeal(item),
                    ),
                  ],
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
