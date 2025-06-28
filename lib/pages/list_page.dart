import 'package:calories_app/widgets/meal_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/bottom_navbar.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

final List<Map<String, dynamic>> items = [
  {'mealName': 'Breakfast', 'mealTime': '8:00 AM', 'calories': 300},
  {'mealName': 'Lunch', 'mealTime': '12:00 PM', 'calories': 600},
  {'mealName': 'Dinner', 'mealTime': '7:00 PM', 'calories': 500},
];

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Page')),
      bottomNavigationBar: BottomNavbar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealComponent(
            mealName: items[index]['mealName'] as String,
            mealTime: items[index]['mealTime'] as String,
            calories: items[index]['calories'] as int,
          );
        },
        itemCount: items.length, // Example item count
      ),
    );
  }
}
