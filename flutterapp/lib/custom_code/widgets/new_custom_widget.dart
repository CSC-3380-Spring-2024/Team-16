// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class IngredientEntry {
  String name;
  TextEditingController quantityController;
  String unit;

  IngredientEntry(
      {required this.name, double quantity = 1.0, this.unit = 'pcs'})
      : quantityController =
            TextEditingController(text: quantity.toStringAsFixed(1));
}

class NewCustomWidget extends StatefulWidget {
  const NewCustomWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<NewCustomWidget> createState() => _NewCustomWidgetState();
}

class _NewCustomWidgetState extends State<NewCustomWidget> {
  List<IngredientEntry> _selectedIngredients = [];
  final List<String> _ingredients = [
    "Apple",
    "Banana",
    "Orange",
    "Mango",
    "Grapes",
    "Tomato"
  ];

  void _showIngredientDialog(String selectedIngredient) {
    showDialog(
      context: context,
      builder: (context) {
        double quantity = 1.0;
        String unit = 'pcs';
        TextEditingController quantityController =
            TextEditingController(text: quantity.toStringAsFixed(1));
        return AlertDialog(
          title: Text('Select Quantity and Unit'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter dialogSetState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      quantity = double.tryParse(value) ?? 1.0;
                    },
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: unit,
                    items: ['pcs', 'kg', 'g', 'lb', 'oz'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      dialogSetState(() {
                        unit = value ?? 'pcs';
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                setState(() {
                  _selectedIngredients.add(IngredientEntry(
                    name: selectedIngredient,
                    quantity: double.tryParse(quantityController.text) ?? 1.0,
                    unit: unit,
                  ));
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 300.0,
      child: Column(
        children: [
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return _ingredients.where((String option) {
                return option
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              _showIngredientDialog(selection);
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: 'Search Ingredient',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  child: Container(
                    width: 300,
                    height: 200,
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final String option = options.elementAt(index);
                        return ListTile(
                          title: Text(option),
                          onTap: () {
                            onSelected(option);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedIngredients.length,
              itemBuilder: (context, index) {
                final ingredient = _selectedIngredients[index];
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: ingredient.quantityController,
                          decoration: InputDecoration(
                            labelText: 'Qty',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onFieldSubmitted: (_) {
                            double newQuantity = double.tryParse(
                                    ingredient.quantityController.text) ??
                                1.0;
                            setState(() {
                              ingredient.quantityController.text =
                                  newQuantity.toStringAsFixed(1);
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: Text(ingredient.name,
                            style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<String>(
                        value: ingredient.unit,
                        items:
                            ['pcs', 'kg', 'g', 'lb', 'oz'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            ingredient.unit = value ?? 'pcs';
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          setState(() {
                            _selectedIngredients.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
