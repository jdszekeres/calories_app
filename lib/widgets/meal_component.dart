import 'package:flutter/material.dart';

class MealComponent extends StatelessWidget {
  final String mealName;
  final String mealTime;
  final int calories;
  final VoidCallback? onTap;

  const MealComponent({
    Key? key,
    required this.mealName,
    required this.mealTime,
    required this.calories,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        onTap: onTap,
        title: Text(mealName, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(
          mealTime,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Text(
          '$calories kcal',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
