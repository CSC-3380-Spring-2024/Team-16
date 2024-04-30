import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:foodappproject/flutter_flow/nav/nav.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'signup_page_model.dart';
export 'signup_page_model.dart';

class SignupPageWidget extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Function()? onTap;

  SignupPageWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.onTap,
  });

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signup() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Icon(
                Icons.food_bank,
                size: 100,
              ),
              const SizedBox(height: 50),
              Text(
                'OnlyFoods',style:FlutterFlowTheme.of(context).headlineLarge.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
              ),
              const SizedBox(height: 25),
              //USERNAME PLACE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: usernameController,
                  obscureText: false,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).accent1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      filled: true,
                      hintText: 'Username',
                      hintStyle: TextStyle(color: FlutterFlowTheme.of(context).primaryText)),
                ),
              ),

              const SizedBox(height: 10),
              //PASSWORD PLACE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).accent1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: FlutterFlowTheme.of(context).primaryText)),
                ),
              ),
              //confirm password
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).accent1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      filled: true,
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: FlutterFlowTheme.of(context).primaryText)),
                ),
              ),

              const SizedBox(height: 10),

              //SIGN IN BUTTON
              GestureDetector(
                onTap: signup,
                child: Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(color: Colors.black),
                  child: Center(
                      child: Text("Sign Up",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ))),
                ),
              ),

              const SizedBox(height: 50),
              //sign back in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already part of our OF family?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                  onTap: () {
                   context.pushNamed('LoginPage');
                   },
                    child: const Text(
                      'Sign in now',
                       style: TextStyle(
                       color: Colors.blue, 
                       fontWeight: FontWeight.bold,
                         ),
                       ),
                      ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
