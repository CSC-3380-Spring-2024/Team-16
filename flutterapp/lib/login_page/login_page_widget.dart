import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
<<<<<<< Updated upstream
import '../apiService/apiService.dart'; // Import your NetworkService class here
=======
import 'package:foodappproject/flutter_flow/nav/nav.dart';

>>>>>>> Stashed changes
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Function()? onTap;

  LoginPageWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.onTap,
  });

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //USER SIGN IN METHOD HERE
  void signin(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    try {
      String message = await NetworkService.login(username, password);
      // Handle successful login, you can navigate to another page or show a success message
      print(message); // For demonstration, printing the message
    } catch (e) {
      // Handle errors, such as network errors or invalid credentials
      print(e.toString()); // For demonstration, printing the error message
    }
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
<<<<<<< Updated upstream
                'Welcome to OnlyFoods',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontSize: 40,
                ),
=======
                'OnlyFoods',style:FlutterFlowTheme.of(context).headlineLarge.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
>>>>>>> Stashed changes
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

              const SizedBox(height: 10),

              //FORGOT PASSWORD
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              //SIGN IN BUTTON
              GestureDetector(
<<<<<<< Updated upstream
                onTap: () => signin(context), // Pass context to signin method
                child: Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(color: Colors.black),
                  child: Center(
                      child: Text("Sign In",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ))),
=======
                onTap: signin,
                child: InkWell(
                  onTap: () {
                   context.pushNamed('HomePage');
                   },
                  child: Container(
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(color: Colors.black),
                    child: Center(
                        child: Text("Sign In",
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ))),
                  ),
>>>>>>> Stashed changes
                ),
              ),

              const SizedBox(height: 50),

              //CREATE AN ACC
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not part of our OnlyFoods Family?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                  onTap: () {
                   context.pushNamed('Signup');
                   },
                    child: const Text(
                      'Sign up',
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