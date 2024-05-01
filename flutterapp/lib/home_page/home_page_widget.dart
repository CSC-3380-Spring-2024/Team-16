import 'package:flutter/material.dart';
import 'package:foodappproject/apiService/apiService.dart';
import 'package:foodappproject/app_data.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_util.dart';

import '../comments/comments_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'home_page_model.dart';

export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  void _refreshPage() {
    setState(() {});
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                                          const ContainerButton(),

                      GroceryButton(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FullPost(isPreview: true, onRefresh: _refreshPage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullPost extends StatelessWidget {
  final bool isPreview;
  final VoidCallback onRefresh;

  const FullPost({required this.isPreview, required this.onRefresh, Key? key}) : super(key: key);

  Future<List<Post>> _fetchPosts() async {
    return await NetworkService.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: _fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Post> posts = snapshot.data ?? [];
          if (posts.isEmpty) {
            return const Center(child: Text('No posts available.'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              onRefresh();
            },
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostWidget(post: posts[index], isPreview: isPreview);
              },
            ),
          );
        }
      },
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;
  final bool isPreview;

  const PostWidget({required this.post, required this.isPreview, Key? key}) : super(key: key);

  Future<Recipe> _getRecipeById() async {
    return await NetworkService.fetchRecipeById(post.referenceId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Posted by ${post.username}',
                style: FlutterFlowTheme.of(context).labelSmall.override(
                  fontFamily: 'Readex Pro',
                  letterSpacing: 0.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            post.caption,
            maxLines: isPreview ? 4 : null,
            overflow: TextOverflow.ellipsis,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Readex Pro',
              color: FlutterFlowTheme.of(context).primaryText,
              letterSpacing: 0.0,
            ),
          ),
          const SizedBox(height: 10),
          if (post.uploadImage != null)
            Image.memory(
              post.uploadImage!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 10),
          FutureBuilder<Recipe>(
            future: _getRecipeById(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No recipe found.'));
              } else {
                final recipe = snapshot.data!;
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (recipe.uploadImage != null)
                        Image.memory(
                          recipe.uploadImage!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reference Recipe",
                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'Readex Pro',
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "Recipe Name: ${recipe.name}",
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FlutterFlowIconButton(
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.thumb_up_alt_outlined,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    onPressed: () => NetworkService.likePost(post.distinctId, AppData.currentUser!),
                  ),
                  Text(
                    (post.likes ?? 0).toString(),
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 14.0,
                    ),
                  ),
                  FlutterFlowIconButton(
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.thumb_down_alt_outlined,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    onPressed: () => NetworkService.dislikePost(post.distinctId, AppData.currentUser!),
                  ),
                  Text(
                    (post.dislikes ?? 0).toString(),
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 14.0,
                    ),
                  ),
                  FlutterFlowIconButton(
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.mode_comment_outlined,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsWidget(postId: post.distinctId),
                        ),
                      );
                    },
                  ),
                  FlutterFlowIconButton(
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.ios_share,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    onPressed: () {
                      // Handle share button press
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme ffTheme = FlutterFlowTheme.of(context);
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: ffTheme.accent1,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: ffTheme.accent1, width: 4.0),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            onTap: () => context.pushNamed('Fridge'),
            child: FlutterFlowIconButton(
              icon: Icon(
                Icons.all_inbox,
                color: ffTheme.primaryText,
                size: 40.0,
              ),
            ),
          ),
          Text(
            'Fridge',
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                ),
          ),
        ],
      ),
    );
  }
}


class GroceryButton extends StatelessWidget {
  const GroceryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height:80,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).accent2,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: FlutterFlowTheme.of(context).accent2, width: 4.0),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            onTap: () => context.pushNamed('Grocery'),
            child: Icon(
              Icons.local_grocery_store,
              color: Colors.white,
              size: 50.0,
            ),
          ),
          Text(
            'Grocery',
            style: FlutterFlowTheme.of(context).bodySmall.override(
              fontFamily: 'Readex Pro',
              color: FlutterFlowTheme.of(context).primaryText,
              letterSpacing: 0.0,
            ),
          ),
        ],
      ),
    );
  }
}
