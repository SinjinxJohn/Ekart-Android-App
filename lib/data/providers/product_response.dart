import 'package:ekart/data/models/product_model.dart';

class ProductResponse {
  final String messageType;
  final List<ProductModel> message;

  ProductResponse({required this.messageType, required this.message});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      messageType: json['messageType'],
      message: (json['message'] as List).map((productJson)=>ProductModel.fromJson(productJson)).toList(),
    );
  }
}