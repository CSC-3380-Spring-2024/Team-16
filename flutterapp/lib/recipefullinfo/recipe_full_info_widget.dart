/*
 * This widget is a page which shows all information about a recipe.
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:foodappproject/app_data.dart';
import 'package:foodappproject/app_shared.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_icon_button.dart';
import 'package:foodappproject/quantity_converter.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'recipe_full_info_model.dart';
export 'recipe_full_info_model.dart';

class RecipeFullInfoWidget extends StatefulWidget {
  const RecipeFullInfoWidget({super.key});

  @override
  State<RecipeFullInfoWidget> createState() => _RecipeFullInfoWidgetState();
}

class _RecipeFullInfoWidgetState extends State<RecipeFullInfoWidget> {
  late RecipeFullInfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecipeFullInfoModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final ffTheme = FlutterFlowTheme.of(context);

    final BoxDecoration standardBoxDeco = BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      borderRadius: BorderRadius.circular(16)
    );

    RecipeData? recipe = AppData.viewedRecipe;

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8,0,8,0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 16.0, 0.0, 16.0),
                    child: Text(
                      recipe!.name,
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                            fontFamily: 'Outfit',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 0.0, 16.0),
                    child: Text(
                      'By ${AppData.viewedRecipe!.name}',
                      style: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.all(0.0),
                    child: Container(
                      width: double.infinity,
                      height: 240.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: CachedNetworkImage(
                          imageUrl: AppData.viewedRecipe.backdrop != null ? AppData.viewedRecipe.backdrop! : "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                        ),
                        /*Image.network(
                          'https://images.unsplash.com/photo-1651255322739-f1b8e882dd1c?w=1280&h=720',
                          width: double.infinity,
                          height: 240.0,
                          fit: BoxFit.cover,
                        ),*/
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0,8,0,8),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3, //take up two thirds horizontal space
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  RecipeValueBar(recipeData: recipe, isRating: true,),
                                  RecipeValueBar(recipeData: recipe, isRating: false,),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0,),
                          Expanded(
                            flex: 2, //take up two thirds horizontal space
                            
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: (){
                                      context.pushNamed("RecipeReviews");
                                    }, 
                                    child: const Text("See Reviews...")
                                  ),
                                  TextButton(
                                    onPressed: (){}, 
                                    child: const Text("Add to Favorites")
                                  ),
                                  TextButton(
                                    onPressed: (){}, 
                                    child: const Text("Add to Collection...")
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    
                    child: Column(
                      children: [
                        Text(
                          "Description",
                          style: FlutterFlowTheme.of(context).titleLarge.override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0.0,
                              ),
                        ),
                        const SizedBox(height: 4),
                        MarkdownBody(
                          data: AppData.viewedRecipe!.description,
                          styleSheet: MarkdownStyleSheet(
                            p: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ReorderableExample(
                    header: "Ingredients",
                    items: AppData.viewedRecipe!.ingredients,
                    editable: false
                  ),
                  ReorderableExample(
                    editable: false,
                    header: "Methods",
                    items: AppData.viewedRecipe!.method
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      setState(() {
                        AppData.isTrackingRecipe = !AppData.isTrackingRecipe;
                        if (!AppData.isTrackingRecipe) {
                          _showEndTrackingDialog();
                        }
                      });
                    },
                    text: AppData.isTrackingRecipe ? 'Stop Tracking Recipe' : 'Start Tracking Recipe',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      color: AppData.isTrackingRecipe ? ffTheme.secondary : ffTheme.primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: AppData.isTrackingRecipe ? Colors.black : Colors.white,
                              ),
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  const SizedBox(height:60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

    void _showEndTrackingDialog() {
      FlutterFlowTheme ffTheme = FlutterFlowTheme.of(context);
    TextEditingController ingredientController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    String unit = 'liter'; // Default unit

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Finished?', style: ffTheme.headlineSmall,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
              },
            ),
            TextButton(
              child: const Text('Complete Recipe'),
              onPressed: () {
                for (List<dynamic> ingredient in AppData.viewedRecipe!.ingredients) {
                  for (IngredientData ingredientData in AppData.openedFridge.contents) {
                    if (ingredient[0] == ingredientData.name) {
                      print("ambatasubtract");
                      QuantityStruct neg = Quantity.parseQuantity(ingredient[1]);
                      ingredientData.subtractQuantity(neg);
                    }
                  }
                }
                clearRecipeInfo();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Discard Changes'),
              onPressed: () {
                clearRecipeInfo();
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      },
    );
  }

  void clearRecipeInfo() {
    setState(() {
      AppData.completedIngredients.clear();
      AppData.completedMethods.clear();
    });
  }
}
