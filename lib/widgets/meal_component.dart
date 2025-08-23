import 'package:flutter/material.dart';
import 'package:calories_app/l10n/app_localizations.dart';

class MealComponent extends StatelessWidget {
  final String mealName;
  final String mealTime;
  final num calories;
  final VoidCallback? onTap;
  final VoidCallback? onReAdd;
  final VoidCallback? onDelete;

  const MealComponent({
    Key? key,
    required this.mealName,
    required this.mealTime,
    required this.calories,
    this.onTap,
    this.onReAdd,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(mealName + mealTime),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete?.call();
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          onTap: onTap,
          title: Text(mealName, style: Theme.of(context).textTheme.titleLarge),
          subtitle: Text(
            mealTime,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${calories.toStringAsFixed(1)} ${AppLocalizations.of(context)!.unitKcal}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (onReAdd != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.replay),
                  onPressed: onReAdd,
                  tooltip: AppLocalizations.of(context)!.reAddMeal,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
