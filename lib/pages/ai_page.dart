import 'package:calories_app/tools/ai.dart';
import 'package:calories_app/tools/food_facts.dart';
import 'package:calories_app/widgets/nutri_facts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../auth.dart';
import '../tools/meal_database.dart';

import '../tools/select_image.dart';

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
      appBar: AppBar(
        title: const Text('AI Nutrition Analysis'),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body:
          (_imageData == null)
              ? _buildWelcomeScreen(context)
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
                      if (_foodFacts == null && snapshot.data != null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            _foodFacts = snapshot.data;
                          });
                        });
                        // Show loading while state updates
                        return CircularProgressIndicator();
                      } else if (_foodFacts == null) {
                        // If snapshot.data is null, show error
                        return Text('Failed to analyze image');
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

  Widget _buildWelcomeScreen(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),

          // Hero icon
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),

          const SizedBox(height: 32),

          // Title and description
          Text(
            'AI-Powered Nutrition Analysis',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          Text(
            'Upload a photo of your meal and let our AI analyze its nutritional content instantly',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          // Features card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'What our AI can identify:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    context,
                    Icons.restaurant,
                    'Food identification',
                  ),
                  _buildFeatureItem(
                    context,
                    Icons.straighten,
                    'Portion estimation',
                  ),
                  _buildFeatureItem(
                    context,
                    Icons.local_fire_department,
                    'Calorie calculation',
                  ),
                  _buildFeatureItem(
                    context,
                    Icons.science,
                    'Macro & micronutrients',
                  ),
                  _buildFeatureItem(
                    context,
                    Icons.list_alt,
                    'Ingredient breakdown',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Upload button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {
                selectImage().then((imageData) {
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
              ),
              icon: const Icon(Icons.upload_file, size: 24),
              label: Text(
                'Upload Photo',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Tip card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Tip: For best results, take a clear photo with good lighting and include the entire meal in frame.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildAnalysisScreen(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: AiService().getMealNutrition(_imageData!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingState(context);
          } else if (snapshot.hasError) {
            print(snapshot.stackTrace);
            return _buildErrorState(context, snapshot.error.toString());
          } else {
            // Initialize _foodFacts if not already set
            if (_foodFacts == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _foodFacts = snapshot.data!;
                });
              });
              // Show loading while state updates
              return _buildLoadingState(context);
            }

            return _buildResultsState(context);
          }
        },
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Analyzing your meal...',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Our AI is identifying the food and calculating nutrition facts',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onBackground.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Analysis Failed',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We couldn\'t analyze your image. Please try again with a clearer photo.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onBackground.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _imageData = null;
                _foodFacts = null;
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsState(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Success header
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Analysis Complete!',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Review and edit the nutrition facts below',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _imageData = null;
                        _foodFacts = null;
                      });
                    },
                    icon: const Icon(Icons.photo_camera),
                    tooltip: 'Upload new photo',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Nutrition facts
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

          const SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _imageData = null;
                      _foodFacts = null;
                    });
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('New Photo'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_foodFacts!.numServings != null) {
                      await MealDatabase().addMeal(
                        auth.currentUser!.uid,
                        _foodFacts!,
                      );
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Meal saved successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      context.go('/');
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save to Diary'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
