import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for text input formatting

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';

import 'create_model.dart';
export 'create_model.dart';

class CreateWidget extends StatefulWidget {
  const CreateWidget({Key? key}) : super(key: key);

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget> {
  late CreateModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, String>> ingredients = [];
  List<String> units = ["pieces", "grams", "ounces", "ml", "liters"];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _showAddIngredientDialog({bool isEditing = false, int? index}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    String dialogSelectedUnit = units.first;  // Local variable for dialog

    if (isEditing && index != null) {
      Map<String, String> ingredient = ingredients[index];
      nameController.text = ingredient['name']!;
      quantityController.text = ingredient['quantity']!;
      dialogSelectedUnit = ingredient['unit']!;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? 'Edit Ingredient' : 'Add Ingredient'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Ingredient Name',
                    ),
                    enabled: !isEditing,
                  ),
                  TextField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                  ),
                  DropdownButton<String>(
                    value: dialogSelectedUnit,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setDialogState(() {
                        dialogSelectedUnit = newValue!;
                      });
                    },
                    items: units.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    if (nameController.text.trim().isEmpty || quantityController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Ingredient name and quantity cannot be empty.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    if (isEditing && index != null) {
                      setState(() {
                        ingredients[index] = {
                          "name": nameController.text,
                          "quantity": quantityController.text,
                          "unit": dialogSelectedUnit
                        };
                      });
                    } else {
                      setState(() {
                        ingredients.add({
                          "name": nameController.text,
                          "quantity": quantityController.text,
                          "unit": dialogSelectedUnit
                        });
                      });
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        );
      },
    );
  }

  @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Recipe Name'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black), 
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2, 
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _model.textController,
                  focusNode: _model.textFieldFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Enter Recipe Name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.headline6,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // to disable ListView's scrolling
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    final item = ingredients[index];
                    return Dismissible(
                      key: UniqueKey(), // UniqueKey can be used if names are not unique
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          ingredients.removeAt(index);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${item['name']} dismissed"),
                          ),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text(item['name']!),
                        trailing: Text('${item['quantity']} ${item['unit']}'),
                        onTap: () => _showAddIngredientDialog(isEditing: true, index: index),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () => _showAddIngredientDialog(),
                  child: const Text('Add Ingredient'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Method',
                  style: Theme.of(context).textTheme.headline6,
                ),
                // Add the UI and logic for steps/method here
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}
