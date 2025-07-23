import 'package:calories_app/tools/ai.dart';
import 'package:calories_app/tools/food_facts.dart';
import 'package:calories_app/widgets/nutri_facts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../auth.dart';
import '../tools/meal_database.dart';

class AiPage extends StatefulWidget {
  const AiPage({Key? key}) : super(key: key);

  @override
  _AiPageState createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final Auth auth = Auth();
  Uint8List? _imageData;
  FoodFacts? _foodFacts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Nutrition Analysis')),
      body: (_imageData == null)
          ? Center(
              child: ElevatedButton(
                onPressed: () {
                  ImagePickerWeb.getImageAsBytes().then((imageData) {
                    if (imageData != null) {
                      setState(() {
                        _imageData = imageData;
                        _foodFacts =
                            null; // Reset food facts when new image is selected
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No image selected')),
                      );
                    }
                  });
                },
                child: const Text('Upload Image'),
              ),
            )
          : Center(
              child: FutureBuilder(
                future: AiService().getMealNutrition(_imageData!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print(snapshot.stackTrace);
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Initialize _foodFacts if not already set
                    if (_foodFacts == null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _foodFacts = snapshot.data!;
                        });
                      });
                      // Show loading while state updates
                      return CircularProgressIndicator();
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          NutriFacts(
                            foodFacts: _foodFacts!,
                            servings: _foodFacts!.numServings ?? 1,
                            onEdit: (editedFoodFacts) {
                              setState(() {
                                _foodFacts = editedFoodFacts;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Nutrition facts updated!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_foodFacts!.numServings != null) {
                                await MealDatabase().addMeal(
                                  auth.currentUser!.uid,
                                  _foodFacts!,
                                );
                              }
                              if (!mounted) return;
                              context.go('/');
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
    );
  }
}
