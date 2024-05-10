import 'dart:collection';

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
  late Function(List<dynamic>)? dialogMethod;

  ReorderableExample({
    super.key,
    required this.editable,
    required this.items,
    required this.header, 
    this.dialogMethod,
    //void Function(List<Map<String,String>>)? dialogMethod,
    });

  @override
  State<ReorderableExample> createState() => _ReorderableListViewExampleState();
}

class _ReorderableListViewExampleState extends State<ReorderableExample> {

  @override
  Widget build(BuildContext context) {
    
    FlutterFlowTheme ffTheme = FlutterFlowTheme.of(context);
    List<int> taskList;

    if (widget.items.isNotEmpty && widget.items.first is List) {
      taskList = AppData.completedMethods;
    } else {
      taskList = AppData.completedIngredients;
    }

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.header,
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Outfit',
                        letterSpacing: 0.0,
                      ),
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
                      direction: widget.editable ? DismissDirection.endToStart : AppData.isTrackingRecipe ? DismissDirection.startToEnd : DismissDirection.none,
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          setState(() {
                            widget.items.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Item removed", style: FlutterFlowTheme.of(context).bodySmall),
                            ),
                          );
                        } else if (direction == DismissDirection.startToEnd){
                        }
                      },
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return true;
                        } else {
                          setState(() {
                            if (taskList.contains(index)) {
                              taskList.remove(index);
                            } else {
                              taskList.add(index);
                            }
                          });
                          return false;
                        }
                      },
                      background: Container(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(18),
                        child: !widget.editable ? widget.items.isNotEmpty ? widget.items.first is List
                                ? Text('${widget.items[index][1]}			|  ${widget.items[index][0]}',style: FlutterFlowTheme.of(context).bodySmall)
                                : widget.items.first is Map
                                ? Text('${widget.items[index]["quantity"]} ${widget.items[index]["unit"]}  | ${widget.items[index]["name"]}',style: FlutterFlowTheme.of(context).bodySmall)
                                : Text('${index+1}			|  ${widget.items[index]}',style: FlutterFlowTheme.of(context).bodySmall) : const SizedBox() : const SizedBox(),
                      ),
                      ////////////////
                      
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: taskList.contains(index) ? ffTheme.secondaryBackground : ffTheme.primaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            //border: Border.all(color: const Color.fromARGB(255, 106, 106, 106))
                            ),
                          child: Container(
                            child: ListTile(
                              title: widget.items.isNotEmpty ? widget.items.first is List
                                ? Text('${widget.items[index][1]}			|  ${widget.items[index][0]}',style: FlutterFlowTheme.of(context).bodySmall)
                                : widget.items.first is Map
                                ? Text('${widget.items[index]["quantity"]} ${widget.items[index]["unit"]}  | ${widget.items[index]["name"]}',style: FlutterFlowTheme.of(context).bodySmall)
                                : Text('${index+1}			|  ${widget.items[index]}',style: FlutterFlowTheme.of(context).bodySmall) : const SizedBox(),
                            ),
                          ),
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
                child: TextButton(
                  onPressed: () {
                    widget.dialogMethod!(widget.items);
                  },
                  child: const Text('+ Add...'),
                  /*style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),*/
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuantityDropdown extends StatefulWidget {
  final List<String> units = ["L", "mL","oz","cup","g", "qt","kg","lb","tsp","tbsp","unit"];
  late String dialogSelectedUnit;
  TextEditingController controller;

  QuantityDropdown({
    required this.dialogSelectedUnit,
    required this.controller,
  });

  @override
  _QuantityDropdownState createState() => _QuantityDropdownState();
}

class _QuantityDropdownState extends State<QuantityDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dialogSelectedUnit,
      isExpanded: true,
      onChanged: (String? newValue) {
        setState(() {
          widget.dialogSelectedUnit = newValue!;
          widget.controller.text = newValue;
        });
      },
      items: widget.units.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
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
