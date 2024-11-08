import 'package:ekart/data/models/cart_model.dart';
import 'package:ekart/data/providers/cart_response.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable{
  @override
  List<Object> get props => [];
}

 class CartInitial extends CartState{}


 class CartLoading extends CartState{}

 class CartLoaded extends CartState{
  final CartResponse cart;
  CartLoaded(this.cart);

  @override
  List<Object> get props => [cart];
 }


 class CartError extends CartState{
  final String message;


  CartError(this.message);

  @override
  List<Object> get props => [message];
}

