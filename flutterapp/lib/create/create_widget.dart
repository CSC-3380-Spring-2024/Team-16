import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodappproject/app_data.dart';
import 'package:foodappproject/app_shared.dart';
import 'package:image_picker/image_picker.dart'; // Import the image picker package
import 'package:file_picker/file_picker.dart';
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
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, String>> ingredients = [];
  List<IngredientData> testIngredients = [
    IngredientData(name: "benis", quantity: "46 g", expiry: 4),
    IngredientData(name: "bonis", quantity: "47 lb", expiry: 3)
    ];
  List<String> units = ["pieces", "grams", "ounces", "ml", "liters"];
  List<String> methods = [];

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

  Future<void> _pickImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );

  if (result != null) {
    File file = File(result.files.single.path!);
    setState(() {
      _imageFile = file;
    });
  }
}


  void _postRecipe() {
    // Implement your logic to handle recipe posting, e.g., uploading to a server
    print('Posting recipe with image path: ${_imageFile?.path}');
  }

  void _showAddIngredientDialog({bool isEditing = false, int? index}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    String dialogSelectedUnit = units.first;

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

  void _showAddMethodDialog({bool isEditing = false, int? index}) {
    TextEditingController methodController = TextEditingController();
    if (isEditing && index != null) {
      methodController.text = methods[index];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Method' : 'Add Method'),
          content: TextField(
            controller: methodController,
            decoration: const InputDecoration(
              labelText: 'Step Description',
            ),
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                if (methodController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Step description cannot be empty.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }
                
                if (isEditing && index != null) {
                  setState(() {
                    methods[index] = methodController.text;
                  });
                } else {
                  setState(() {
                    methods.add(methodController.text);
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onReorderMethod(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = methods.removeAt(oldIndex);
      methods.insert(newIndex, item);
    });
  }

  @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Create Recipe'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
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
              Text('Ingredients', style: Theme.of(context).textTheme.headline6),
              ...ingredients.map((ingredient) => Dismissible(
                key: Key(ingredient['name']!),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    ingredients.removeWhere((item) => item['name'] == ingredient['name']);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${ingredient['name']} dismissed"),
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
                  title: Text(ingredient['name']!),
                  trailing: Text('${ingredient['quantity']} ${ingredient['unit']}'),
                  onTap: () => _showAddIngredientDialog(isEditing: true, index: ingredients.indexOf(ingredient)),
                ),
              )).toList(),
              ReorderableExample(editable: true, items: testIngredients, header: "Ingredients"),
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
              Text('Method', style: Theme.of(context).textTheme.headline6),






              ReorderableListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                onReorder: _onReorderMethod, // to prevent scrolling within the view
                children: [
                  for (int index = 0; index < methods.length; index++)
                    Dismissible(
                      key: Key('method_$index'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          methods.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Step ${index + 1} dismissed"),
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
                        key: Key('$index'),
                        title: Text('Step ${index + 1}: ${methods[index]}'),
                        onTap: () => _showAddMethodDialog(isEditing: true, index: index),
                      ),
                    ),
                ],
              ),





              
              ElevatedButton(
                onPressed: () => _showAddMethodDialog(),
                child: const Text('Add Method'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Upload Image', style: Theme.of(context).textTheme.headline6),
              SizedBox(height: 10),
              Center(
                child: _imageFile == null
                    ? Text('No image selected.')
                    : Image.file(_imageFile!),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _postRecipe,
                child: Text('Post Recipe'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green,
                ),
              ),
<<<<<<< Updated upstream
=======
            SizedBox(height:60),

>>>>>>> Stashed changes
            ],
          ),
        ),
      ),
    ),
  );
}
<<<<<<< Updated upstream
}
=======

}

>>>>>>> Stashed changes
