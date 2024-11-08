class CartItem {
  final String productId;
  final String productName;
  final int quantity;
  final int price;
  final int totalPrice;
  final String address;

  CartItem({required this.productId, required this.productName,required this.price,required this.address,
  required this.quantity,required this.totalPrice});

  factory CartItem.fromJson(Map<String,dynamic> json){
    return CartItem(productId: json['productId'], productName: json['productName'], price: int.parse(json['price'].toString()), address: json['address'], quantity: int.parse(json['quantity'].toString()), totalPrice: int.parse(json['totalPrice'].toString()));


  }
}


class CartModel {
  final String userId;
  final int totalPrice;
  final int totalItems;
  final List<CartItem> items;


  CartModel({required this.userId,required this.totalItems,required this.totalPrice,required this.items});

  factory CartModel.fromJson(Map<String,dynamic> json){
    return CartModel(userId: json['userId'], totalItems: int.parse(json['totalItems'].toString()), totalPrice: int.parse(json['totalPrice'].toString()), items: (json['items'] as List<dynamic>)
          .map((itemJson) => CartItem.fromJson(itemJson))
          .toList(),);
  }
}