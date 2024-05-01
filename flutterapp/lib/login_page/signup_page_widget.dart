import 'package:flutter/material.dart';
import 'package:foodappproject/apiService/apiService.dart'; // Ensure this is the correct path to your NetworkService class
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/nav/nav.dart';

class SignupPageWidget extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
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

    
  void signup(BuildContext context) async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      String response = await NetworkService.signUp(username, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
      // Optionally navigate to another screen if signup is successful
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $e')),
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.food_bank, size: 100),
                SizedBox(height: 50),
                Text('OnlyFoods', style: FlutterFlowTheme.of(context).headlineLarge),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                GestureDetector(
                child: InkWell(
                  onTap: () {signup(context);
                   },
                  child: Container(
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(color: Colors.black),
                    child: Center(
                        child: Text("Sign up",
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ))),
                  ),
                ),
              ),
                SizedBox(height: 50),
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
                      'Log in',
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
      ),
    );
  }
}
