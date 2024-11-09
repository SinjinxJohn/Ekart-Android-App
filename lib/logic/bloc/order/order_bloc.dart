import 'package:ekart/data/repositories/order_repository.dart';
import 'package:ekart/logic/bloc/cart/cart_state.dart';
import 'package:ekart/logic/bloc/order/order_event.dart';
import 'package:ekart/logic/bloc/order/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent,OrderState>{
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}):super(OrderIntial()){
    on<CreateOrder>((event,emit)async{
      emit(OrderLoading());

      try {

        final response = await orderRepository.createOrder();
        if(response.messageType=='success'){
          emit(OrderLoaded(response));
        }else{
           emit(OrderError(response.message.toString()));
        }
        
      } catch (e) {
        emit(OrderError("Failed to create Order: ${e.toString()}"));
      }
    });

    on<GetUserOrders>((event,emit)async{
      emit(OrderLoading());

      try {

        final response = await orderRepository.getUserOrders();
        if(response.messageType=='success'){
          emit(OrderLoaded(response));
        }else{
           emit(OrderError(response.message.toString()));
        }
        
      } catch (e) {
        emit(OrderError("Failed to get user orders: ${e.toString()}"));
      }
    });
  }

}