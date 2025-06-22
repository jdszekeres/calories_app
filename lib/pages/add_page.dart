import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Page')),
      bottomNavigationBar: BottomNavbar(),
      body: Center(
        child: Text(
          'This is the Add Page',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
