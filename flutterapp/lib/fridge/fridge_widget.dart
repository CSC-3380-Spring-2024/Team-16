import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  String? selectedIngredient;  // Track selected ingredient

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
              context.pushNamed('HomePage');
            },
            text: '',
            icon: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 15.0,
            ),
            options: FFButtonOptions(
              height: 40.0,
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              color: FlutterFlowTheme.of(context).primaryBackground,
              textStyle: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Outfit',
                    fontSize: 50.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
              elevation: 3.0,
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          title: Text(
            'My Fridge',
            style: FlutterFlowTheme.of(context).headlineLarge.override(
                  fontFamily: 'Outfit',
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            FlutterFlowIconButton(
              buttonSize: 60.0,
              icon: FaIcon(
                FontAwesomeIcons.search,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
              onPressed: () {
                print('IconButton pressed ...');
              },
            ),
          ],
          centerTitle: false,
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
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 16.0),
                  child: Text(
                    'Ingredients in Your Fridge',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                buildIngredient('Eggs', 'https://images.unsplash.com/photo-1508681709134-5c29540d9964?w=1280&h=720', 'Expires in 10 days'),
                buildIngredient('Cheese', 'https://images.unsplash.com/photo-1701743807800-b406b9bd2423?w=1280&h=720', 'Expires in 7 days'),
                buildIngredient('Carrots', 'https://images.unsplash.com/photo-1644375386140-f22123ceeec4?w=1280&h=720', 'Expires in 3 days'),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Add Ingredient',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                      ),
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                if (selectedIngredient != null) // Conditional display of the Find Recipe button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Find Recipe Button pressed for $selectedIngredient');
                        _showRecipeDialog(context);
                      },
                      text: 'Find Recipe',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50.0,
                        color: FlutterFlowTheme.of(context).tertiary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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

  Widget buildIngredient(String name, String imageUrl, String expiry) {
    bool isSelected = selectedIngredient == name;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIngredient = isSelected ? null : name; // Toggle selection
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? FlutterFlowTheme.of(context).tertiary : FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF8476AB)), // Apply grayish purple border
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
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
                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      Text(
                        expiry,
                        style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRecipeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Smooth corner radius
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Dialog Title and Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Suggested Recipes',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                  // Replace with a dynamic list builder in a real app
                  children: [
                    _buildRecipeCard(),
                    // ... Add more cards
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
  // Replace with your recipe model or data structure
  String recipeTitle = "Charcoal Grilled Armadillo";
  String authorName = "Yolanda Smith";
  String description = "This recipe will give you the flaming shits! When I was born in Massachusetts...";
  double rating = 4.7;
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
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipeTitle,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Text(
          authorName,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 120.0, // Fixed height for the image
          color: Colors.blue, // Placeholder color
          // TODO: Add your image
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14.0),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            // Placeholder for rating bar
            Text("⭐ $rating", style: TextStyle(fontSize: 14.0)),
            Spacer(),
            Text("Difficulty: $difficulty", style: TextStyle(fontSize: 14.0)),
          ],
        ),
      ],
    ),
  );
}
}