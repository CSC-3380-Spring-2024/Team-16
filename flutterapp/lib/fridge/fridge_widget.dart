import 'package:flutter/material.dart';
import 'package:foodappproject/app_shared.dart';
import 'package:foodappproject/quantity_converter.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'fridge_model.dart';
import 'package:foodappproject/app_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
export 'fridge_model.dart';

class FridgeWidget extends StatefulWidget {
  const FridgeWidget({super.key});

  @override
  State<FridgeWidget> createState() => _FridgeWidgetState();
}

class _FridgeWidgetState extends State<FridgeWidget> {
  late FridgeModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FridgeData openedFridge = AppData.openedFridge;

  Map<String, Map<String, dynamic>> ingredients = { 
    'Milk': {'quantity': 1, 'unit': 'liter'}
  };
  List<IngredientData> selectedIngredients = [];
  String _searchQuery = '';
  final TextEditingController _typeAheadController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FridgeModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }


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
          leading: FFButtonWidget(
            onPressed: () async {
              Navigator.pop(context);
            },
            text: '',
            icon: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 15.0,
            ),
            options: FFButtonOptions(
              height: 40.0,
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          title: TextField(
            controller: _typeAheadController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
            decoration: const InputDecoration(
              hintText: 'Search ingredients...',
              suffixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
            style: TextStyle(
                fontSize: 18, color: FlutterFlowTheme.of(context).primaryText),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 0.0, 16.0),
                          child: Text(
                            openedFridge.name,
                            style: FlutterFlowTheme.of(context).headlineMedium.override(
                                  fontFamily: 'Outfit',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:5),
                for (var ingredient in openedFridge.contents)//ingredients.keys)//TODO: Remove ingredients.keys (wherever that is)
                  if (ingredient.name.toLowerCase().contains(_searchQuery))
                    buildIngredient(ingredient),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 16.0, 16.0, 16.0),
                  child: FFButtonWidget(
                    onPressed: () {
                      _showAddIngredientDialog(context);
                    },
                    text: 'Add Ingredient',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                              ),
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                if (selectedIngredients.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: FFButtonWidget(
                      onPressed: () {
                        print(
                            'Find Recipe Button pressed for $selectedIngredients');
                        _showRecipeDialog(context);
                      },
                      text: 'Find Recipe',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50.0,
                        color: FlutterFlowTheme.of(context).tertiary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
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

  Widget buildIngredient(IngredientData ingredientData) {
    //Map<String, dynamic>? details = ingredients[name];
    String hashCode = ingredientData.hashCode.toString();
    bool isSelected = selectedIngredients.contains(ingredientData);
    return Dismissible(
      key: Key(hashCode),
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          //TODO: Fix dismissable
          openedFridge.contents.remove(ingredientData);
          selectedIngredients.remove(ingredientData);
          suggestedRecipes.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${ingredientData.name} removed from your fridge"),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: InkWell(
        onTap: () {
          setState(() {
            if (isSelected) {
              suggestedRecipes.clear();
              selectedIngredients.remove(ingredientData);
            } else {
              suggestedRecipes.clear();
              selectedIngredients.add(ingredientData);
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? FlutterFlowTheme.of(context).primary
                  : FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(20.0),
              // border: Border.all(
              //     color: const Color.fromARGB(255, 204, 199, 216)), // Apply grayish purple border
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      Icons.circle, // Replace with your desired icon
                      color: FlutterFlowTheme.of(context).primaryBackground, // Customize the icon color
                      size: 12, // Set the icon size
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${ingredientData.name} - ${ingredientData.quantity}',// - ${details?['quantity']} ${details?['unit']}',
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                      ),
                      Text(
                        'Expires in ${ingredientData.expiry} days',
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () => _showSubtractQuantityDialog(ingredientData),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  void _showAddIngredientDialog(BuildContext context) async {
    String unit = 'liter'; // Default unit
    List<String> kOptions = []; // Initialize as empty list

    // Show CircularProgressIndicator while fetching options
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController ingredientController = TextEditingController();
        TextEditingController quantityController = TextEditingController();
        TextEditingController unitController = TextEditingController();
        unitController.text = "g";
        return AlertDialog(
          title: const Text('Add Ingredient'),
          content: FutureBuilder<List<String>>(
            future: fetchOptions(), // Fetch options asynchronously
            builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                kOptions = snapshot.data ?? []; // Update kOptions with fetched data
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return kOptions.where((String option) {
                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        ingredientController.text = selection;
                        print(ingredientController.text);
                      },
                    ),
                    TextField(
                      controller: quantityController,
                      decoration: const InputDecoration(
                        labelText: "Quantity",
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                    QuantityDropdown(dialogSelectedUnit: "g", controller: unitController,),
                  ],
                );
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                print("BITCH");
                String ingredientName = ingredientController.text;
                if (ingredientName.isNotEmpty && quantityController.text.isNotEmpty) {
                  print("YEEEES");
                  setState(() {
                    double quantity = double.tryParse(quantityController.text) ?? 0;
                    unit = unitController.text;
                    if (quantity > 0) {
                      IngredientData newIngredient = IngredientData(
                        name: ingredientName, 
                        quantity: "$quantity $unit", 
                        expiry: 69 //TODO: Get days until expiry from server!!!!
                      );
                      Future(newIngredient.fetchIngredientInfo).whenComplete(() {setState(() {
                        newIngredient.expiry = newIngredient.ingredientInfo!.shelfLife;
                      });});
                      openedFridge.contents.add(newIngredient);
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }


Future<List<String>> fetchOptions() async {
  final response = await http.get(Uri.parse('http://localhost:8080/ingredient'));
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<String> options = data.map((e) => e.toString()).toList();
    return options;
  } else {
    throw Exception('Failed to load options');
  }
}

  void _showSubtractQuantityDialog (IngredientData ingredientData, ) {
    TextEditingController quantityController = TextEditingController();
    TextEditingController unitController = TextEditingController();
    unitController.text = ingredientData.parseQuantity().unit;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Subtract from ${ingredientData.name}...', style: FlutterFlowTheme.of(context).bodyLarge,),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(
                    labelText: "Quantity",
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Expanded(flex: 1,child: QuantityDropdown(
                  dialogSelectedUnit: ingredientData.parseQuantity().unit,
                  controller: unitController,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Update'),
              onPressed: () {
                if (quantityController.text.isNotEmpty) {
                  setState(() {
                    double quantity = double.tryParse(quantityController.text) ?? 0;
                    if (quantity > 0) {
                      ingredientData.subtractQuantity(QuantityStruct(amount: double.parse(quantityController.text), unit: unitController.text),);
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  List<RecipeData> suggestedRecipes = [];
    //MARK: fetchSuggstedRecipes
  Future<List<RecipeData>> fetchSuggestedRecipes() async {
    /// Yes i am manually making the json
    /// i could not figure out how to make the library work
    /// might put a TODO here to fix later :')
    String sendingBody = '{"listOfIngredients":[';
    print(sendingBody);
    for (var i = 0; i < selectedIngredients.length; i++) {
    var ingredient = selectedIngredients[i];
    sendingBody += '{"name":"${ingredient.name}","quantity":"${ingredient.quantity}","expiry":"${ingredient.expiry}"}';
    if (i < selectedIngredients.length - 1) {
        sendingBody += ',';
    }
}
    //sendingBody += jsonEncode(_FridgeWidgetState().selectedIngredients);
    sendingBody += ']}';
    print(sendingBody);

    const String apiUrl = 'http://localhost:8080/ingredient';
    print("ambatatry");
    if (suggestedRecipes.length != 0) {
      return suggestedRecipes;
    }
    try {
      
      final response = await http.post(
        Uri.parse(apiUrl),
        body: sendingBody,
        headers: {'Content-Type': 'application/json'},
      );

      print("I tried");

      if (response.statusCode == 200) {
        List<RecipeData> recipes = (jsonDecode(response.body) as List<dynamic>)
          .map((json) => RecipeData.fromJson(json))
          .toList();
        print(recipes.first.uploadImage);
        suggestedRecipes = recipes;
        return recipes;
      } else {
        throw Exception('Failed to fetch recipes');
      }

    } catch (e) {
      print("FATAL ERROR INSIDE fetchSuggestedRecipes!");
      print(e);
      throw Exception('Error: $e');
    }
  }
void _showRecipeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Suggested Recipes",
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        letterSpacing: 0.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: FutureBuilder(
                    future: fetchSuggestedRecipes(),
                    builder: (context, snapshot) {
                      // error handling //
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();//TODO: fix ugly ass
                      } else if (snapshot.hasError) {
                        return const Text('Error loading recipes');
                      ///////////////////
                      } else if (snapshot.hasData) {
                        final recipes = snapshot.data;
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return RecipeCard(recipeData: snapshot.data![index],);
                          },
                        );
                      } else {
                        return const Text('No recipes found');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  16.0, 16.0, 0.0, 16.0),
              child: Text(
                text,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      letterSpacing: 0.0,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RecipeCard extends StatelessWidget {
  final RecipeData recipeData;

  const RecipeCard({
    super.key,
    required this.recipeData
  });

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme ffTheme = FlutterFlowTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap:() {
          AppData.viewedRecipe = recipeData;
          context.pushNamed("RecipeFullInfo");
        },
        child: Ink(
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: ffTheme.secondaryBackground,
            borderRadius: BorderRadius.circular(40),
          ),
          
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    width:90,
                    height:90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                      child: Image.network(
                        'https://th.bing.com/th/id/R.99a429149891b8331ab9a4d9dcdeca89?rik=ZFGjK2aI0XNcog&riu=http%3a%2f%2fwww.pixelstalk.net%2fwp-content%2fuploads%2f2016%2f08%2fFresh-hot-delicious-food-wallpaper.jpg&ehk=YcpVrjnOnSm%2fhnTl3VFd3ve98wBRCKiyDEZj%2fJ43ix8%3d&risl=&pid=ImgRaw&r=0', // Replace with your image URL
                        fit: BoxFit.cover, // Adjust the fit mode (cover, contain, etc.)
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  buildRecipeTidbit("${recipeData.ingredients.length} Ingredients", 0, FlutterFlowTheme.of(context)),
                  buildRecipeTidbit("${recipeData.servingSize} Servings", 0, FlutterFlowTheme.of(context)),
                  buildRecipeTidbit("1 Substitution", 1, FlutterFlowTheme.of(context)),
                ],
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Expanded(
                flex: 2, // Takes two-thirds of the remaining space
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( recipeData.name,
                      style: ffTheme.bodyLarge
                    ),
                    const Padding(padding: EdgeInsets.all(1)),
                    Text( "",
                      style: ffTheme.bodySmall
                    ),
                    const Padding(padding: EdgeInsets.all(2)),
                    Text( //TO MODIFY
                      recipeData.description,
                      style: ffTheme.labelSmall,
                      maxLines:8,
                      overflow: TextOverflow.ellipsis, // Truncate with ellipsis
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Expanded(
                flex: 1, // Takes one-third of the remaining space
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecipeValueBar(recipeData: recipeData, isRating: true),
                    RecipeValueBar(recipeData: recipeData, isRating: false),
                    buildRecipeTidbit("4,324 Reviews", 2, ffTheme)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RichText buildRecipeTidbit(String text, int iconEnum, FlutterFlowTheme ffTheme) {
    Icon icon = Icon(Icons.info, size: 12, color: ffTheme.secondaryText);
    if (iconEnum == 1) {
      icon = Icon(Icons.info, size: 12, color: ffTheme.warning);
    } else if (iconEnum == 2) {
      icon = Icon(Icons.people, size:12, color: ffTheme.secondaryText);
    }
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: icon,
          ),
          const TextSpan(text:" "),
          TextSpan(
            text: text,
            style: ffTheme.labelSmall,
          ),
        ],
      ),
      
    );
  }
}


Color _calculateBarColor(double percentage) {
  if (percentage < 0.5) {
    final hsvColor1 = HSVColor.fromColor(Colors.red);
    final hsvColor2 = HSVColor.fromColor(Colors.amber);
    final interpolatedColor = HSVColor.lerp(hsvColor1, hsvColor2, percentage * 2)!;
    return interpolatedColor.toColor();
  } else {
    final hsvColor1 = HSVColor.fromColor(Colors.amber);
    final hsvColor2 = HSVColor.fromColor(Colors.green);
    final interpolatedColor = HSVColor.lerp(hsvColor1, hsvColor2, (percentage - 0.5) * 2)!;
    return interpolatedColor.toColor();
  }
}