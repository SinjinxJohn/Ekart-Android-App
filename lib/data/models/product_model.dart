import 'dart:ffi';

class ProductDetails{
  final String brand;
  final String colour;
  final String material;


  ProductDetails({required this.brand,required this.colour,required this.material});

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      brand: json['brand'],
      colour: json['colour'],
      material: json['material'],
    );
  }
}


class ProductModel {
  final String id;
  final String productName;
  final int productPrice;
  final String productImage;
  final String address;
  final int stock;
  final List<String> tags;
  final List<String> reviews;
  final ProductDetails productDetails;


  ProductModel({required this.id,required this.productDetails,required this.productName,required this.productPrice,required
  this.productImage,required this.address,required this.stock,required this.reviews,required this.tags});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      productName: json['productName'],
      productPrice: int.parse(json['productPrice'].toString()),
      productImage: json['productImage'],
      address: json['address'],
      stock: int.parse(json['stock'].toString()),
      tags: List<String>.from(json['tags']),
      reviews: List<String>.from(json['reviews']),
      productDetails: ProductDetails.fromJson(json['productDetails']),
    );
  }


}