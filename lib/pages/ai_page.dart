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
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          NutriFacts(
                            foodFacts: snapshot.data!,
                            servings: snapshot.data!.numServings ?? 1,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (snapshot.data!.numServings != null) {
                                await MealDatabase().addMeal(
                                  auth.currentUser!.uid,
                                  snapshot.data!,
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
