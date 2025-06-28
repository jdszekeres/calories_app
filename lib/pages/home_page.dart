import 'package:calories_app/widgets/calorie_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            width: 80,
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
                value: goal,
                backgroundColor: Theme.of(context).colorScheme.surfaceDim,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      bottomNavigationBar: BottomNavbar(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CalorieCircle(calories: 850, maxCalories: 2000),
          const SizedBox(height: 20),
          Card.filled(
            color: Theme.of(context).colorScheme.inverseSurface,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TypeIndicator(type: 'Calories', goal: 0.425),
                  TypeIndicator(type: 'Protein', goal: 0.3),
                  TypeIndicator(type: 'Carbs', goal: 0.5),
                  TypeIndicator(type: 'Fats', goal: 0.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
