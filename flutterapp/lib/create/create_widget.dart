import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodappproject/app_data.dart';
import 'package:foodappproject/app_shared.dart';
import 'package:image_picker/image_picker.dart'; // Import the image picker package
import 'package:numberpicker/numberpicker.dart';

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
  TextEditingController recipeNameController = TextEditingController();
  TextEditingController recipeDescriptionController = TextEditingController();
  int servingSize = 1;
  int difficultyRating = 1;
  String dialogSelectedUnit = "g";
  late CreateModel _model;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, String>> ingredients = [];//{"name":"Benis","quantity":"86","unit":"lb"}];
  /*List<IngredientData> testIngredients = [
    IngredientData(name: "benis", quantity: "46 g", expiry: 4),
    IngredientData(name: "bonis", quantity: "47 lb", expiry: 3)
    ];*/
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

    List<List<String>> processedIngredients = [];
    for (Map<String,String> ingredient in ingredients) {
      processedIngredients.add([ingredient["name"]!,"${ingredient["quantity"]!} ${ingredient["unit"]}"]);
    }
    //build recipe data ( no, i still cannot automate this :( )
    var outerBody = {};
    var body = {};
    body["name"]=recipeNameController.text;
    body["starRating"]=2.5;//This is ignored on the server
    body["difficultyRaing"]=difficultyRating; //TODO: USER SPECIFIED DIFFICULTY
    body["servingSize"]=servingSize; //TODO: SEE ABOVE
    body["ingredients"]=processedIngredients;
    body["method"]=methods;
    body["description"]=recipeDescriptionController.text;
    body["backdrop"]="";
    body["peopleReviewed"]=0;
    outerBody["recipe"]=body;
    outerBody["username"]=AppData?.currentUser;
    print(json.encode(outerBody));
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
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8.0,0,0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: ffTheme.secondaryBackground,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text("Serving Size:",style: ffTheme.bodyLarge,),
                            NumberPicker(
                              value: servingSize,
                              minValue: 1,
                              maxValue: 69,
                              onChanged: (value) => setState(() => servingSize = value)
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text("Difficulty:",style: ffTheme.bodyLarge,),
                            NumberPicker(
                              value: difficultyRating,
                              minValue: 1,
                              maxValue: 5,
                              onChanged: (value) => setState(() => difficultyRating = value)
                            )
                          ],
                        ),
                      ],
                    )
                  ),
                ),
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
            SizedBox(height:60),

            ],
          ),
        ),
      ),
    ),
  );
}
}

class ApiRecipe {
  
}
