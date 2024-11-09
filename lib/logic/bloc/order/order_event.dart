import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable{
  @override
    List<Object> get props =>[];
}


class CreateOrder extends OrderEvent{}

class UpdateOrder extends OrderEvent{
  final String status;

  UpdateOrder({required this.status});

  @override
  List<Object> get props =>[status];

}

class GetUserOrders extends OrderEvent{}