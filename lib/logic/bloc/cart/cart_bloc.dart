

import 'package:dio/dio.dart';
import 'package:ekart/data/providers/cart_response.dart';
import 'package:ekart/data/repositories/cart_repository.dart';
import 'package:ekart/logic/bloc/cart/cart_event.dart';
import 'package:ekart/logic/bloc/cart/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  final CartRepository cartRepository;


  CartBloc({required this.cartRepository}):super(CartInitial()){
    on<RemoveFromCart>((event,emit)async{
      emit(CartLoading());
      try {
        final cartResp = await cartRepository.removeFromCart(event.productId);
        if(cartResp.messageType=='success'){
          emit(CartLoaded(cartResp));
        }else{
           emit(CartError(cartResp.message.toString()));
        }
        
      } catch (e) {
        emit(CartError("Failed to remove item from cart: ${e.toString()}"));
      }

    });
    on<FetchCart>((event,emit)async{
      emit(CartLoading());
      try {
        final cartResp = await cartRepository.fetchCart();
        if(cartResp.messageType=='success'){
          emit(CartLoaded(cartResp));
        }else{
           emit(CartError(cartResp.message.toString()));
        }
        
      } catch (e) {
         emit(CartError("Cart loading failed: ${e.toString()}"));
      }
    });
    on<AddToCart>((event,emit) async{
      emit(CartLoading());

      try{
        final authResp = await cartRepository.addToCart(event.productId,event.quantity);
        if(authResp.messageType=='success'){
          emit(CartLoaded(authResp));
        }else{
           emit(CartError(authResp.message.toString()));
        }

      }catch(e){

        emit(CartError("Cart loading failed: ${e.toString()}"));
      }
    }
    );
    
  }
}
  
