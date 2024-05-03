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
  List<Comment>? _comments;
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;
  bool _isLoadingLikeDislike = false;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  void _fetchComments() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final comments = await NetworkService.getComments(widget.postId);
      setState(() {
        _comments = comments;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error appropriately
    }
  }

  Future<void> _handleLikeDislike(String commentId, bool isLike) async {
    if (_isLoadingLikeDislike) return;
    setState(() {
      _isLoadingLikeDislike = true;
    });

    if (isLike) {
      await NetworkService.addLikeToComment(commentId, AppData.currentUser!);
    } else {
      await NetworkService.addDislike(commentId, AppData.currentUser!);
    }

    setState(() {
      _isLoadingLikeDislike = false;
    });
    _fetchComments(); // Refresh comments to show updated likes/dislikes
  }

  void _postComment() async {
    final commentText = _commentController.text;
    if (commentText.isNotEmpty) {
      await NetworkService.createComment(AppData.currentUser!, commentText, widget.postId);
      _commentController.clear();
      _fetchComments(); // Refresh comments after posting
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
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _comments == null || _comments!.isEmpty
                    ? const Center(child: Text('No comments available.'))
                    : ListView.builder(
                        itemCount: _comments!.length,
                        itemBuilder: (context, index) {
                          final comment = _comments![index];
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
                                child: Text(
                                  comment.commentBody,
                                  style: const TextStyle(
                                    color: Colors.black87, // Darker color
                                    fontSize: 16, // One size bigger than default (14)
                                  ),
                                ),
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
                                    onPressed: () => _handleLikeDislike(comment.distinctId, true),
                                  ),
                                  Text(
                                    (comment.dislike ?? 0).toString(),
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.thumb_down),
                                    onPressed: () => _handleLikeDislike(comment.distinctId, false),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
          Padding(
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
                  onPressed: _postComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
