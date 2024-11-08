import 'package:ekart/data/models/cart_model.dart';

class CartResponse {
  final String messageType;
  final String message; // Error or success message
  final CartModel? data; // List of CartModel items

  CartResponse({
    required this.messageType,
    required this.message,
    required this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    // Check if 'message' is a List and handle accordingly
    var messageField = json['message'];
    
    // Assuming 'message' could either be a string or a list
    if (messageField is String) {
      return CartResponse(
        messageType: json['messageType'],
        message: messageField,
        data: null, // Empty list if it's an error message
      );
    } else if (messageField is Map<String,dynamic>) {
      return CartResponse(
        messageType: json['messageType'],
        message: '', // Empty string if it's a success response
        data: CartModel.fromJson(messageField),
      );
    } else {
      return CartResponse(
        messageType: json['messageType'],
        message: 'Unknown error occurred',
        data: null,
      );
    }
  }
}
