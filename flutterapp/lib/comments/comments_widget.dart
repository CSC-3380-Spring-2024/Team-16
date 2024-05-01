import 'package:flutter/material.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class CommentsWidget extends StatefulWidget {
  const CommentsWidget({Key? key}) : super(key: key);

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  final TextEditingController commentController = TextEditingController();
  final List<String> comments = [];

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void postComment() {
    if (commentController.text.isNotEmpty) {
      setState(() {
        comments.add(commentController.text);
        commentController.clear(); // Clear the input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              CommentSection(
                commentController: commentController,
                onPost: postComment,
              ),
              const SizedBox(height: 16),
              // Display the posted comments
              for (var comment in comments)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User123', // Replace with actual username
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        comment,
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Just now', // Add time info dynamically if required
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).tertiaryColor,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentSection extends StatelessWidget {
  final TextEditingController commentController;
  final VoidCallback onPost;

  const CommentSection({
    Key? key,
    required this.commentController,
    required this.onPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Comments',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: commentController,
            decoration: const InputDecoration(
              hintText: 'Type your comment here...',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16),
          FFButtonWidget(
            onPressed: onPost,
            text: 'Post',
            options: FFButtonOptions(
              height: 30.0,
              padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              color: FlutterFlowTheme.of(context).primary,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
