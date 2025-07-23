import 'package:calories_app/auth.dart';
import 'package:calories_app/tools/food_facts.dart';
import 'package:calories_app/widgets/nutri_facts.dart';
import 'package:calories_app/widgets/servings_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../tools/meal_database.dart';

class MobileScannerWidget extends StatefulWidget {
  MobileScannerWidget({Key? key}) : super(key: key);

  final MobileScannerController controller = MobileScannerController(
    formats: [
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.codebar,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
    ],
  );

  @override
  _MobileScannerWidgetState createState() => _MobileScannerWidgetState();
}

class _MobileScannerWidgetState extends State<MobileScannerWidget> {
  String? scannedBarcode;
  double? servings;
  FoodFacts? _foodFacts;

  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode'),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: (scannedBarcode == null)
          ? Column(
              children: [
                Expanded(
                  child: MobileScanner(
                    controller: widget.controller,
                    onDetect: (result) {
                      // Check if barcodes list is not empty before accessing first element
                      if (result.barcodes.isNotEmpty) {
                        final barcode = result.barcodes.first;
                        if (barcode.rawValue != null) {
                          print('Scanned barcode: ${barcode.rawValue}');
                          setState(() {
                            scannedBarcode = barcode.rawValue;
                            _foodFacts =
                                null; // Reset food facts when new barcode is scanned
                          });
                        }
                      }
                    },
                  ),
                ),
              ],
            )
          : (servings == null)
          ? Center(
              child: FutureBuilder(
                future: fetchFoodFacts(scannedBarcode!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print(snapshot.stackTrace);
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ServingsSelector(
                      initialServings: 1,
                      onServingsChanged: (newServings) {
                        setState(() {
                          servings = newServings;
                        });
                      },
                      data: snapshot.data!,
                    );
                  }
                },
              ),
            )
          : Center(
              child: FutureBuilder(
                future: fetchFoodFacts(scannedBarcode!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print(snapshot.stackTrace);
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Initialize _foodFacts if not already set
                    if (_foodFacts == null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _foodFacts = snapshot.data!;
                        });
                      });
                      // Show loading while state updates
                      return CircularProgressIndicator();
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          NutriFacts(
                            foodFacts: _foodFacts!,
                            servings: servings!,
                            onEdit: (editedFoodFacts) {
                              setState(() {
                                _foodFacts = editedFoodFacts;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Nutrition facts updated!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (servings != null) {
                                await MealDatabase().addMeal(
                                  auth.currentUser!.uid,
                                  _foodFacts!.copyWith(
                                    numServings: servings,
                                    uploaded: DateTime.now(),
                                  ),
                                );
                              }
                              if (!mounted) return;
                              context.go('/');
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller to prevent memory leaks and camera issues
    widget.controller.dispose();
    super.dispose();
  }
}
