import 'package:ekart/logic/bloc/user/user_bloc.dart';
import 'package:ekart/logic/bloc/user/user_event.dart';
import 'package:ekart/logic/bloc/user/user_state.dart';
import 'package:ekart/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpTwo extends StatefulWidget {
  final String email;
  final String password;
  final String confirmPassword;
  const SignUpTwo({super.key,required this.email,required this.password,required this.confirmPassword});

  @override
  State<SignUpTwo> createState() => _SignUpTwoState();
}

class _SignUpTwoState extends State<SignUpTwo> {

  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController =
      // TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _rolesController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();


 void _onSignupPressed(BuildContext context, String email,String password,String confirmPassword)async {
  final username = _usernameController.text.trim();
  // final email = _emailController.text.trim();
  // final password = _passwordController.text.trim();
  // final confirmPassword = _confirmPasswordController.text.trim();
  final address = _addressController.text.trim();
  final roles = _rolesController.text.trim();

  print(email+password+confirmPassword);
  print("Signup button clicked"); 
  BlocProvider.of<UserBloc>(context).add(
    SignUpUser(email, password, confirmPassword, username, roles, address),
  );



  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserSignUpSuccess) {
              
              Navigator.pushReplacementNamed(
                 context,'/');
            } else if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Padding(
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
                    padding: const EdgeInsets.only(left: 24,right: 20),
                    child: Text("Create Your Account",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                  ),
              
                  const Padding(
                    padding: EdgeInsets.only(top:45.0,left: 30,right: 30),
                    child: Text("Username",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
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
                        controller: _usernameController,
                        decoration: InputDecoration(
                            hintText: "USERNAME",
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
                    padding: EdgeInsets.only(top:10.0,left: 30,right: 30),
                    child: Text("Role",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
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
                        controller: _rolesController,
                        decoration: InputDecoration(
                            hintText: "ROLE",
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
                    padding: EdgeInsets.only(top:10.0,left: 30,right: 30),
                    child: Text("Address",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
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
                        controller: _addressController,
                        decoration: InputDecoration(
                            hintText: "ADDRESS",
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
                  // const SizedBox(height: 20),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserSignUpLoading) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
              
                      return Padding(
                   padding: const EdgeInsets.only(left:20,right: 30,top: 30),
                   child: GestureDetector(
                    onTap: (){
                      if(widget.email.length==0 || widget.confirmPassword.length==0||widget.password.length==0||_usernameController.text.length==0
                      ||_rolesController.text.length==0||_addressController.text.length==0){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fill form before clicking on SIGN UP")));
                      }else{
                        _onSignupPressed(context,widget.email,widget.password,widget.confirmPassword);
                      }
                    },
                    
                     child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(color: Color.fromRGBO(
                                      195, 231, 3, 1),borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text("SIGN UP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),),
                   ),
                 );
                    },
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left:50,right: 48.0,top: 8),
                    child: Row(
                      children: [
                        Text("ALREADY HAVE AN ACCOUNT?",style: TextStyle(fontSize: 12,color: Colors.grey),),
                        // SizedBox(width: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushReplacementNamed(context, '/');
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpTwo(email: _emailController.text, password: _passwordController.text, confirmPassword: _confirmPasswordController.text)));
                            },
                            child: Text("LOGIN",style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}