import 'package:calories_app/tools/ads.dart';
import 'package:calories_app/tools/calculate_goals.dart';
import 'package:calories_app/tools/settings_database.dart';
import 'package:calories_app/tools/user_database.dart';
import 'package:calories_app/tools/user_profile.dart';
import 'package:calories_app/widgets/web_advertisement.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:calories_app/l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: implementation_imports
import 'package:settings_ui/src/tiles/platforms/ios_settings_tile.dart';

import '../auth.dart';
import '../tools/ai_credits.dart';
import '../widgets/bottom_navbar.dart';

class CustomSettingsTile extends AbstractSettingsTile {
  final SettingsTileType tileType;
  final Widget title;
  final Widget? description;
  final Widget? leading;
  final Widget? trailing;
  final Function(BuildContext)? onPressed;
  final Function(bool)? onToggle;
  final Widget? value;
  final bool? initialValue;
  final Color? activeSwitchColor;
  final bool enabled;

  const CustomSettingsTile({
    required this.tileType,
    required this.title,
    this.description,
    this.leading,
    this.trailing,
    this.onPressed,
    this.value,
    this.initialValue,
    this.activeSwitchColor,
    this.onToggle,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IOSSettingsTile(
      tileType: tileType,
      title: title,
      description: description,
      leading: leading,
      trailing: trailing,
      onPressed: onPressed,
      onToggle: onToggle,
      value: value,
      initialValue: initialValue,
      activeSwitchColor: activeSwitchColor,
      enabled: enabled,
    );
  }
}

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  final SettingsDatabase settingsDatabase = SettingsDatabase();

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Map<String, dynamic>? _settings;
  final Auth auth = Auth();
  final Ads adsManager = Ads(); // Single instance for the entire widget

  double credits = 0;

  @override
  void initState() {
    super.initState();
    widget.settingsDatabase.getSettings(Auth().currentUserId!).then((settings) {
      setState(() {
        _settings = settings;
      });
      AiCreditManager().getCredits(Auth().currentUserId!).then((value) {
        setState(() {
          credits = value;
        });
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
              title: Text(AppLocalizations.of(context)!.selectHomePageWidgets),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: availableWidgets.map((widget) {
                    return CheckboxListTile(
                      title: Text(NutrutionGoals.getName(context, widget)),
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
                  child: Text(AppLocalizations.of(context)!.cancel),
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
                        content: Text(
                          AppLocalizations.of(context)!.homePageWidgetsUpdated,
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.save),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController passwordController = TextEditingController();
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.deleteAccountConfirmTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context)!.deleteAccountConfirmBody),
              TextField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.confirmPassword,
                  hintText: AppLocalizations.of(context)!.confirmPassword,
                ),
                obscureText: true,
                controller: passwordController,
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await auth.deleteAccount(passwordController.text);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.accountDeleted,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(Auth.prettyPrintError(e)),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text(
                AppLocalizations.of(context)!.delete,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
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
              title: Text(
                AppLocalizations.of(context)!.updateHealthInformation,
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Unit system selector
                    Column(
                      children: [
                        SizedBox(
                          child: RadioListTile<bool>(
                            title: Text(AppLocalizations.of(context)!.metric),
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
                            title: Text(AppLocalizations.of(context)!.imperial),
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
                        labelText: AppLocalizations.of(context)!.age,
                        suffixText: AppLocalizations.of(context)!.years,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: weightController,
                      enabled: !isSaving,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.weight,
                        suffixText: isMetric
                            ? AppLocalizations.of(context)!.unitKg
                            : AppLocalizations.of(context)!.unitLbs,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 8),
                    if (isMetric)
                      TextField(
                        controller: heightController,
                        enabled: !isSaving,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.height,
                          suffixText: AppLocalizations.of(context)!.unitCm,
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
                                labelText: AppLocalizations.of(context)!.height,
                                suffixText: AppLocalizations.of(
                                  context,
                                )!.unitFt,
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
                                suffixText: AppLocalizations.of(
                                  context,
                                )!.unitIn,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<ActivityLevel>(
                      value: activityLevel,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.activityLevel,
                      ),
                      items: ActivityLevel.values.map((level) {
                        String label;
                        switch (level) {
                          case ActivityLevel.sedentary:
                            label = AppLocalizations.of(context)!.sedentary;
                            break;
                          case ActivityLevel.lightlyActive:
                            label = AppLocalizations.of(context)!.lightlyActive;
                            break;
                          case ActivityLevel.moderatelyActive:
                            label = AppLocalizations.of(
                              context,
                            )!.moderatelyActive;
                            break;
                          case ActivityLevel.veryActive:
                            label = AppLocalizations.of(context)!.veryActive;
                            break;
                          case ActivityLevel.extraActive:
                            label = AppLocalizations.of(context)!.extraActive;
                            break;
                        }
                        return DropdownMenuItem(
                          value: level,
                          child: Text(label),
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
                      Text(AppLocalizations.of(context)!.saving),
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
                  child: Text(AppLocalizations.of(context)!.cancel),
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
                                content: Text(
                                  AppLocalizations.of(context)!.invalidAge,
                                ),
                              ),
                            );
                            return;
                          }

                          if (weight == null || weight <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!.invalidWeight,
                                ),
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
                                  content: Text(
                                    AppLocalizations.of(context)!.invalidHeight,
                                  ),
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
                                    AppLocalizations.of(context)!.invalidHeight,
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
                                      AppLocalizations.of(
                                        context,
                                      )!.updateHealthInformationSuccess,
                                    ),
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            } else {
                              throw Exception(
                                AppLocalizations.of(
                                  context,
                                )!.couldNotLoadUserProfile,
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              setDialogState(() {
                                isSaving = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.errorSavingHealthInformation(e),
                                  ),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.error,
                                ),
                              );
                            }
                          }
                        },
                  child: Text(AppLocalizations.of(context)!.save),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> onAdEarned(BuildContext context) async {
    double newCredits = await AiCreditManager().addCredits(
      auth.currentUser!.uid,
      5.0,
    );
    setState(() => credits = newCredits);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("+${AppLocalizations.of(context)!.creditCount(5)}"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
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
                    title: Text(AppLocalizations.of(context)!.general),
                    tiles: [
                      CustomSettingsTile(
                        tileType: SettingsTileType.simpleTile,
                        title: Text(AppLocalizations.of(context)!.aiCredits),
                        description: Text(
                          AppLocalizations.of(context)!.aiCreditDescription,
                        ),
                        leading: Icon(Icons.auto_awesome),
                        trailing: Text(
                          AppLocalizations.of(
                            context,
                          )!.creditCount(credits.toInt()),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: (context) async {
                          try {
                            final ad = await adsManager.loadRewarded(context);
                            if (ad != null) {
                              adsManager.showRewardedAd(
                                onUserEarnedReward: () => onAdEarned(context),
                              );
                            } else {
                              // Fallback to web advertisement when ad fails to load
                              // (common on simulators)
                              if (kDebugMode) {
                                print(
                                  'Ad failed to load, showing web advertisement fallback',
                                );
                              }
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return WebAdvertisement(
                                    onClose: () {
                                      Navigator.of(context).pop();
                                      onAdEarned(context);
                                    },
                                  );
                                },
                              );
                            }
                          } catch (e) {
                            print('Error loading ad: $e');
                            // Show web advertisement as fallback
                            showDialog(
                              context: context,
                              builder: (context) {
                                return WebAdvertisement(
                                  onClose: () {
                                    Navigator.of(context).pop();
                                    onAdEarned(context);
                                  },
                                );
                              },
                            );
                          }
                        },
                        onToggle: (bool value) {},
                        value: null,
                        initialValue: null,
                        activeSwitchColor: null,
                        enabled: true,
                      ),
                      SettingsTile(
                        title: Text(
                          AppLocalizations.of(context)!.homePageWidgets,
                        ),
                        description: Text(
                          AppLocalizations.of(
                            context,
                          )!.selectHomeWidgetsDescription,
                        ),
                        leading: Icon(Icons.widgets),
                        onPressed: (context) => {
                          _showWidgetSelectionDialog(context),
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: Text(AppLocalizations.of(context)!.nutritionGoals),
                    tiles: [
                      SettingsTile(
                        title: Text(
                          AppLocalizations.of(context)!.updateHealthInformation,
                        ),
                        leading: Icon(Icons.edit),
                        onPressed: (context) =>
                            _showUpdateHealthInformationDialog(context),
                      ),
                      SettingsTile(
                        title: Text(
                          AppLocalizations.of(context)!.resetNutritionGoals,
                        ),
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
                                  AppLocalizations.of(
                                    context,
                                  )!.nutritionGoalsReset,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: Text(AppLocalizations.of(context)!.account),
                    tiles: [
                      if (auth.currentUser!.isAnonymous)
                        SettingsTile(
                          title: Text(
                            AppLocalizations.of(context)!.createAccount,
                          ),
                          description: Text(
                            AppLocalizations.of(context)!.createAccountDesc,
                          ),
                          leading: Icon(Icons.email),
                          onPressed: (context) {
                            context.go('/convert_anonymous_to_email');
                          },
                        ),
                      if (kIsWeb)
                        SettingsTile(
                          title: Text(
                            AppLocalizations.of(context)!.downloadApp,
                          ),
                          leading: Icon(Icons.phone_iphone),
                          onPressed: (context) {
                            launchUrlString(
                              'https://apps.apple.com/us/app/calorie-tracker-pro-max/id6749119246',
                            );
                          },
                        ),
                      SettingsTile(
                        title: Text(AppLocalizations.of(context)!.signOut),
                        leading: Icon(Icons.logout),
                        onPressed: (context) {
                          auth.signOut().then((value) {
                            if (context.mounted) {
                              context.go('/signin');
                            }
                          });
                        },
                      ),
                      SettingsTile(
                        title: Text(
                          AppLocalizations.of(context)!.deleteAccount,
                          style: TextStyle(color: Colors.red),
                        ),
                        leading: Icon(Icons.delete, color: Colors.red),
                        onPressed: (context) {
                          _showDeleteAccountDialog(context);
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

  void launchUrlString(String s) {
    launchUrl(Uri.parse(s), mode: LaunchMode.externalApplication);
  }
}
