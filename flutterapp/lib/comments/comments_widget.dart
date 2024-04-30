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
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FullPost(isPreview: false,),
      Container(
        decoration: BoxDecoration(
                border: Border.all(
                color: Colors.black, ),
        ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'cocksucker69',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'i like bar',
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
          const SizedBox(height: 4),
          Text(
            '4hr ago',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
      ],
    );
  }
}
