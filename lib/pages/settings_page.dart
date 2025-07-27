import 'package:calories_app/tools/calculate_goals.dart';
import 'package:calories_app/tools/camel_to_normal.dart';
import 'package:calories_app/tools/settings_database.dart';
import 'package:calories_app/tools/user_database.dart';
import 'package:calories_app/tools/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';

import '../auth.dart';
import '../widgets/bottom_navbar.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  final SettingsDatabase settingsDatabase = SettingsDatabase();

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Map<String, dynamic>? _settings;
  final Auth auth = Auth();

  @override
  void initState() {
    super.initState();
    widget.settingsDatabase.getSettings(Auth().currentUserId!).then((settings) {
      setState(() {
        _settings = settings;
      });
    });
  }

  void _showWidgetSelectionDialog(BuildContext context) {
    // Get current widget settings or set defaults
    List<String> availableWidgets = NutrutionGoals.keys;
    List<String> selectedWidgets =
        _settings?['homePageWidgets']?.cast<String>() ??
        [
          'calories',
          'protein',
          'carbohydrates',
          'fat',
        ]; // Default to all widgets

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Select Home Page Widgets'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: availableWidgets.map((widget) {
                    return CheckboxListTile(
                      title: Text(widget),
                      value: selectedWidgets.contains(widget),
                      onChanged: (bool? value) {
                        setDialogState(() {
                          if (value == true) {
                            if (!selectedWidgets.contains(widget)) {
                              selectedWidgets.add(widget);
                            }
                          } else {
                            selectedWidgets.remove(widget);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Save the selected widgets to settings
                    widget.settingsDatabase.updateSetting(
                      Auth().currentUserId!,
                      'homePageWidgets',
                      selectedWidgets,
                    );
                    setState(() {
                      _settings?['homePageWidgets'] = selectedWidgets;
                    });
                    Navigator.of(context).pop();

                    // Show confirmation snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Home page widgets updated successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showUpdateHealthInformationDialog(BuildContext context) async {
    UserProfile? oldProfile = await UserDatabase().getUserProfile(
      auth.currentUser!.uid,
    );

    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent accidental dismissal
      builder: (context) {
        bool isMetric = true;
        bool isSaving = false;
        TextEditingController ageController = TextEditingController(
          text: oldProfile?.age.toString(),
        );
        TextEditingController weightController = TextEditingController(
          text: oldProfile?.weight.toString(),
        );
        TextEditingController heightController = TextEditingController(
          text: oldProfile?.height.toString(),
        );
        TextEditingController feetController = TextEditingController();
        TextEditingController inchesController = TextEditingController();
        ActivityLevel activityLevel =
            oldProfile?.activityLevel ?? ActivityLevel.moderatelyActive;

        // Convert height from cm to feet and inches for imperial display
        if (oldProfile?.height != null) {
          double heightInInches = oldProfile!.height / 2.54;
          int feet = heightInInches ~/ 12;
          int inches = (heightInInches % 12).round();
          feetController.text = feet.toString();
          inchesController.text = inches.toString();
        }

        return StatefulBuilder(
          builder: (context, setDialogState) {
            // Helper function to convert weight
            double convertWeight(double weight, bool toMetric) {
              if (toMetric) {
                return weight / 2.20462; // lbs to kg
              } else {
                return weight * 2.20462; // kg to lbs
              }
            }

            return AlertDialog(
              title: Text('Update Health Information'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Unit system selector
                    Column(
                      children: [
                        SizedBox(
                          child: RadioListTile<bool>(
                            title: Text('Metric'),
                            value: true,
                            groupValue: isMetric,
                            onChanged: isSaving
                                ? null
                                : (value) {
                                    setDialogState(() {
                                      if (!isMetric && value == true) {
                                        // Convert from imperial to metric
                                        double currentWeight =
                                            double.tryParse(
                                              weightController.text,
                                            ) ??
                                            0;
                                        if (currentWeight > 0) {
                                          weightController.text = convertWeight(
                                            currentWeight,
                                            true,
                                          ).toStringAsFixed(1);
                                        }
                                      }
                                      isMetric = value!;
                                    });
                                  },
                          ),
                        ),
                        SizedBox(
                          child: RadioListTile<bool>(
                            title: Text('Imperial'),
                            value: false,
                            groupValue: isMetric,
                            onChanged: isSaving
                                ? null
                                : (value) {
                                    setDialogState(() {
                                      if (isMetric && value == false) {
                                        // Convert from metric to imperial
                                        double currentWeight =
                                            double.tryParse(
                                              weightController.text,
                                            ) ??
                                            0;
                                        if (currentWeight > 0) {
                                          weightController.text = convertWeight(
                                            currentWeight,
                                            false,
                                          ).toStringAsFixed(1);
                                        }
                                      }
                                      isMetric = value!;
                                    });
                                  },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: ageController,
                      enabled: !isSaving,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        suffixText: 'years',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: weightController,
                      enabled: !isSaving,
                      decoration: InputDecoration(
                        labelText: 'Weight',
                        suffixText: isMetric ? 'kg' : 'lbs',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 8),
                    if (isMetric)
                      TextField(
                        controller: heightController,
                        enabled: !isSaving,
                        decoration: InputDecoration(
                          labelText: 'Height',
                          suffixText: 'cm',
                        ),
                        keyboardType: TextInputType.number,
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: feetController,
                              enabled: !isSaving,
                              decoration: InputDecoration(
                                labelText: 'Height',
                                suffixText: 'ft',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: inchesController,
                              enabled: !isSaving,
                              decoration: InputDecoration(
                                labelText: '',
                                suffixText: 'in',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<ActivityLevel>(
                      value: activityLevel,
                      decoration: InputDecoration(labelText: 'Activity Level'),
                      items: ActivityLevel.values.map((level) {
                        return DropdownMenuItem(
                          value: level,
                          child: Text(
                            camelToNormal(level.toString().split('.').last),
                          ),
                        );
                      }).toList(),
                      onChanged: isSaving
                          ? null
                          : (value) {
                              setDialogState(() {
                                activityLevel = value!;
                              });
                            },
                    ),
                    if (isSaving) ...[
                      SizedBox(height: 16),
                      CircularProgressIndicator(),
                      SizedBox(height: 8),
                      Text('Saving...'),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isSaving
                      ? null
                      : () {
                          Navigator.of(context).pop();
                        },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: isSaving
                      ? null
                      : () async {
                          // Validate inputs
                          final age = int.tryParse(ageController.text);
                          final weight = double.tryParse(weightController.text);

                          if (age == null || age <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter a valid age'),
                              ),
                            );
                            return;
                          }

                          if (weight == null || weight <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter a valid weight'),
                              ),
                            );
                            return;
                          }

                          double? heightInCm;
                          if (isMetric) {
                            heightInCm = double.tryParse(heightController.text);
                            if (heightInCm == null || heightInCm <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter a valid height'),
                                ),
                              );
                              return;
                            }
                          } else {
                            final feet = int.tryParse(feetController.text);
                            final inches = int.tryParse(inchesController.text);

                            if (feet == null ||
                                feet < 0 ||
                                inches == null ||
                                inches < 0 ||
                                inches >= 12) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please enter valid height values',
                                  ),
                                ),
                              );
                              return;
                            }

                            double totalInches =
                                (feet * 12).toDouble() + inches.toDouble();
                            heightInCm = totalInches * 2.54;
                          }

                          setDialogState(() {
                            isSaving = true;
                          });

                          try {
                            UserProfile? profile = await UserDatabase()
                                .getUserProfile(auth.currentUser!.uid);

                            if (profile != null) {
                              // Convert weight to metric for storage
                              double weightInKg = weight;
                              if (!isMetric) {
                                weightInKg = weight / 2.20462; // lbs to kg
                              }

                              // Create updated profile
                              UserProfile updatedProfile = UserProfile(
                                uid: profile.uid,
                                email: profile.email,
                                username: profile.username,
                                age: age,
                                weight: weightInKg,
                                height: heightInCm,
                                activityLevel: activityLevel,
                                sex: profile.sex,
                              );

                              // Save the profile
                              await UserDatabase().saveUserProfile(
                                updatedProfile,
                              );

                              if (context.mounted) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Health information updated successfully!',
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            } else {
                              throw Exception('Could not load user profile');
                            }
                          } catch (e) {
                            if (context.mounted) {
                              setDialogState(() {
                                isSaving = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Error saving health information: $e',
                                  ),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.error,
                                ),
                              );
                            }
                          }
                        },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      bottomNavigationBar: BottomNavbar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SettingsList(
                lightTheme: SettingsThemeData(
                  settingsListBackground: Colors.transparent,
                ),
                darkTheme: SettingsThemeData(
                  settingsListBackground: Colors.transparent,
                ),
                sections: [
                  SettingsSection(
                    title: Text('General'),
                    tiles: [
                      SettingsTile(
                        title: Text('Home Page Widgets'),
                        description: Text(
                          "Select what goals should appear on the homescreen",
                        ),
                        leading: Icon(Icons.widgets),
                        onPressed: (context) => {
                          _showWidgetSelectionDialog(context),
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: Text('Nutrition Goals'),
                    tiles: [
                      SettingsTile(
                        title: Text('Update health information'),
                        leading: Icon(Icons.edit),
                        onPressed: (context) =>
                            _showUpdateHealthInformationDialog(context),
                      ),
                      SettingsTile(
                        title: Text('Reset Nutrition Goals'),
                        leading: Icon(Icons.refresh),
                        onPressed: (context) async {
                          final profile = await UserDatabase().getUserProfile(
                            auth.currentUser!.uid,
                          );
                          UserDatabase().saveNutritionGoals(
                            auth.currentUser!.uid,
                            calculateGoals(
                              profile?.age ?? 0,
                              profile?.weight ?? 0,
                              profile?.height ?? 0,
                              profile?.activityLevel ??
                                  ActivityLevel.moderatelyActive,
                              profile?.sex == 'male',
                            ),
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Nutrition goals reset successfully',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: Text('Account'),
                    tiles: [
                      if (auth.currentUser!.isAnonymous)
                        SettingsTile(
                          title: Text('Create Account'),
                          description: Text(
                            'Want to keep using our app? Create an account to save your data.',
                          ),
                          leading: Icon(Icons.email),
                          onPressed: (context) {
                            context.go('/convert_anonymous_to_email');
                          },
                        ),
                      SettingsTile(
                        title: Text('Sign Out'),
                        leading: Icon(Icons.logout),
                        onPressed: (context) {
                          auth.signOut().then((value) {
                            if (context.mounted) {
                              context.go('/signin');
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
