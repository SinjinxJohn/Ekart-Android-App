import 'package:ekart/data/models/cart_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable{
    @override
    List<Object> get props =>[];
}



class FetchCart extends CartEvent{}
class AddToCart extends CartEvent{
    final String productId;
    final int quantity;
    AddToCart({required this.productId,required this.quantity});

    @override
    List<Object> get props=>[productId,quantity];
}

class RemoveFromCart extends CartEvent{
    final String productId;

    RemoveFromCart({required this.productId});


    @override
    List<Object> get props=> [productId];
}
