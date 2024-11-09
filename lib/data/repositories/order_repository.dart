import 'dart:convert';

import 'package:ekart/data/providers/order_response.dart';
import 'package:ekart/utils/token.dart';
import 'package:http/http.dart' as http;
class OrderRepository {
  Future<OrderResponse> createOrder()async{
     String token = await Token.loadToken();
    final response = await http.post(Uri.parse("https://ekart-6mv3.onrender.com/order/createOrder"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'Bearer $token'
      
    },

    );

    print(response.body);

    if(response.statusCode==201){
      return OrderResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to create order: ${response.statusCode}');

    }
  }

  Future<OrderResponse> getUserOrders()async{
     String token = await Token.loadToken();
    final response = await http.post(Uri.parse("https://ekart-6mv3.onrender.com/order/getUserOrders"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'Bearer $token'
      
    },

    );

    print(response.body);

    if(response.statusCode==201){
      return OrderResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to fetch user order: ${response.statusCode}');

    }
  }
}