import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      body: const Center(child: Text('Settings Page')),
    );
  }
}
