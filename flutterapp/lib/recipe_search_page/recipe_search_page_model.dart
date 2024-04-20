import '/flutter_flow/flutter_flow_util.dart';
import 'recipe_search_page_widget.dart' show RecipeSearchPageWidget;
import 'package:flutter/material.dart';

class RecipeSearchPageModel extends FlutterFlowModel<RecipeSearchPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
