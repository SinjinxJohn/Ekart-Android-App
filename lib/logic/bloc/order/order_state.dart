import 'package:ekart/data/providers/order_response.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable{
  @override
  List<Object> get props => [];
}

class OrderIntial extends OrderState{}

class OrderLoading extends OrderState{}

class OrderLoaded extends OrderState{
  final OrderResponse order;
  OrderLoaded(this.order);

  @override
  List<Object> get props => [order];
 }

class OrderError extends OrderState{
  final String message;

  OrderError(this.message);

  @override
  List<Object> get props => [message];
}