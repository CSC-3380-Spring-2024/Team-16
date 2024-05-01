import 'package:foodappproject/apiService/apiService.dart';
import 'package:http/http.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
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
                    children: [
                      GroceryButton(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FullPost(isPreview: true),
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

  const FullPost({required this.isPreview, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: NetworkService.getAllPosts(),
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

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostWidget(post: posts[index], isPreview: isPreview);
            },
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
          // Display main post
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

          // Fetch and display subpost (recipe)
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Reference from:"),
                    Text("Recipe Name: ${recipe.name}"),
                    const SizedBox(height: 10),
                    if (recipe.uploadImage != null)
                      Image.memory(
                        recipe.uploadImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                  ],
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
                  Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text("Like", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  const SizedBox(width: 16),
                  Icon(Icons.thumb_down_alt_outlined, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text("Dislike", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
              FlutterFlowIconButton(
                buttonSize: 40.0,
                icon: Icon(
                  Icons.mode_comment_outlined,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                onPressed: () {
                  // Handle comment button press
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
    );
  }
}

class GroceryButton extends StatelessWidget {
  const GroceryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade800, width: 4.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () => context.pushNamed('Grocery'),
            child: FlutterFlowIconButton(
              icon: Icon(
                Icons.local_grocery_store,
                color: Colors.white,
                size: 60.0,
              ),
            ),
          ),
          Text(
            'Grocery',
            style: FlutterFlowTheme.of(context).bodyLarge.override(
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
