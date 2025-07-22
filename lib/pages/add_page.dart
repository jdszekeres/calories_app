import 'package:calories_app/pages/mobile_scanner.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        minimumSize: Size(MediaQuery.of(context).size.width / 3, 75),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      onPressed: onPressed,
      child: icon != null
          ? Icon(icon)
          : Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
    );
  }
}

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Page')),
      bottomNavigationBar: BottomNavbar(),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 20),
            Button(
              text: 'Scan Barcode',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MobileScannerWidget(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
            Button(
              text: 'Search For Product',
              onPressed: () {
                // Add your search for product logic here
              },
            ),

            const SizedBox(height: 20),
            Button(
              text: 'Log Meal',
              onPressed: () {
                // Add your log meal logic here
              },
            ),
            const SizedBox(height: 20 * 4),
          ],
        ),
      ),
    );
  }
}
