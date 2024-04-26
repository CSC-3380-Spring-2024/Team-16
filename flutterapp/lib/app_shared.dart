import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodappproject/app_data.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_theme.dart';

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

    print(widget.items.length);

    return Container(
      color: Colors.grey,
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
                    background: Container(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 40.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    ////////////////
                    
                    child: Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
    );
  }
}