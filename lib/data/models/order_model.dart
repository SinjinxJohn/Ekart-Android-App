
import 'package:ekart/data/models/cart_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final int totalPrice;
  final List<CartItem> items;
  final String status;
  final String to;
  


  OrderModel({required this.id,required this.userId,required this.totalPrice,required this.items,required this.status,
  required this.to});


  factory OrderModel.fromJson(Map<String, dynamic> json){
    return OrderModel(
      id: json['_id'],
      userId: json['userId'], totalPrice:json['totalPrice'], items: (json['items'] as List<dynamic>)
          .map((itemJson) => CartItem.fromJson(itemJson))
          .toList(), status: json['status'], to: json['to']);
  }
}