import 'package:calories_app/tools/ai.dart';
import 'package:calories_app/tools/food_facts.dart';
import 'package:calories_app/widgets/nutri_facts.dart';
import 'package:flutter/material.dart';
import 'package:calories_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../auth.dart';
import '../tools/meal_database.dart';
import '../tools/ai_credits.dart';

class AiDescPage extends StatefulWidget {
  const AiDescPage({Key? key}) : super(key: key);

  @override
  _AiDescPageState createState() => _AiDescPageState();
}

class _AiDescPageState extends State<AiDescPage> {
  final Auth auth = Auth();
  final TextEditingController _textController = TextEditingController();
  FoodFacts? _foodFacts;
  double _credits = 0.0;
  bool _isLoadingCredits = true;
  bool _isAnalyzing = false;
  String? _lastAnalyzedText;

  @override
  void initState() {
    super.initState();
    _loadCredits();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _loadCredits() async {
    try {
      // Ensure Firebase is initialized
      if (!auth.isInitialized) {
        await Future.delayed(Duration(seconds: 1));
        if (!auth.isInitialized) {
          throw Exception('Firebase not initialized');
        }
      }

      if (auth.currentUser == null) {
        setState(() {
          _credits = 10.0; // Default credits when not authenticated
          _isLoadingCredits = false;
        });
        return;
      }

      final credits = await AiCreditManager().getCredits(auth.currentUser!.uid);
      setState(() {
        _credits = credits;
        _isLoadingCredits = false;
      });
    } catch (e) {
      setState(() {
        _credits = 10.0; // Default credits on error
        _isLoadingCredits = false;
      });
      print('Error loading credits: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load credits. Using default value of 10.'),
          ),
        );
      }
    }
  }

  Future<FoodFacts?> _processAIAnalysis() async {
    if (_credits < 1.0) {
      return null;
    }

    try {
      final result = await AiService().getMealNutritionByDescription(
        _textController.text.trim(),
      );
      // Only deduct credits from database, not locally (database is source of truth)
      await AiCreditManager().deductCredits(auth.currentUser!.uid, 1.0);
      // Reload credits from database to ensure consistency
      await _loadCredits();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  void _handleAnalysis() async {
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

    final text = _textController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a description of your meal')),
      );
      return;
    }

    try {
      setState(() {
        _foodFacts = null; // Reset food facts when new analysis is started
        _isAnalyzing = true;
        _lastAnalyzedText = text;
      });

      // Start the analysis
      try {
        final result = await _processAIAnalysis();
        setState(() {
          _foodFacts = result;
          _isAnalyzing = false;
        });
      } catch (e) {
        setState(() {
          _isAnalyzing = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Analysis failed: ${e.toString()}')),
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
        title: Text('AI Text Analysis'),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoadingCredits = true;
              });
              _loadCredits();
            },
            tooltip: 'Refresh Credits',
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: (_lastAnalyzedText == null)
          ? _buildWelcomeScreen(context)
          : Center(
              child: _isAnalyzing
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Analyzing your meal description...'),
                      ],
                    )
                  : _foodFacts != null
                  ? _buildAnalysisResults()
                  : _buildAnalysisError(),
            ),
    );
  }

  Widget _buildAnalysisResults() {
    return SingleChildScrollView(
      child: Column(
        children: [
          NutriFacts(
            foodFacts: _foodFacts!,
            servings: _foodFacts!.numServings ?? 1,
            servingsEditable: true,
            onEdit: (editedFoodFacts) {
              setState(() {
                _foodFacts = editedFoodFacts;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.nutritionFactsUpdated,
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

  Widget _buildAnalysisError() {
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
          'Failed to analyze description',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _lastAnalyzedText = null;
              _foodFacts = null;
              _textController.clear();
            });
          },
          child: Text(AppLocalizations.of(context)!.tryAgain),
        ),
      ],
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
              Icons.text_fields_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),

          const SizedBox(height: 32),

          // Title and description
          Text(
            'AI-Powered Text Analysis',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          Text(
            'Describe your meal and let our AI analyze its nutritional content instantly',
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

          // Text input field
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _textController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      'Describe your meal (e.g., "grilled chicken breast with steamed broccoli and brown rice")',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Analyze button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _isLoadingCredits ? null : () => _handleAnalysis(),
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
              icon: const Icon(Icons.analytics, size: 24),
              label: Text(
                _isLoadingCredits
                    ? AppLocalizations.of(context)!.loading
                    : _credits < 1.0
                    ? AppLocalizations.of(context)!.insufficientCredits
                    : 'Analyze Description',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: _isLoadingCredits || _credits < 1.0
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

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
                    'Tip: Be specific about ingredients, cooking methods, and portion sizes for best results.',
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
