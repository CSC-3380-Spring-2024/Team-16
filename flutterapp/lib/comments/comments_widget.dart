import 'package:flutter/material.dart';
import 'package:foodappproject/app_data.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_theme.dart';
import '../apiService/apiService.dart';

class CommentsWidget extends StatefulWidget {
  final String postId;

  const CommentsWidget({required this.postId, Key? key}) : super(key: key);

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  late Future<List<Comment>> _commentsFuture;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  void _fetchComments() {
    setState(() {
      _commentsFuture = NetworkService.getComments(widget.postId);
    });
  }

  void _handleLike(Comment comment) async {
    try {
      await NetworkService.addLikeToComment(comment.distinctId, AppData.currentUser!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Liked comment!'))
      );
      _fetchComments();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to like comment: $e'))
      );
    }
  }

  void _handleDislike(Comment comment) async {
    try {
      await NetworkService.addDislike(comment.distinctId, AppData.currentUser!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Disliked comment!'))
      );
      _fetchComments();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to dislike comment: $e'))
      );
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        title: Text(
          'Comments',
          style: TextStyle(
            color: FlutterFlowTheme.of(context).primaryText,
          ),
        ),
      ),
      body: FutureBuilder<List<Comment>>(
        future: _commentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  TextButton(
                    onPressed: _fetchComments,
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No comments available.'));
          } else {
            final comments = snapshot.data!;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      comment.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(comment.commentBody),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          (comment.like ?? 0).toString(),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        IconButton(
                          icon: const Icon(Icons.thumb_up),
                          onPressed: () => _handleLike(comment),
                        ),
                        Text(
                          (comment.dislike ?? 0).toString(),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        IconButton(
                          icon: const Icon(Icons.thumb_down),
                          onPressed: () => _handleDislike(comment),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () async {
                final commentText = _commentController.text;
                if (commentText.isNotEmpty) {
                  try {
                    await NetworkService.createComment(AppData.currentUser!, commentText, widget.postId);
                    _commentController.clear();
                    _fetchComments(); // Refresh comments after posting
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add comment: $e'))
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
