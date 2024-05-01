// comments_widget.dart
import 'package:flutter/material.dart';
import 'package:foodappproject/app_data.dart';
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
    _commentsFuture = NetworkService.getComments(widget.postId);
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
        title: const Text('Comments'),
      ),
      body: FutureBuilder<List<Comment>>(
        future: _commentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
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
                          (comment.like ?? 0).toString(),  // Convert likes to String, with a fallback of 0
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.thumb_up),
                          onPressed: () {
                            // Handle like action
                            onPressed: () => NetworkService.addLikeToComment(comment.distinctId, AppData.currentUser!);
                          },
                        ),
                        Text(
                          (comment.dislike ?? 0).toString(),  // Convert likes to String, with a fallback of 0
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.thumb_down),
                          onPressed: () => NetworkService.addDislike(comment.distinctId, AppData.currentUser!),
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
              onPressed: () {
                final commentText = _commentController.text;
                if (commentText.isNotEmpty) {
                   NetworkService.createComment(AppData.currentUser!, commentText,widget.postId);

                  _commentController.clear();
                  initState();
                  // Optionally refresh comments after posting
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
