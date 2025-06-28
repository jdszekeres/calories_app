import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';

import '../auth.dart';
import '../widgets/bottom_navbar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      bottomNavigationBar: BottomNavbar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Account'),
            tiles: [
              SettingsTile(
                title: Text('Sign Out'),
                leading: Icon(Icons.logout),
                onPressed: (context) {
                  Auth().signOut().then((value) {
                    context.go('/signin');
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
