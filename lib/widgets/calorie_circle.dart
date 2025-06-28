import 'dart:math' as math;

import 'package:flutter/material.dart';

class CalorieCircle extends StatelessWidget {
  final double calories;
  final double maxCalories;

  const CalorieCircle({
    Key? key,
    required this.calories,
    required this.maxCalories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      alignment: Alignment.center,
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.3,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.surfaceDim,
                Theme.of(context).colorScheme.surfaceDim,
              ],
              stops: [0, calories / maxCalories, calories / maxCalories, 1],
              transform: GradientRotation(-90 * math.pi / 180),
            ),
          ),
          child: Center(
            child: Text(
              '${(calories / maxCalories * 100).toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
