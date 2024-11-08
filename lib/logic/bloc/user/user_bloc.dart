import 'dart:convert';

import 'package:ekart/data/models/user_model.dart';
import 'package:ekart/data/providers/auth_response.dart';
import 'package:ekart/data/repositories/user_repository.dart';
import 'package:ekart/logic/bloc/user/user_event.dart';
import 'package:ekart/logic/bloc/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent,UserState>{
  final UserRepository userRepository;
  UserBloc({required this.userRepository}):super(UserInitial()){
    on<LoginUser>((event,emit) async{
      emit(UserLoading());

      try{
        final authResp = await userRepository.login(event.email,event.password);
        

        await _saveToken(authResp.token.toString());
        final resp = await userRepository.getUser(event.email);

        UserData combined = UserData(token: authResp.token, user: resp);
        await _saveUserDetails(resp);

        emit(UserAuthenticated(combined));
       


        
        
        


      }catch(e){

        emit(UserError("Login failed: ${e.toString()}"));
      }
    });


    on<SignUpUser>((event,emit) async {
      emit(UserSignUpLoading());


      try {
       await userRepository.signup(event.email, event.password, event.confirmPassword, event.username, event.roles, event.address);
       emit(UserSignUpSuccess()); 
      } catch (e) {
  print(e.toString());
        emit(UserError("Signup failed : ${e.toString()}"));
      }
    });
  }

   Future<void> _saveToken(String token) async {
    print(token);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token); // Save the token
    // await prefs.setString("auth_role", role);
  }

  Future<void> _saveUserDetails(User resp)async{
    print(resp);
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(resp.toJson());
    await prefs.setString("user_details", userJson);
  }

}