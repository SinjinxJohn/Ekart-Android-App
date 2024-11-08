import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ekart/data/providers/auth_response.dart';
import 'package:ekart/logic/bloc/user/user_bloc.dart';
import 'package:ekart/logic/bloc/user/user_event.dart';
import 'package:ekart/logic/bloc/user/user_state.dart';
import 'package:ekart/presentation/screens/login_screen.dart';
import 'package:ekart/presentation/screens/signup_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 55.0, right: 50.0),
                  child: ClipOval(
                    child: SizedBox(
                      width: 220, // Customize the width
                      height: 200, // Customize the height
                      child: Image.asset(
                        "assets/LogoEkart.png",
                        fit: BoxFit
                            .fill, // Ensure the image covers the circular area
                      ),
                    ),
                  ),
                ),
            
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 20),
                  child: Text(
                    "Create Your Account",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
            
                const Padding(
                  padding: EdgeInsets.only(top: 40.0, left: 30, right: 30),
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 23, top: 8, right: 32),
                  child: Container(
                    width: 300, // Set the width to match the button
                    height: 50, // Set the height to match the button
                    decoration: BoxDecoration(
                      color:
                          Color.fromRGBO(255, 255, 255, 1), // Set the RGBA color
                      borderRadius:
                          BorderRadius.circular(10.0), // Circular border
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "EMAIL",
                          hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                          filled: true,
                          fillColor: Color.fromRGBO(241, 240, 240, 1),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(195, 231, 3, 1), width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(195, 231, 3, 1),
                                  width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(195, 231, 3, 15),
                                  width: 3))),
                    ),
                  ),
                ),
            
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 30),
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 23, top: 8, right: 32),
                  child: Container(
                    width: 300, // Set the width to match the button
                    height: 50, // Set the height to match the button
                    decoration: BoxDecoration(
                      color:
                          Color.fromRGBO(255, 255, 255, 1), // Set the RGBA color
                      borderRadius:
                          BorderRadius.circular(10.0), // Circular border
                    ),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: "PASSWORD",
                          hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                          filled: true,
                          fillColor: Color.fromRGBO(241, 240, 240, 1),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(195, 231, 3, 1), width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(195, 231, 3, 1),
                                  width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(195, 231, 3, 15),
                                  width: 3))),
                    ),
                  ),
                ),
            
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 30),
                  child: Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 23, top: 8, right: 32),
                  child: Container(
                    width: 300, // Set the width to match the button
                    height: 50, // Set the height to match the button
                    decoration: BoxDecoration(
                      color:
                          Color.fromRGBO(255, 255, 255, 1), // Set the RGBA color
                      borderRadius:
                          BorderRadius.circular(10.0), // Circular border
                    ),
                    child: TextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                          hintText: "CONFIRM PASSWORD",
                          hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                          filled: true,
                          fillColor: Color.fromRGBO(241, 240, 240, 1),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(195, 231, 3, 1), width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(195, 231, 3, 1),
                                  width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(195, 231, 3, 15),
                                  width: 3))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 30, top: 30),
                  child: GestureDetector(
                    onTap: () {
                      if(_emailController.text.length==0||_passwordController.text.length==0||_confirmPasswordController.text.length==0){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fill form before clicking on Next")));
                        
                      }else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpTwo(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  confirmPassword:
                                      _confirmPasswordController.text)));
                      }
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(195, 231, 3, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        "Next",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                    ),
                  ),
                ),
            
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 48.0, top: 8),
                  child: Row(
                    children: [
                      Text(
                        "ALREADY HAVE AN ACCOUNT?",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      // SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/');
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpTwo(email: _emailController.text, password: _passwordController.text, confirmPassword: _confirmPasswordController.text)));
                            },
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                )
                // const SizedBox(height: 20),
                // BlocBuilder<UserBloc, UserState>(
                //   builder: (context, state) {
                //     if (state is UserSignUpLoading) {
                //       return CircularProgressIndicator();
                //     }
            
                //     return ElevatedButton(
                //       onPressed: ()=>_onSignupPressed(context),
                //       child: const Text("Signup"),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
