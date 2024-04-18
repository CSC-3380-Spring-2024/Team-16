import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'fridge_model.dart';
export 'fridge_model.dart';

class FridgeWidget extends StatefulWidget {
  const FridgeWidget({super.key});

  @override
  State<FridgeWidget> createState() => _FridgeWidgetState();
}

class _FridgeWidgetState extends State<FridgeWidget> {
  late FridgeModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, Map<String, dynamic>> ingredients = {
    'Milk': {'quantity': 1, 'unit': 'liter'}
  };
  List<String> selectedIngredients = [];
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
            decoration: InputDecoration(
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 16.0, 0.0, 16.0),
                  child: Text(
                    'Ingredients in Your Fridge',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                for (var ingredient in ingredients.keys)
                  if (ingredient.toLowerCase().contains(_searchQuery))
                    buildIngredient(
                      ingredient,
                      'https://images.unsplash.com/photo-1600788907416-456578634209?q=80&w=1350&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90oy1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 16.0, 16.0, 16.0),
                  child: FFButtonWidget(
                    onPressed: () {
                      _showAddIngredientDialog();
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIngredient(String name, String imageUrl) {
    Map<String, dynamic>? details = ingredients[name];
    bool isSelected = selectedIngredients.contains(name);
    return Dismissible(
      key: Key(name),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          ingredients.remove(name);
          selectedIngredients.remove(name);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$name removed from your fridge"),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: InkWell(
        onTap: () {
          setState(() {
            if (isSelected) {
              selectedIngredients.remove(name);
            } else {
              selectedIngredients.add(name);
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? FlutterFlowTheme.of(context).tertiary
                : FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color: Color(0xFF8476AB)), // Apply grayish purple border
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$name - ${details?['quantity']} ${details?['unit']}',
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                      ),
                      Text(
                        'Expires in 7 days',
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
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _showEditIngredientDialog(name),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddIngredientDialog() {
    TextEditingController ingredientController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    String unit = 'liter'; // Default unit

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Ingredient'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ingredientController,
                decoration: InputDecoration(
                  labelText: "Ingredient Name",
                ),
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(
                  labelText: "Quantity",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              DropdownButton<String>(
                value: unit,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    unit = newValue!;
                  });
                },
                items: <String>['liter', 'gram', 'piece']
                    .map<DropdownMenuItem<String>>((String value) {
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
              child: Text('Add'),
              onPressed: () {
                String ingredient = ingredientController.text;
                if (ingredient.isNotEmpty && quantityController.text.isNotEmpty) {
                  setState(() {
                    double quantity = double.tryParse(quantityController.text) ?? 0;
                    if (quantity > 0) {
                      ingredients[ingredient] = {'quantity': quantity, 'unit': unit};
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showEditIngredientDialog(String name) {
    TextEditingController quantityController = TextEditingController(text: ingredients[name]?['quantity'].toString());
    String unit = ingredients[name]?['unit']; // Get current unit

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Quantity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: quantityController,
                decoration: InputDecoration(
                  labelText: "Quantity",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              DropdownButton<String>(
                value: unit,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    unit = newValue!;
                  });
                },
                items: <String>['liter', 'gram', 'piece']
                    .map<DropdownMenuItem<String>>((String value) {
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
              child: Text('Update'),
              onPressed: () {
                if (quantityController.text.isNotEmpty) {
                  setState(() {
                    double quantity = double.tryParse(quantityController.text) ?? 0;
                    if (quantity > 0) {
                      ingredients[name] = {'quantity': quantity, 'unit': unit};
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}


  void _showRecipeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Suggested Recipes',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: ListView(
                    children: [
                      _buildRecipeCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildRecipeCard() {
    String recipeTitle = "Delicious Iced Coffee";
    String authorName = "John Doe";
    String description =
        "A simple and delightful iced coffee with whipping cream, perfect for summer.";
    double rating = 4.5;
    String difficulty = "Easy";

    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // Changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(recipeTitle,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 4.0),
          Text(authorName,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal)),
          SizedBox(height: 8.0),
          Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://media.istockphoto.com/id/483014582/photo/iced-coffee-with-whipping-cream.jpg?s=1024x1024&w=is&k=20&c=nPBZMC-YZCA7wjssHCh5UDWoEhv11GqYrwJ6s0ZIplk="),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          SizedBox(height: 8.0),
          Text(description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.0)),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text("⭐ $rating", style: TextStyle(fontSize: 14.0)),
              Spacer(),
              Text("Difficulty: $difficulty", style: TextStyle(fontSize: 14.0)),
            ],
          ),
        ],
      ),
    );
  }

