import 'package:calories_app/l10n/app_localizations.dart';
import 'package:calories_app/pages/ai_image_page.dart';
import 'package:calories_app/pages/mobile_scanner.dart';
import 'package:calories_app/pages/ai_desc_page.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import 'search_food.dart';

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
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 30),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            )
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
    AppLocalizations local = AppLocalizations.of(context)!;
    return Scaffold(
      // appBar: AppBar(title: const Text('Add Page')),
      bottomNavigationBar: BottomNavbar(),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 20),
            Button(
              text: local.scanBarcodeTitle,
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
              text: local.searchForProducts,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchFood()),
                );
              },
            ),

            const SizedBox(height: 20),
            Button(
              icon: Icons.auto_awesome,
              text: local.aiNutritionAnalysisTitle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AiPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            Button(
              icon: Icons.text_snippet,
              text: local.aiDescriptionAnalysisTitle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AiDescPage()),
                );
              },
            ),
            const SizedBox(height: 20 * 4),
          ],
        ),
      ),
    );
  }
}
