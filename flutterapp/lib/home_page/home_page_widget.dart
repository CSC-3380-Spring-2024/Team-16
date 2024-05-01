import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:foodappproject/apiService/apiService.dart';
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
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Colors.black, width: 2.0),
                      top: BorderSide(color:  Colors.black, width: 2.0),
                      bottom: BorderSide(color: Colors.black, width: 2.0),
                      right: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     GroceryButton(),
                  ],
                  ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    PostWidget(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

@override
 Container PostWidget(BuildContext context) {
   return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: InkWell(
                        onTap: ()async {
                          context.pushNamed('Comments');
                        },
                        child: FullPost(isPreview: true,),
                      ),
                    ),
                  );
 }
}

class FullPost extends StatelessWidget {
  late final bool isPreview;

  FullPost({
    required this.isPreview,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: NetworkService.getAllPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<Post> posts = snapshot.data ?? [];
          if (posts.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: posts.map((post) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Posted by ${post.username}',
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                        ),
                        SizedBox(height: 25,),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 12.0, 0.0),
                      child: Text(
                        post.caption,
                        maxLines: isPreview ? 4 : 99999,
                        overflow: TextOverflow.ellipsis,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context)
                              .primaryText,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    if (post.uploadImage != null)
                      Image.memory(
                        post.uploadImage!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(height: 10,),
                    Container(
                      width: double.maxFinite,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 250,
                            height: 85,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    post.referenceId,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
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
                            FlutterFlowIconButton(
                              buttonSize: 40.0,
                              icon: Icon(
                                Icons.mode_comment_outlined,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryText,
                                size: 24.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                            FlutterFlowIconButton(
                              buttonSize: 40.0,
                              icon: Icon(
                                Icons.ios_share,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryText,
                                size: 24.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          } else {
            return Text('No posts available.');
          }
        }
      },
    );
  }
}


class GroceryButton extends StatelessWidget {
  const GroceryButton({
    super.key,
  });

@override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey.shade800, 
        width: 4.0,
      ),
    ),
    child: Column(
      children: [
        InkWell(
          onTap: () async {
              context.pushNamed('Grocery');
            },
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
          style:FlutterFlowTheme.of(context).bodyLarge.override(
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
