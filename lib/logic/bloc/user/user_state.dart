import 'package:ekart/data/models/user_model.dart';
import 'package:ekart/data/providers/auth_response.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserState extends Equatable{
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState{}

class UserLoading extends UserState{}

 
class UserAuthenticated extends UserState {
  final UserData userData; // This will hold both token and user data

  UserAuthenticated(this.userData);

  @override
  List<Object> get props => [userData]; // Override props for equality checks
}



class UserError extends UserState{
  final String message;

  UserError(this.message);

  @override
  List<Object> get props => [message];
}


// class UserAuth extends UserState{
//   final User user;
//   UserAuth(this.user);

// }
class UserSignUpLoading extends UserState{}

class UserSignUpSuccess extends UserState{}


