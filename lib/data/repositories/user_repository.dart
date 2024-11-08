import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ekart/data/models/user_model.dart';
import 'package:ekart/data/providers/auth_response.dart';
import 'package:http/http.dart' as http;

class UserRepository {
 

 

  Future<LoginResponse> login(String email,String password)async{

    final Map<String,dynamic> data = {
              'email': email,
        'password': password,
        
    };
    final response = await http.post(Uri.parse("https://ekart-6mv3.onrender.com/login"),
    //  Uri.parse('https://ekart-6mv3.onrender.com/signup'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      
    },
    body:jsonEncode(data)
    );

    // print(response.body);

    if (response.statusCode == 200) {
    // Parse the response body and return AuthResponse
    return LoginResponse.fromJson(jsonDecode(response.body));
  } else {
    // Handle error by throwing an exception or returning an error response
    throw Exception('Failed to login: ${response.statusCode}');
  }

  }


//change email to get information from id and take id information from bloc
  Future<User> getUser(String email) async{
    try{
      final Map<String,dynamic> data = {
        "email":email,
      };
      final response = await http.post(Uri.parse("https://ekart-6mv3.onrender.com/user"),
      
      body: jsonEncode(data),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      
    },
    
    );


    print("The response is:"+ response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final userData = jsonResponse['message'];
      return User.fromJson(userData);
      
    } else {
      // console.log(response.data);
      throw Exception('Failed to signup: ${response.statusCode}  ${response.body}');
    }
    }catch(e){
      throw Exception('Signup error: $e');
    }
  }


Future<AuthResponse> signup(String email, String password, String confirmPassword, String username, String roles, String address) async {
  final dio = Dio();
  try {

    final Map<String,dynamic> data = {
              'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'username': username,
        'roles': roles,
        'address': address,
    };
    final response = await http.post(
      Uri.parse('https://ekart-6mv3.onrender.com/signup'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      
    },
      body:jsonEncode(data),
      );


      print(response.body);


    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return AuthResponse.fromJson(jsonResponse);
      
    } else {
      // console.log(response.data);
      throw Exception('Failed to signup: ${response.statusCode}  ${response.body}');
    }
  } catch (e) {
    throw Exception('Signup error: $e');
  }
}

}