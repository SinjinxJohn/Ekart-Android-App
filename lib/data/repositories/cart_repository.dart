import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ekart/data/providers/cart_response.dart';
import 'package:ekart/utils/token.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  Future<CartResponse> fetchCart()async{
    final token = await Token.loadToken();
    final response = await http.get(Uri.parse("https://ekart-6mv3.onrender.com/cart/fetchCart"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'Bearer $token'
      
    },);

    print(response.body);
    if(response.statusCode==200){
      return CartResponse.fromJson(jsonDecode(response.body));
    }else {
    // Handle error by throwing an exception or returning an error response
    throw Exception('Failed to fetch cart details: ${response.statusCode}');
  }
  }

  Future<CartResponse> removeFromCart(String productId)async{
    final token = await Token.loadToken();
    final Map<String,dynamic> data = {
      "productId":productId
    };
    final response = await http.delete(Uri.parse("https://ekart-6mv3.onrender.com/cart/removeFromCart"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'Bearer $token'
      
    },
    body:jsonEncode(data));
    print(response.body);

    if(response.statusCode==200){
      return CartResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to get cart info: ${response.statusCode}');
    }
  }
  Future<CartResponse> addToCart(String productId,int quantity)async{
    final token = await Token.loadToken();
    final Map<String,dynamic> data = {
      "productId":productId,
      "quantity":quantity
    };

    final response = await http.post(Uri.parse("https://ekart-6mv3.onrender.com/cart/addToCart"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'Bearer $token'
      
    },
    body:jsonEncode(data)
    );

     print(response.body);

     if(response.statusCode==200){
      return CartResponse.fromJson(jsonDecode(response.body));
    }else {
    // Handle error by throwing an exception or returning an error response
    throw Exception('Failed to get cart info: ${response.statusCode}');
  }


  }
}