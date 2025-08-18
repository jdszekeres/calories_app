import 'package:calories_app/tools/ai.dart';
import 'package:calories_app/tools/food_facts.dart';
import 'package:calories_app/widgets/nutri_facts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:calories_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../auth.dart';
import '../tools/meal_database.dart';
import '../tools/ai_credits.dart';

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
  double _credits = 0.0;
  bool _isLoadingCredits = true;

  @override
  void initState() {
    super.initState();
    _loadCredits();
  }

  Future<void> _loadCredits() async {
    try {
      final credits = await AiCreditManager().getCredits(auth.currentUser!.uid);
      setState(() {
        _credits = credits;
        _isLoadingCredits = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingCredits = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorWithMessage(e)),
          ),
        );
      }
    }
  }

  Future<FoodFacts?> _processAIAnalysis() async {
    if (_credits < 1.0) {
      throw Exception(AppLocalizations.of(context)!.aiCreditDescription);
    }

    try {
      // Deduct credits first
      await AiCreditManager().deductCredits(auth.currentUser!.uid, 1.0);

      // Update credits in UI
      setState(() {
        _credits -= 1.0;
      });

      // Perform AI analysis
      final result = await AiService().getMealNutrition(_imageData!);
      return result;
    } catch (e) {
      // If AI analysis failed, refund the credit
      try {
        await AiCreditManager().addCredits(auth.currentUser!.uid, 1.0);
        setState(() {
          _credits += 1.0;
        });
      } catch (refundError) {
        debugPrint('Failed to refund credit: $refundError');
      }
      rethrow;
    }
  }

  void _handleImageSelection(
    Future<Uint8List?> Function() selectFunction,
  ) async {
    if (_isLoadingCredits) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.loadingCredits)),
      );
      return;
    }

    if (_credits < 1.0) {
      _showInsufficientCreditsDialog();
      return;
    }

    try {
      final imageData = await selectFunction();
      if (imageData != null) {
        setState(() {
          _imageData = imageData;
          _foodFacts = null; // Reset food facts when new image is selected
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.noImageSelected),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorWithMessage(e)),
          ),
        );
      }
    }
  }

  void _showInsufficientCreditsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.insufficientCredits),
          content: Text(
            AppLocalizations.of(
              context,
            )!.insufficientCreditsMessage(_credits.toInt()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.ok),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go('/settings');
              },
              child: Text(AppLocalizations.of(context)!.goToSettings),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aiNutritionAnalysisTitle),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: (_imageData == null)
          ? _buildWelcomeScreen(context)
          : Center(
              child: FutureBuilder(
                future: _processAIAnalysis(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.aiAnalysisDescription,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    debugPrintStack(stackTrace: snapshot.stackTrace);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(
                            context,
                          )!.errorWithMessage(snapshot.error!),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _imageData = null;
                              _foodFacts = null;
                            });
                          },
                          child: Text(AppLocalizations.of(context)!.tryAgain),
                        ),
                      ],
                    );
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
                      return Text(
                        AppLocalizations.of(context)!.errorWithMessage(
                          AppLocalizations.of(context)!.failedToAnalyzeImage,
                        ),
                      );
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
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.nutritionFactsUpdated,
                                  ),
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
                            child: Text(AppLocalizations.of(context)!.save),
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
            AppLocalizations.of(context)!.aiPoweredNutritionAnalysis,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          Text(
            AppLocalizations.of(context)!.aiAnalysisDescription,
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
                    AppLocalizations.of(context)!.whatAiCanIdentify,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    context,
                    Icons.restaurant,
                    AppLocalizations.of(context)!.foodIdentification,
                  ),
                  _buildFeatureItem(
                    context,
                    Icons.straighten,
                    AppLocalizations.of(context)!.portionEstimation,
                  ),
                  _buildFeatureItem(
                    context,
                    Icons.local_fire_department,
                    AppLocalizations.of(context)!.calorieCalculation,
                  ),
                  _buildFeatureItem(
                    context,
                    Icons.science,
                    AppLocalizations.of(context)!.macroMicronutrients,
                  ),
                  _buildFeatureItem(
                    context,
                    Icons.list_alt,
                    AppLocalizations.of(context)!.ingredientBreakdown,
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
              onPressed: _isLoadingCredits
                  ? null
                  : () => _handleImageSelection(selectImage),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isLoadingCredits || _credits < 1.0
                    ? Theme.of(context).colorScheme.surfaceVariant
                    : Theme.of(context).colorScheme.primary,
                foregroundColor: _isLoadingCredits || _credits < 1.0
                    ? Theme.of(context).colorScheme.onSurfaceVariant
                    : Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: _isLoadingCredits || _credits < 1.0 ? 0 : 3,
              ),
              icon: const Icon(Icons.upload_file, size: 24),
              label: Text(
                _isLoadingCredits
                    ? AppLocalizations.of(context)!.loading
                    : _credits < 1.0
                    ? AppLocalizations.of(context)!.insufficientCredits
                    : AppLocalizations.of(context)!.uploadPhoto,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: _isLoadingCredits || _credits < 1.0
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (!kIsWeb)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _isLoadingCredits
                    ? null
                    : () => _handleImageSelection(selectImageFromGallery),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isLoadingCredits || _credits < 1.0
                      ? Theme.of(context).colorScheme.surfaceVariant
                      : Theme.of(context).colorScheme.primary,
                  foregroundColor: _isLoadingCredits || _credits < 1.0
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: _isLoadingCredits || _credits < 1.0 ? 0 : 3,
                ),
                icon: const Icon(Icons.camera_alt, size: 24),
                label: Text(
                  _isLoadingCredits
                      ? AppLocalizations.of(context)!.loading
                      : _credits < 1.0
                      ? AppLocalizations.of(context)!.insufficientCredits
                      : AppLocalizations.of(context)!.takePhoto,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: _isLoadingCredits || _credits < 1.0
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          Text(
            _isLoadingCredits
                ? AppLocalizations.of(context)!.loadingCredits
                : AppLocalizations.of(context)!.creditCount(_credits.toInt()),
            style: TextStyle(
              color: _credits < 1.0
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
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
                    AppLocalizations.of(context)!.aiTipMessage,
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
}
