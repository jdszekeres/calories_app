import 'package:calories_app/tools/calculate_goals.dart';
import 'package:calories_app/tools/camel_to_normal.dart';
import 'package:calories_app/tools/settings_database.dart';
import 'package:calories_app/tools/user_database.dart';
import 'package:calories_app/tools/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Settings')),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      bottomNavigationBar: BottomNavbar(),
      body: Column(
        children: [
          Text("Settings", style: Theme.of(context).textTheme.headlineLarge),
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
                      onPressed: (context) async {
                        UserProfile? oldProfile = await UserDatabase()
                            .getUserProfile(auth.currentUser!.uid);
                        showDialog(
                          context: context,
                          builder: (context) {
                            bool isMetric = true;
                            TextEditingController ageController =
                                TextEditingController(
                                  text: oldProfile?.age.toString(),
                                );
                            TextEditingController weightController =
                                TextEditingController(
                                  text: oldProfile?.weight.toString(),
                                );
                            TextEditingController heightController =
                                TextEditingController(
                                  text: oldProfile?.height.toString(),
                                );
                            TextEditingController feetController =
                                TextEditingController();
                            TextEditingController inchesController =
                                TextEditingController();
                            ActivityLevel activityLevel =
                                ActivityLevel.moderatelyActive;

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
                                double convertWeight(
                                  double weight,
                                  bool toMetric,
                                ) {
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
                                      children: [
                                        // Unit system selector
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RadioListTile<bool>(
                                                title: Text('Metric'),
                                                value: true,
                                                groupValue: isMetric,
                                                onChanged: (value) {
                                                  setDialogState(() {
                                                    if (!isMetric &&
                                                        value == true) {
                                                      // Convert from imperial to metric
                                                      double currentWeight =
                                                          double.tryParse(
                                                            weightController
                                                                .text,
                                                          ) ??
                                                          0;
                                                      if (currentWeight > 0) {
                                                        weightController.text =
                                                            convertWeight(
                                                              currentWeight,
                                                              true,
                                                            ).toStringAsFixed(
                                                              1,
                                                            );
                                                      }
                                                    }
                                                    isMetric = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: RadioListTile<bool>(
                                                title: Text('Imperial'),
                                                value: false,
                                                groupValue: isMetric,
                                                onChanged: (value) {
                                                  setDialogState(() {
                                                    if (isMetric &&
                                                        value == false) {
                                                      // Convert from metric to imperial
                                                      double currentWeight =
                                                          double.tryParse(
                                                            weightController
                                                                .text,
                                                          ) ??
                                                          0;
                                                      if (currentWeight > 0) {
                                                        weightController.text =
                                                            convertWeight(
                                                              currentWeight,
                                                              false,
                                                            ).toStringAsFixed(
                                                              1,
                                                            );
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
                                          decoration: InputDecoration(
                                            labelText: 'Age',
                                            suffixText: 'years',
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                        TextField(
                                          controller: weightController,
                                          decoration: InputDecoration(
                                            labelText: 'Weight',
                                            suffixText: isMetric ? 'kg' : 'lbs',
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                        if (isMetric)
                                          TextField(
                                            controller: heightController,
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
                                                  decoration: InputDecoration(
                                                    labelText: 'Height',
                                                    suffixText: 'ft',
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: TextField(
                                                  controller: inchesController,
                                                  decoration: InputDecoration(
                                                    labelText: '',
                                                    suffixText: 'in',
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                            ],
                                          ),
                                        DropdownButtonFormField(
                                          value: activityLevel,
                                          decoration: InputDecoration(
                                            labelText: 'Activity Level',
                                          ),
                                          items: ActivityLevel.values.map((
                                            level,
                                          ) {
                                            return DropdownMenuItem(
                                              value: level,
                                              child: Text(
                                                camelToNormal(
                                                  level
                                                      .toString()
                                                      .split('.')
                                                      .last,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            activityLevel = value!;
                                          },
                                        ),
                                      ],
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
                                      onPressed: () async {
                                        UserProfile? profile =
                                            await UserDatabase().getUserProfile(
                                              auth.currentUser!.uid,
                                            );
                                        if (profile != null) {
                                          // Convert values to metric for storage
                                          double weightInKg =
                                              double.tryParse(
                                                weightController.text,
                                              ) ??
                                              0.0;
                                          if (!isMetric && weightInKg > 0) {
                                            weightInKg =
                                                weightInKg /
                                                2.20462; // lbs to kg
                                          }

                                          double heightInCm;
                                          if (isMetric) {
                                            heightInCm =
                                                double.tryParse(
                                                  heightController.text,
                                                ) ??
                                                0.0;
                                          } else {
                                            // Convert feet and inches to cm
                                            int feet =
                                                int.tryParse(
                                                  feetController.text,
                                                ) ??
                                                0;
                                            int inches =
                                                int.tryParse(
                                                  inchesController.text,
                                                ) ??
                                                0;
                                            double totalInches =
                                                (feet * 12).toDouble() +
                                                inches.toDouble();
                                            heightInCm = totalInches * 2.54;
                                          }

                                          UserDatabase().saveUserProfile(
                                            UserProfile(
                                              uid: profile.uid,
                                              email: profile.email,
                                              username: profile.username,
                                              age:
                                                  int.tryParse(
                                                    ageController.text,
                                                  ) ??
                                                  0,
                                              weight: weightInKg,
                                              height: heightInCm,
                                              activityLevel: activityLevel,
                                              sex: profile.sex,
                                            ),
                                          );
                                        }
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Press \'Reset Nutrition Goals\' to update your goals',
                                            ),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Save'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Nutrition goals reset successfully'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text('Account'),
                  tiles: [
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
    );
  }
}
