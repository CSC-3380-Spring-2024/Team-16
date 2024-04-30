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
                      ContainerButton(),
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
  late bool isPreview;
  FullPost({
    required this.isPreview,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Posted by cocksucker69',
              style: FlutterFlowTheme.of(context)
                  .labelSmall
                  .override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0.0,
                  ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              0.0, 0.0, 12.0, 0.0),
          child: Text(
            "Whenever I think of apple pie, my mind instantly travels back to my childhood kitchen, where the warm, inviting aroma of baking apples and cinnamon seemed to permeate every corner. My mom used to make it every Thanksgiving, meticulously peeling each apple and letting me help arrange the slices in the crust. It was our little tradition, a moment of bonding over the simple pleasure of baking together. As the pie baked, the entire house would gradually fill with its scent, building anticipation for that first delicious slice. There was something magical about watching the crust turn that perfect shade of golden brown in the oven, knowing that soon we’d all be enjoying a piece. Eating apple pie is like a journey through flavors and memories. The tangy sweetness of the apples, mixed with the rich, buttery crust and a hint of spice from the cinnamon, creates a taste that’s both comforting and exhilarating. It’s not just a dessert; it’s a reminder of family, of home, and of the simple joys that make life sweet. Now, whenever I have apple pie, I always try to recreate that original recipe from my childhood. Sometimes I serve it at family gatherings or to friends who've never had homemade pie before. Each time, it's like sharing a piece of my history, a delicious slice of the past that continues to bring joy and warmth into the present.",
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
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://images.unsplash.com/photo-1562007908-17c67e878c88?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyfHxhcHBsZSUyMHBpZXxlbnwwfHx8fDE3MTE2NDY5MDR8MA&ixlib=rb-4.0.3&q=80&w=1080',
            width: double.infinity,
            height: 200.0,
            fit: BoxFit.cover,
          ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                      'https://images.unsplash.com/photo-1562007908-17c67e878c88?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyfHxhcHBsZSUyMHBpZXxlbnwwfHx8fDE3MTE2NDY5MDR8MA&ixlib=rb-4.0.3&q=80&w=1080',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "Grandma's smashed apple pie",
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
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.arrow_upward_rounded,
                      color: FlutterFlowTheme.of(context)
                          .secondaryText,
                      size: 24.0,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 8.0, 0.0, 8.0),
                      child: Text(
                        '1.2k',
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_downward_rounded,
                      color: FlutterFlowTheme.of(context)
                          .secondaryText,
                      size: 24.0,
                    ),
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
  }
}

class ContainerButton extends StatelessWidget {
  const ContainerButton({
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
              context.pushNamed('Fridge');
            },
          child: FlutterFlowIconButton(
            icon: Icon(
              Icons.all_inbox,
              color: Colors.white,
              size: 60.0,
            ),
          ),
        ),
        Text(
          'Fridge',
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
