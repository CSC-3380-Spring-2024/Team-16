/*
 * This widget is a page which shows all information about a recipe.
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

class RecipeReviewsWidget extends StatefulWidget {
  const RecipeReviewsWidget({super.key});

  @override
  State<RecipeReviewsWidget> createState() => _RecipeReviewsWidgetState();
}

class _RecipeReviewsWidgetState extends State<RecipeReviewsWidget> {
  late RecipeFullInfoModel _model;
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _difficultyController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecipeFullInfoModel());
  }

  @override
  void dispose() {
    _model.dispose();
    _reviewController.dispose();
    _ratingController.dispose();
    _difficultyController.dispose();
    super.dispose();
  }

  void _submitReview() {
    final newReview = _reviewController.text;
    final int? rating = int.tryParse(_ratingController.text);
    final int? difficulty = int.tryParse(_difficultyController.text);

    // Handle saving or processing the new review, rating, and difficulty here
    // e.g., add them to a list of reviews, send them to an API, etc.
    
    _reviewController.clear(); // Clear the input fields after submitting
    _ratingController.clear();
    _difficultyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ffTheme = FlutterFlowTheme.of(context);

    final BoxDecoration standardBoxDeco = BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      borderRadius: BorderRadius.circular(16),
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                  pinned: true,
                  floating: true,
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Reviews For ${AppData.viewedRecipe.name}',
                      style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                        fontFamily: 'Readex Pro',
                        fontSize: 25,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                    background: CachedNetworkImage(
                      imageUrl:
                          "https://images.pexels.com/photos/1860208/pexels-photo-1860208.jpeg?cs=srgb&dl=cooked-food-1860208.jpg&fm=jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, index) {
                      // Each card is built here
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Reviewer's details can go here (e.g., name, date, etc.)
                              Text(
                                'Reviewer\'s Name - ${index + 1}',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                    ),
                              ),
                              // Star rating, could use a package or custom widget to display
                              Container(
                                width: 200,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RecipeValueBar(
                                        recipeData: AppData.viewedRecipe!,
                                        isRating: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Review text
                              Container(
                                width: 200,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RecipeValueBar(
                                        recipeData: AppData.viewedRecipe!,
                                        isRating: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Description:',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                        ),
                                  ),
                                  Text(
                                    'This shit fire,This shit fire,This shit fire,This shit fire',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: 10, // Example value, replace it with your data count
                  ),
                ),
              ],
            ),
          ),
          // Add the review input box
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _reviewController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Write your review...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: _ratingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Rating (1-5)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: _difficultyController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Difficulty (1-5)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _submitReview,
                  child: Text('Submit Review'),

                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

