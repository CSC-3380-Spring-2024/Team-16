import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodappproject/app_data.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_theme.dart';

/*
 * This is the header used by most subpages of the app.
 * text: Text to display in header
 * backNav?: page to return to. if null, back button will not appear.
 */
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

class ReorderableExample extends StatefulWidget {
  late List<dynamic> items;
  late bool editable;
  late String header;

  ReorderableExample({
    super.key,
    required this.editable,
    required this.items,
    required this.header,
    });

  @override
  State<ReorderableExample> createState() => _ReorderableListViewExampleState();
}

class _ReorderableListViewExampleState extends State<ReorderableExample> {

  @override
  Widget build(BuildContext conext) {
    
    FlutterFlowTheme ffTheme = FlutterFlowTheme.of(context);
    print(widget.items.length);

    return Padding(
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
              Text(
                widget.header,
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'Outfit',
                      letterSpacing: 0.0,
                    ),
              ),
              ReorderableListView(
                buildDefaultDragHandles: widget.editable ? true : false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //padding: const EdgeInsets.symmetric(horizontal: 40),
                children: <Widget>[
                  for (int index = 0; index < widget.items.length; index++)
              
                    //Each Individual List Item
                    Dismissible(
                      key: UniqueKey(),
                      //Dismissible bs
                      direction: widget.editable ? DismissDirection.endToStart : DismissDirection.none,
                      onDismissed: (direction) {
                        setState(() {
                          //widget.items.removeWhere((item) => item['name'] == ingredient['name']);
                          widget.items.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${widget.items[index]} dismissed", style: FlutterFlowTheme.of(context).bodySmall),
                          ),
                        );
                      },
                      /*background: Container(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 40.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),*/
                      ////////////////
                      
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: const Color.fromARGB(255, 106, 106, 106))
                          ),
                        child: ListTile(
                          title: widget.items.first.runtimeType == List 
                            ? Text('${widget.items[index][1]}			|  ${widget.items[index][0]}',style: FlutterFlowTheme.of(context).bodySmall)
                            : Text('$index			|  ${widget.items[index]}',style: FlutterFlowTheme.of(context).bodySmall),
                        ),
                      ),
                    ),
                    ////////////////////////////
                    
                ],
              
                /* onReorder calls provide the index of the item that the user moved
                 * & its new index. This is so that the app can update the state
                 * & rebuild accordingly.
                 */
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    dynamic item = widget.items.removeAt(oldIndex);
                    widget.items.insert(newIndex, item);
                  });
                },
                // END ONREORDER //
              
              ),
              Visibility(
                visible: widget.editable ? true : false,
                child: ElevatedButton(
                  onPressed: () {},//=> _showAddIngredientDialog(),
                  child: const Text('Add Ingredient'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeValueBar extends StatelessWidget {
  const RecipeValueBar({
    super.key,
    required this.recipeData,
    required this.isRating
  });

  final RecipeData recipeData;
  final bool isRating;

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme ffTheme = FlutterFlowTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( isRating ? "Rating:" : "Difficulty:",
          style: ffTheme.bodyMedium
        ),
        Row(
          children: [
            SizedBox(
              width: 24.0,
              child: Text(
                isRating ? recipeData.starRating.toString() : recipeData.difficultyRating.toString(),
                style: ffTheme.bodyMedium,
            ),
            ),
            Expanded(
              child: Container(
                height: 5.0,
                decoration: BoxDecoration(
                  color: Colors.grey, // Background fill color
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: isRating ? recipeData.starRating/5 : recipeData.difficultyRating/5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isRating
                        ? _calculateBarColor((recipeData.starRating-1)/4)
                        : _calculateBarColor(1-((recipeData.difficultyRating-1)/4)),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
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
}
