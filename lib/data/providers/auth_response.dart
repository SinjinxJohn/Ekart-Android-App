import 'package:ekart/data/models/user_model.dart';

class AuthResponse {
  final String messageType;
  final Map<String,dynamic> message;

  AuthResponse({required this.messageType, required this.message});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      messageType: json['messageType'],
      message: json['message'] as Map<String,dynamic>,
    );
  }
}

class LoginResponse{
  final String messageType;
  final String message;
  final String token;

  LoginResponse({required this.messageType, required this.message,required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      messageType: json['messageType'],
      message: json['message'],
      token:json['token']

    );
  }
}

class UserData{
  final String token;
  final User user;

    UserData({required this.token, required this.user});
}


