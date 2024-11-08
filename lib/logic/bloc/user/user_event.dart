import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{
    @override
    List<Object> get props =>[];
}

class LoginUser extends UserEvent{
    final String email;
    final String password;

    LoginUser(this.email,this.password);

    @override
    List<Object> get props => [email,password];
}

class SignUpUser extends UserEvent{
  final String email;
  final String username;
  final String password;
  final String confirmPassword;
  final String roles;
  final String address;

  SignUpUser(this.email,this.password,this.confirmPassword,this.username,this.roles,this.address);


  @override
    List<Object> get props => [email,username,password,confirmPassword,roles,address];

}