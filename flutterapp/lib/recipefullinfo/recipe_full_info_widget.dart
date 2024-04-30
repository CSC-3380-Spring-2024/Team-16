/*
 * This widget is a page which shows all information about a recipe.
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:foodappproject/app_data.dart';
import 'package:foodappproject/app_shared.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_icon_button.dart';

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
                        EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 240.0,
                      decoration: BoxDecoration(
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: CachedNetworkImage(
                          imageUrl: "https://images.pexels.com/photos/1860208/pexels-photo-1860208.jpeg?cs=srgb&dl=cooked-food-1860208.jpg&fm=jpg",
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
                    
                    child: MarkdownBody(
                      data: AppData.viewedRecipe!.description,
                      styleSheet: MarkdownStyleSheet(
                        p: FlutterFlowTheme.of(context).bodyMedium,
                      ),
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Text(
                          '(Replace w serve size)',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'Servings',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}