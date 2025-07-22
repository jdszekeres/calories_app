import 'package:calories_app/tools/calculate_goals.dart';
import 'package:calories_app/tools/settings_database.dart';
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
      appBar: AppBar(title: const Text('Settings')),
      bottomNavigationBar: BottomNavbar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('General'),
            tiles: [
              SettingsTile.switchTile(
                title: Text('Metric Units'),
                initialValue: _settings?['metricUnits'] ?? true,
                onToggle: (bool value) {
                  widget.settingsDatabase.updateSetting(
                    Auth().currentUserId!,
                    'metricUnits',
                    value,
                  );
                  setState(() {
                    _settings?['metricUnits'] = value;
                  });
                },
              ),
              SettingsTile(
                title: Text('Home Page Widgets'),
                description: Text(
                  "Select what goals should appear on the homescreen",
                ),
                leading: Icon(Icons.widgets),
                onPressed: (context) => {_showWidgetSelectionDialog(context)},
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
                  Auth().signOut().then((value) {
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
    );
  }
}
