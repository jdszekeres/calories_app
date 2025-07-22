import 'package:calories_app/tools/meal_database.dart';
import 'package:calories_app/widgets/meal_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../auth.dart';
import '../tools/food_facts.dart';
import '../widgets/bottom_navbar.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final auth = Auth();
  final List<FoodFacts> items = [];
  final DateFormat dateFormat = DateFormat('MM/dd/yyyy hh:mm a');
  // Format for day headers
  final DateFormat headerDateFormat = DateFormat('MM/dd/yyyy');
  @override
  void initState() {
    super.initState();
    MealDatabase().getMeals(auth.currentUser!.uid).then((fetchedItems) {
      setState(() {
        items.addAll(fetchedItems);
        items.sort((a, b) => b.uploaded!.compareTo(a.uploaded!));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Meals')),
      bottomNavigationBar: BottomNavbar(),
      body: ListView.builder(
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
                    headerDateFormat.format(item.uploaded!),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              MealComponent(
                mealName: item.name,
                mealTime: dateFormat.format(item.uploaded!),
                calories: item.nutrutionInfo.calorieGoal as int,
              ),
            ],
          );
        },
      ),
    );
  }
}
