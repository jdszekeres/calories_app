import 'package:calories_app/tools/food_facts.dart';
import 'package:flutter/material.dart';

class ServingsSelector extends StatefulWidget {
  final double initialServings;
  final ValueChanged<double> onServingsChanged;
  final FoodFacts data;

  const ServingsSelector({
    Key? key,
    required this.initialServings,
    required this.onServingsChanged,
    required this.data,
  }) : super(key: key);

  @override
  _ServingsSelectorState createState() => _ServingsSelectorState();
}

class _ServingsSelectorState extends State<ServingsSelector> {
  late double servings;

  int max = 5;

  @override
  void didUpdateWidget(covariant ServingsSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    servings = widget.initialServings;
  }

  @override
  void initState() {
    super.initState();
    servings = widget.initialServings;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.data.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 10),
        Image.network(
          widget.data.image ?? '',
          height: MediaQuery.of(context).size.height / 3,
        ),
        const SizedBox(height: 10),
        Text(
          'Serving Size: ${widget.data.servingSize}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Slider(
          value: servings,
          min: 0,
          max: max.toDouble(),
          divisions: max * 10,
          label: servings.toStringAsFixed(1),
          onChangeEnd: (value) {
            if (value == max) {
              setState(() {
                max += 5; // Increase max by 5 when it reaches the current max
              });
            }
          },
          onChanged: (value) {
            setState(() {
              servings = value;
            });
          },
        ),
        Text(
          '${servings.toStringAsFixed(1)} Servings',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        ElevatedButton(
          onPressed: () {
            widget.onServingsChanged(servings);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
