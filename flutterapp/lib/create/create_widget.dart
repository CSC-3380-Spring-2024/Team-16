import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'create_model.dart';
export 'create_model.dart';

class CreateWidget extends StatefulWidget {
  const CreateWidget({super.key});

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget> {
  late CreateModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

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

<<<<<<< Updated upstream
=======
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
    // Implement your logic to handle recipe posting, e.g., uploading to a server
    if (kIsWeb) {
      print('Posting recipe with file bytes: ${_fileBytes != null ? "File Selected" : "No File Selected"}');
    } else {
      print('Posting recipe with file path: ${_file?.path}');
    }

    List<List<String>> processedIngredients = [];
    for (Map<String,String> ingredient in ingredients) {
      processedIngredients.add([ingredient["name"]!,"${ingredient["quantity"]!} ${ingredient["unit"]}"]);
    }
    var outerBody = <String, dynamic>{};
    var body = <String, dynamic>{};
    body["name"]=recipeNameController.text;
    body["starRating"]=2.5;
    body["difficultyRaing"]=difficultyRating;
    body["servingSize"]=servingSize;
    body["ingredients"]=processedIngredients;
    body["method"]=methods;
    body["description"]=recipeDescriptionController.text;
    body["backdrop"]="";
    body["peopleReviewed"]=0;
    outerBody["recipe"]=body;
    outerBody["username"]="usr";
    print(json.encode(outerBody));

    /*showDialog(
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
    );*/

    final response = await http.post(
      Uri.parse('http://localhost:8080/api/recipe/add'),
      body: json.encode(outerBody),
      headers: {
        'Content-Type': 'application/json', // Ensure proper content-type
      },
    );
    
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(response.statusCode.toString()),
            content: Text("Successfully Posted review!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
                //RecipeData newRecipe =
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

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Create Recipe',
            style: FlutterFlowTheme.of(context).headlineLarge.override(
                  fontFamily: 'Outfit',
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _model.textController,
                    focusNode: _model.textFieldFocusNode,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Recipe',
                      hintText: 'Enter the name of your dish',
                      hintStyle:
                          FlutterFlowTheme.of(context).bodyLarge.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0.0,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                    validator:
                        _model.textControllerValidator.asValidator(context),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 300.0,
                  child: custom_widgets.NewCustomWidget(
                    width: double.infinity,
                    height: 300.0,
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    final selectedMedia =
                        await selectMediaWithSourceBottomSheet(
                      context: context,
                      allowPhoto: true,
                    );
                    if (selectedMedia != null &&
                        selectedMedia.every((m) =>
                            validateFileFormat(m.storagePath, context))) {
                      setState(() => _model.isDataUploading = true);
                      var selectedUploadedFiles = <FFUploadedFile>[];

                      try {
                        selectedUploadedFiles = selectedMedia
                            .map((m) => FFUploadedFile(
                                  name: m.storagePath.split('/').last,
                                  bytes: m.bytes,
                                  height: m.dimensions?.height,
                                  width: m.dimensions?.width,
                                  blurHash: m.blurHash,
                                ))
                            .toList();
                      } finally {
                        _model.isDataUploading = false;
                      }
                      if (selectedUploadedFiles.length ==
                          selectedMedia.length) {
                        setState(() {
                          _model.uploadedLocalFile =
                              selectedUploadedFiles.first;
                        });
                      } else {
                        setState(() {});
                        return;
                      }
                    }
                  },
                  text: 'Insert Picture Here',
                  options: FFButtonOptions(
                    width: 300.0,
                    height: 157.0,
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                    elevation: 3.0,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      setState(() {});
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: 'Post',
                          options: FFButtonOptions(
                            width: 150.0,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
<<<<<<< Updated upstream
              ].divide(const SizedBox(height: 20.0)),
=======
                //Description Field
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
>>>>>>> Stashed changes
            ),
          ),
        ),
      ),
    );
  }
}
