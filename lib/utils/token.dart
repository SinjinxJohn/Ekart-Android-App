import 'package:shared_preferences/shared_preferences.dart';

class Token {
   static Future<String> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    // setState(() {
      String token = prefs.getString('auth_token') as String; // Retrieve and set the token

      if(token.isEmpty){
        return "";
      }else{
        return token;
      }
  
  }
}