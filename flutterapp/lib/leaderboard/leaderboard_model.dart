import '/flutter_flow/flutter_flow_util.dart';
import 'leaderboard_widget.dart' show LeaderboardWidget;
import 'package:flutter/material.dart';

class LeaderboardModel extends FlutterFlowModel<LeaderboardWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
