import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../auth.dart';
import '../tools/calculate_goals.dart';
import '../tools/user_profile.dart';

class SignInAnon extends StatefulWidget {
  const SignInAnon({Key? key}) : super(key: key);

  @override
  _SignInAnonState createState() => _SignInAnonState();
}

class _SignInAnonState extends State<SignInAnon> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String selectedSex = 'male';
  ActivityLevel selectedActivityLevel = ActivityLevel.sedentary;
  bool _isLoading = false;
  bool useImperial = false; // added toggle for units

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      // // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () => context.pop(),
      //   ),
      // ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Creating an Anonymous Account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We still need some information to set up your profile and calculate your goals.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.cake),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Use Imperial Units'),
                    value: useImperial,
                    onChanged: (value) => setState(() => useImperial = value),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: useImperial ? 'Weight (lb)' : 'Weight (kg)',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.fitness_center),
                      suffixText: useImperial ? 'lb' : 'kg',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: heightController,
                    decoration: InputDecoration(
                      labelText: useImperial ? 'Height (in)' : 'Height (cm)',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.height),
                      suffixText: useImperial ? 'in' : 'cm',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedSex,
                    decoration: const InputDecoration(
                      labelText: 'Sex',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'male', child: Text('Male')),
                      DropdownMenuItem(value: 'female', child: Text('Female')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedSex = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<ActivityLevel>(
                    value: selectedActivityLevel,
                    decoration: const InputDecoration(
                      labelText: 'Activity Level',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.directions_run),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: ActivityLevel.sedentary,
                        child: Text('Sedentary (little or no exercise)'),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.lightlyActive,
                        child: Text(
                          'Lightly Active (light exercise 1-3 days/week)',
                        ),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.moderatelyActive,
                        child: Text(
                          'Moderately Active (moderate exercise 3-5 days/week)',
                        ),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.veryActive,
                        child: Text(
                          'Very Active (hard exercise 6-7 days/week)',
                        ),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.extraActive,
                        child: Text(
                          'Extra Active (very hard exercise & physical job)',
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedActivityLevel = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Complete Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: _isLoading ? null : () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignUp() async {
    // Validate form
    if (ageController.text.isEmpty ||
        weightController.text.isEmpty ||
        heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final age = int.tryParse(ageController.text);
    double? weight = double.tryParse(weightController.text);
    double? height = double.tryParse(heightController.text);

    if (age == null || age <= 0 || age > 150) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a valid age')));
      return;
    }

    // Convert imperial to metric if needed
    if (useImperial) {
      if (weight != null) weight = weight * 0.453592;
      if (height != null) height = height * 2.54;
    }

    if (weight == null || weight <= 0 || weight > 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid weight')),
      );
      return;
    }

    if (height == null || height <= 0 || height > 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid height')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Auth().signInAnonymously(
        age,
        weight,
        height,
        selectedActivityLevel,
        selectedSex,
      );

      if (context.mounted) {
        context.go('/');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
