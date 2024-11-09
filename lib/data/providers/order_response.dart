import 'package:ekart/data/models/cart_model.dart';
import 'package:ekart/data/models/order_model.dart';

class OrderResponse {
  final String messageType;
  final String message; // Error or success message
  final OrderModel? data; // List of CartModel items

  OrderResponse({
    required this.messageType,
    required this.message,
    required this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    // Check if 'message' is a List and handle accordingly
    var messageField = json['message'];
    
    // Assuming 'message' could either be a string or a list
    if (messageField is String) {
      return OrderResponse(
        messageType: json['messageType'],
        message: messageField,
        data: null, // Empty list if it's an error message
      );
    } else if (messageField is Map<String,dynamic>) {
      return OrderResponse(
        messageType: json['messageType'],
        message: '', // Empty string if it's a success response
        data: OrderModel.fromJson(messageField),
      );
    } else {
      return OrderResponse(
        messageType: json['messageType'],
        message: 'Unknown error occurred',
        data: null,
      );
    }
  }
}
