import 'package:calories_app/tools/meal_database.dart';
import 'package:calories_app/widgets/meal_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  @override
  void initState() {
    super.initState();
    MealDatabase().getMeals(auth.currentUser!.uid).then((fetchedItems) {
      setState(() {
        items.addAll(fetchedItems);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meals Today')),
      bottomNavigationBar: BottomNavbar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealComponent(
            mealName: items[index].name,
            mealTime: items[index].uploaded.toString(),
            calories: items[index].nutrutionInfo.calorieGoal as int,
          );
        },
        itemCount: items.length, // Example item count
      ),
    );
  }
}
