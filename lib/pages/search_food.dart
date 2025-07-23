import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../tools/meal_database.dart';

import '../auth.dart';
import '../tools/food_facts.dart';
import '../widgets/nutri_facts.dart';
import '../widgets/servings_selector.dart';

class SearchFood extends StatefulWidget {
  const SearchFood({Key? key}) : super(key: key);

  @override
  _SearchFoodState createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  final TextEditingController _searchController = TextEditingController();
  final Auth auth = Auth();
  List<Product> _searchResults = [];
  bool _isLoading = false;

  String? scannedBarcode;
  double? servings;
  FoodFacts? _foodFacts;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchProducts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final results = await searchProducts(_searchController.text);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error searching products: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Food'),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (scannedBarcode == null)
            ? Column(
                children: [
                  TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      _searchProducts();
                    },
                    decoration: InputDecoration(
                      labelText: 'Search for products',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: _searchProducts,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_isLoading)
                    Center(child: CircularProgressIndicator())
                  else if (_searchResults.isEmpty)
                    Center(child: Text('No results found'))
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final product = _searchResults[index];
                          return ListTile(
                            leading: product.imageUrl.isNotEmpty
                                ? Image.network(product.imageUrl, height: 50)
                                : null,
                            title: Text(product.name),
                            subtitle: Text(product.barcode),
                            onTap: () {
                              setState(() {
                                scannedBarcode = product.barcode;
                                _foodFacts =
                                    null; // Reset food facts when new product is selected
                              });
                            },
                          );
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
      ),
    );
  }
}
