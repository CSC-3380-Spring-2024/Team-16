import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart'; // Needed for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodappproject/app_data.dart';
import 'package:foodappproject/app_shared.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:file_picker/file_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:http/http.dart' as http;

import 'create_model.dart';
export 'create_model.dart';

class CreateWidget extends StatefulWidget {
  const CreateWidget({Key? key}) : super(key: key);

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget> {
  TextEditingController recipeNameController = TextEditingController();
  TextEditingController recipeDescriptionController = TextEditingController();
  int servingSize = 1;
  int difficultyRating = 1;
  String dialogSelectedUnit = "g";
  late CreateModel _model;
  Uint8List? _fileBytes; // For web
  File? _file; // For mobile
  String? _fileName;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, String>> ingredients = [];
  List<String> units = ["L", "mL","oz","cup","g", "kg","lb","tsp","tbsp","unit"];
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

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });

      if (kIsWeb) {
        // For web
        setState(() {
          _fileBytes = result.files.first.bytes;
        });
      } else {
        // For mobile and desktop
        File file = File(result.files.single.path!);
        setState(() {
          _file = file;
        });
      }
    }
  }

   Future<void> _postRecipe() async {
  if (kIsWeb) {
    print('Posting recipe with file bytes: ${_fileBytes != null ? "File Selected" : "No File Selected"}');
  } else {
    print('Posting recipe with file path: ${_file?.path}');
  }

  List<List<String>> processedIngredients = [];
  for (Map<String, String> ingredient in ingredients) {
    processedIngredients.add([ingredient["name"]!, "${ingredient["quantity"]!} ${ingredient["unit"]}"]);
  }

  var outerBody = <String, dynamic>{};
  var body = <String, dynamic>{};
  body["name"] = recipeNameController.text;
  body["starRating"] = 2.5;
  body["difficultyRating"] = difficultyRating;
  body["servingSize"] = servingSize;
  body["ingredients"] = processedIngredients;
  body["method"] = methods;
  body["description"] = recipeDescriptionController.text;
  body["backdrop"] = ""; // Add a proper backdrop value or remove it
  body["peopleReviewed"] = 0;
  outerBody["recipe"] = body;
  outerBody["username"] = "usr";

  print(json.encode(outerBody));

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20.0),
              Text("Sending data..."),
            ],
          ),
        ),
      );
    },
  );

  final response = await http.post(
    Uri.parse('http://localhost:8080/api/recipe/add'),
    headers: <String, String>{
      'Content-Type': 'application/json', // Ensure the server expects JSON
    },
    body: json.encode(outerBody), // Encode the outerBody as JSON
  );

  Navigator.pop(context); // Close the loading dialog

  if (response.statusCode == 200) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(response.body),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error ${response.statusCode}'),
          content: Text(response.body),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

  void _showAddIngredientDialog(List<dynamic> unused) {
    TextEditingController nameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: const Text('Add Ingredient'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Ingredient Name',
                    ),
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
                    setState(() {
                      ingredients.add({
                        "name": nameController.text,
                        "quantity": quantityController.text,
                        "unit": dialogSelectedUnit
                      });
                    });

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

  void _showAddMethodDialog(List<dynamic> methods) {
    TextEditingController methodController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Method'),
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
                setState(() {
                  methods.add(methodController.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme ffTheme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ffTheme.primaryBackground,
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Create Recipe',style: ffTheme.headlineMedium,),
          centerTitle: true,
          elevation: 0,
          backgroundColor: ffTheme.secondaryBackground,
          iconTheme: IconThemeData(color: ffTheme.primaryText),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: recipeNameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Recipe Name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                  ),
                ),
                const SizedBox(height: 20),

              //Serving Size Selector
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 8.0,0,0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: ffTheme.secondaryBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Serving Size:",style: ffTheme.bodyLarge,),
                                    NumberPicker(
                                      value: servingSize,
                                      minValue: 1,
                                      maxValue: 69,
                                      onChanged: (value) => setState(() => servingSize = value)
                                    )
                                  ],
                                ),                          ],
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 8.0,0,0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: ffTheme.secondaryBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Difficulty:",style: ffTheme.bodyLarge,),
                                    NumberPicker(
                                      value: difficultyRating,
                                      minValue: 1,
                                      maxValue: 5,
                                      onChanged: (value) => setState(() => difficultyRating = value)
                                    )
                                  ],
                                ),                          ],
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
                //Description Field
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8.0,0,0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: ffTheme.secondaryBackground,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Description",
                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Outfit',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: recipeDescriptionController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter some information about your recipe...',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ReorderableExample(editable: true, items: ingredients, header: "Ingredients", dialogMethod: _showAddIngredientDialog,),

                ReorderableExample(editable: true, items: methods, header: "Methods", dialogMethod: _showAddMethodDialog),

                const SizedBox(height: 20),
                Text('Upload File', style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 10),
                Center(
  child: (_fileBytes == null && _file == null)
      ? Text('No file selected.')
      : Column(
          children: [
            Text('Selected file: $_fileName'),
            SizedBox(height: 10),
            // Show preview for image files
            if (_fileBytes != null)
              Image.memory(_fileBytes!)
            else if (_file != null &&
                ['jpg', 'jpeg', 'png']
                    .contains(_file!.path.split('.').last.toLowerCase()))
              Image.file(_file!),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _fileBytes = null;
                  _file = null;
                  _fileName = null;
                });
              },
              child: Text('Delete Image'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
),

                ElevatedButton(
                  onPressed: _pickFile,
                  child: Text('Select File'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _postRecipe,
                  child: Text('Post Recipe'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black12,
                  ),
                ),
                SizedBox(height:60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
