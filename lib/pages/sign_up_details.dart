import 'package:calories_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../auth.dart';
import '../tools/calculate_goals.dart';

class SignUpDetailsPage extends StatefulWidget {
  final String email;
  final String username;
  final String password;

  const SignUpDetailsPage({
    super.key,
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  State<SignUpDetailsPage> createState() => _SignUpDetailsPageState();
}

class _SignUpDetailsPageState extends State<SignUpDetailsPage> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String selectedSex = 'male';
  ActivityLevel selectedActivityLevel = ActivityLevel.sedentary;
  bool _isLoading = false;
  bool useImperial = false; // added toggle for units

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
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
                  Text(
                    local.tellUs,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    local.tellUsExplain,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: local.age,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.cake),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: Text(local.useImperial),
                    value: useImperial,
                    onChanged: (value) => setState(() => useImperial = value),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: useImperial
                          ? local.weightImperial
                          : local.weight,
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
                      labelText: useImperial
                          ? local.heightImperial
                          : local.height,
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
                    decoration: InputDecoration(
                      labelText: local.sex,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    items: [
                      DropdownMenuItem(value: 'male', child: Text(local.male)),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text(local.female),
                      ),
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
                    decoration: InputDecoration(
                      labelText: local.activityLevel,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.directions_run),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: ActivityLevel.sedentary,
                        child: Text(local.sedentary),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.lightlyActive,
                        child: Text(local.lightlyActive),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.moderatelyActive,
                        child: Text(local.moderatelyActive),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.veryActive,
                        child: Text(local.veryActive),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.extraActive,
                        child: Text(local.extraActive),
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
                        : Text(
                            local.completeSignUp,
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: _isLoading ? null : () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: Text(local.back),
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
        SnackBar(
          content: Text(AppLocalizations.of(context)!.pleaseFillAllFields),
        ),
      );
      return;
    }

    final age = int.tryParse(ageController.text);
    double? weight = double.tryParse(weightController.text);
    double? height = double.tryParse(heightController.text);

    if (age == null || age <= 0 || age > 150) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.invalidAge)),
      );
      return;
    }

    // Convert imperial to metric if needed
    if (useImperial) {
      if (weight != null) weight = weight * 0.453592;
      if (height != null) height = height * 2.54;
    }

    if (weight == null || weight <= 0 || weight > 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.invalidWeight)),
      );
      return;
    }

    if (height == null || height <= 0 || height > 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.invalidHeight)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Auth().signUpWithEmailAndPassword(
        widget.email,
        widget.username,
        widget.password,
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(Auth.prettyPrintError(e))));
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
