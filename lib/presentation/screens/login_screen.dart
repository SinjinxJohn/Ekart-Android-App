import 'dart:convert';

import 'package:ekart/data/models/user_model.dart';
import 'package:ekart/logic/bloc/user/user_bloc.dart';
import 'package:ekart/logic/bloc/user/user_event.dart';
import 'package:ekart/logic/bloc/user/user_state.dart';
import 'package:ekart/presentation/screens/Admin/home_screen.dart';
import 'package:ekart/presentation/screens/Seller/home_screen.dart';
import 'package:ekart/presentation/screens/Users/home_screen.dart';
import 'package:ekart/presentation/screens/Users/main_screen.dart';
import 'package:ekart/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLoginPressed(BuildContext context) async {
    // final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    // final confirmPassword = _confirmPasswordController.text.trim();
    // final address = _addressController.text.trim();
    // final roles = _rolesController.text.trim();

    if(email.isEmpty|| password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email/Password cannot be empty")));
    }else{
      print("Login pressed");
    BlocProvider.of<UserBloc>(context).add(
      LoginUser(email, password),
    );
    }

    

    // final user  = await getUserData();
  }

  Future<User?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString('user_details');

    if (userDataJson != null) {
      final userDataMap = jsonDecode(userDataJson);
      
      return User.fromJson(userDataMap); // Deserialize to User object
    } else {
      return null; // No user data found
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) async {
            if (state is UserAuthenticated) {
              final user = state.userData.user;
              
                // Navigate based on rolea
                if (user.roles.contains("user")) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                } else if (user.roles.contains("Seller")) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SellerHomePage()),
                  );
                } else if (user.roles.contains("Admin")) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AdminHomePage()),
                  );
                }
              
            } else if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:60.0,right: 14,bottom: 20),
                  child: Image.asset("assets/LogoEkart.png",height: 200,width: 200,),
                ),
            
                Padding(
                  padding: const EdgeInsets.only(top:0,left: 24,right: 20),
                  child: Text("Welcome Back!",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                ),
            
                const Padding(
                  padding: EdgeInsets.only(top:35.0,left: 30),
                  child: Text("Email",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:23,top: 8,right: 32),
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
                          hintStyle:  TextStyle(fontSize: 12,color: Colors.grey),
                          filled: true,
                          fillColor: Color.fromRGBO(241, 240, 240, 1),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(
                                195, 231, 3, 1),width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Color.fromRGBO(
                                195, 231, 3, 1),width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color.fromRGBO(
                                195, 231, 3, 15),width: 3))),
                    ),
                  ),
                ),
                 const Padding(
                  padding: EdgeInsets.only(top:21.0,left: 30,right: 30),
                  child: Text("Password",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 23,right: 32,top: 8),
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
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "PASSWORD",
                        
            
                          // labelText: "Enter your password",
                          hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                          filled: true,
                          fillColor: Color.fromRGBO(241, 240, 240, 1),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(
                              195, 231, 3, 1),),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Color.fromRGBO(
                                195, 231, 3, 1),width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Color.fromRGBO(
                                195, 231, 3, 1),width: 3))),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
            
                    return GestureDetector(
                      onTap: () => _onLoginPressed(context),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25,right: 30),
                        child: Container(
                          width: 300, // Set button width
                          height: 50, // Set button height
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(
                                195, 231, 3, 1), // Set button color
                            borderRadius:
                                BorderRadius.circular(10.0), // Circular border
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: Offset(0, 3), // Position of shadow
                              ),
                            ],
                          ),
                          alignment: Alignment.center, // Center the text
                          child: Text(
                            'Sign In', // Button text
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Text weight
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left:55,right: 55.0,top: 8),
                  child: Row(
                    children: [
                      Text("DON'T HAVE AN ACCOUNT?",style: TextStyle(fontSize: 12,color: Colors.grey),),
                      // SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/signup');
                          },
                          
                          child: Text("SIGNUP",style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
