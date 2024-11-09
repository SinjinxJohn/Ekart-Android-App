import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ekart/data/providers/auth_response.dart';
import 'package:ekart/data/providers/product_response.dart';
import 'package:ekart/utils/token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ProductRepository {

  


  Future<ProductResponse> getAllProducts () async{
    String token = await Token.loadToken();
    final response = await http.get(Uri.parse("https://ekart-6mv3.onrender.com/product/getAllProducts"),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'Bearer $token'
      
    },);
    // print(response.body);

    if(response.statusCode==200){
      return ProductResponse.fromJson(jsonDecode(response.body));
    }else {
    // Handle error by throwing an exception or returning an error response
    throw Exception('Failed to get products: ${response.statusCode}');
  }

  }
}