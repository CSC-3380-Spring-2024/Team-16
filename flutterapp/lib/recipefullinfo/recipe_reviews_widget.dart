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

return Scaffold(
  body: CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(
        pinned: true,
        floating: true,
        expandedHeight: 200.0,
        flexibleSpace: FlexibleSpaceBar(
          title: const Text(
            'REVIEWS FOR FOOD',
            style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.w900),
          ),
          background: CachedNetworkImage(
            imageUrl: "https://images.pexels.com/photos/1860208/pexels-photo-1860208.jpeg?cs=srgb&dl=cooked-food-1860208.jpg&fm=jpg",
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Star rating, could use a package or custom widget to display
                    Row(
                      children: <Widget>[
                        Text('Rating:',style:TextStyle(fontWeight: FontWeight.w900)),
                        Icon(Icons.star, color: Colors.amber),
                      ],
                    ),
                    // Review text
                    Row(
                          children: <Widget>[
                            Text('Difficulty:',style:TextStyle(fontWeight: FontWeight.w900)),
                            Icon(Icons.star, color: Colors.red)
                          ],
                    ),
                    Row(
                      children: [
                        Text('Description:',style:TextStyle(fontWeight: FontWeight.w900)),
                        Text(
                          'This shit fire',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  ),
);






    // RecipeData? recipe = AppData.viewedRecipe;

    // return GestureDetector(
    //   onTap: () => _model.unfocusNode.canRequestFocus
    //       ? FocusScope.of(context).requestFocus(_model.unfocusNode)
    //       : FocusScope.of(context).unfocus(),
    //   child: Scaffold(
    //     key: scaffoldKey,
    //     backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
    //     body: SafeArea(
    //       top: true,
    //       child: SingleChildScrollView(
    //         child: Text("Hello World! (Viewing ${AppData.viewedRecipe!.name})")
    //       ),
    //     ),
    //   ),
    // );
  }
}
