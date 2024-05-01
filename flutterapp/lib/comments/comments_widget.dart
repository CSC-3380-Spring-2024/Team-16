import 'package:flutter/material.dart';
import 'package:foodappproject/app_shared.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_icon_button.dart';
import 'package:foodappproject/home_page/home_page_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'comments_model.dart';
import 'package:foodappproject/app_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
export 'comments_model.dart';

class CommentsWidget extends StatefulWidget {
  const CommentsWidget({super.key});

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  late CommentsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommentsModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
  
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FullPost(isPreview: false),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),child: CommentSection()),
                Text(
                  'cocksucker69',
                  style: FlutterFlowTheme.of(context)
                      .titleSmall
                      .override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar i like bar ',
                  style: FlutterFlowTheme.of(context)
                      .titleSmall
                      .override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '4hr ago',
                  style: FlutterFlowTheme.of(context)
                      .bodySmall
                      .override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        letterSpacing: 0.0,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text("Like", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    const SizedBox(width: 16),
                    Icon(Icons.thumb_down_alt_outlined, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text("Dislike", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}

class CommentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Comments',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'Type your comment here...',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 16),
          FFButtonWidget(
                        onPressed: () {
                          //method
                        },
                        text: 'Post',
                        options: FFButtonOptions(
                          height: 30.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
          ),
        ],
      ),
    );
  }
}