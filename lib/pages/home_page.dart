import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: const Center(child: Text('This is the Home Page')),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
