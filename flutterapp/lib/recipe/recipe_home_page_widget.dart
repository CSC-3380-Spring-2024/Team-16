import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodappproject/app_data.dart';
import 'package:foodappproject/app_shared.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'recipe_home_page_model.dart';
export 'recipe_home_page_model.dart';

class RecipeHomePageWidget extends StatefulWidget {
  const RecipeHomePageWidget({super.key});

  @override
  State<RecipeHomePageWidget> createState() => _RecipeHomePageWidgetState();
}

class _RecipeHomePageWidgetState extends State<RecipeHomePageWidget> {
  late RecipeHomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  RecipeData dummyRecipe = RecipeData(
    name: "Spaghetti Carbonara",
    starRating: 2.1,
    difficultyRating: 4.5,
    servingSize: 4,
    method: [
      "Boil water in a large pot.",
      "Cook spaghetti according to package instructions.",
      "In a skillet, cook pancetta until crispy.",
      "Whisk together eggs, cheese, and black pepper.",
      "Drain spaghetti and toss with egg mixture.",
      "Add pancetta and mix well. Serve hot."
    ],
    youtubeVid: "https://www.youtube.com/watch?v=MHMQi9jygMA",
    description:
        '''Classic *Italian* pasta dish with creamy egg and cheese sauce, topped with crispy pancetta.
I ***love*** italian seasoning. It ~~isn't~~ delicious.
        ''',
    backdrop:
        "https://example.com/spaghetti_carbonara_backdrop.jpg",
    peopleReviewed: 50,
    ingredients: [
      ["Spaghetti", "200g"],
      ["Eggs", "2"],
      ["Pancetta", "100g"],
      ["Grated Parmesan cheese", "50g"],
      ["Black pepper", "to taste"],
    ],
    allIngredients: {
      "Spaghetti": "200g",
      "Eggs": "2",
      "Pancetta": "100g",
      "Grated Parmesan cheese": "50g",
      "Black pepper": "0g",
    },
  );


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecipeHomePageModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(text: "Recipes"),
              Align(
                alignment: AlignmentDirectional(0.93, 0.0),
                child: Text(
                  'Create\nRecipe',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Roboto',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 12.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.search_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: 200.0,
                                          child: TextFormField(
                                            controller: _model.textController,
                                            focusNode:
                                                _model.textFieldFocusNode,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Search recipes...',
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              focusedErrorBorder:
                                                  InputBorder.none,
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0.0,
                                                ),
                                            validator: _model
                                                .textControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderColor: FlutterFlowTheme.of(context).primary,
                        borderRadius: 20.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        fillColor: FlutterFlowTheme.of(context).accent1,
                        icon: Icon(
                          Icons.add,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          context.pushNamed('Create');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Popular Recipes',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 30.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(1.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'View All',
                        options: FFButtonOptions(
                          height: 30.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryText,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          AppData.viewedRecipe = AppData.dummyRecipe;
          context.pushNamed('RecipeFullInfo');
        },
        child: Container(
          width: 300.0,
          height: 140.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '${AppData.viewedRecipe.name}',
                style: FlutterFlowTheme.of(context)
                    .bodyMedium
                    .override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0.0,
                    ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: "https://images.pexels.com/photos/1860208/pexels-photo-1860208.jpeg?cs=srgb&dl=cooked-food-1860208.jpg&fm=jpg",
                        width: 140.0,
                        height: 115.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 140,
                        child: Row(
                          children: [
                            Expanded(child: RecipeValueBar(recipeData: AppData.viewedRecipe!, isRating: true)),
                          ],
                        ),
                      ),
                      Container(
                        width: 140,
                        child: Row(
                          children: [
                            Expanded(child: RecipeValueBar(recipeData: AppData.viewedRecipe!, isRating: false)),
                          ],
                        ),
                      ),
                      Container(
                        width: 140,
                        child: Row(
                          children:[
                            Text(
                            'Serving Size: 1',
                              style:FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                              fontFamily: 'Readex Pro',
                            ),
                           ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),

              Row(
  mainAxisSize: MainAxisSize.max,
  children: [
    Text(
      'Saved Recipes',
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Readex Pro',
            fontSize: 30.0,
            letterSpacing: 0.0,
          ),
    ),
    Expanded(
      child: Align(
        alignment: AlignmentDirectional(1.0, 0.0),
        child: FFButtonWidget(
          onPressed: () {
            print('Button pressed ...');
          },
          text: 'View All',
          options: FFButtonOptions(
            height: 30.0,
            padding: EdgeInsetsDirectional.fromSTEB(
                24.0, 0.0, 24.0, 0.0),
            iconPadding: EdgeInsetsDirectional.fromSTEB(
                0.0, 0.0, 0.0, 0.0),
            color: FlutterFlowTheme.of(context).primaryBackground,
            textStyle: FlutterFlowTheme.of(context)
                .titleSmall
                .override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                ),
            elevation: 3.0,
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).primaryText,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    ),
  ],
),
// Here, we add the ListView.builder to display favorite recipes
Container(
  height: 180.0, // Adjust size as necessary
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: AppData.favoriteRecipes.length,
    itemBuilder: (BuildContext context, int index) {
      RecipeData recipe = AppData.favoriteRecipes[index];
      return Card(
        child: Container(
          width: 300.0,
          child: Column(
            children: [
              Image.network(
                recipe.backdrop ?? '', // Default image if none provided
                fit: BoxFit.cover,
                height: 140.0,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(recipe.name, style: Theme.of(context).textTheme.headline6),
              ),
            ],
          ),
        ),
      );
    },
  ),
),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'My Recipes',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 30.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(1.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'View All',
                        options: FFButtonOptions(
                          height: 30.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryText,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Text(
                        '',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
