import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodappproject/app_shared.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_model.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_theme.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_widgets.dart';

import 'grocery_model.dart';
export 'grocery_model.dart';

class GroceryWidget extends StatefulWidget {
  const GroceryWidget({super.key});

  @override
  State<GroceryWidget> createState() => _GroceryWidgetState();
}

class _GroceryWidgetState extends State<GroceryWidget> {
  late GroceryModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroceryModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FFButtonWidget(
            onPressed: () async {
              Navigator.pop(context);
            },text: '',
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
      ),
      body: SafeArea(
          top: true,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ReorderableExample(editable: false, items: ['Work in progress'], header: 'Grocery List')
                  ],
                ),
              ),
            ],
      ),
    ),
    );
  }
}