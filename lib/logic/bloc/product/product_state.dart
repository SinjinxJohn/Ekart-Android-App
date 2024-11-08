import 'package:ekart/data/models/product_model.dart';
import 'package:ekart/data/providers/product_response.dart';
import 'package:ekart/data/repositories/product_repository.dart';

abstract class ProductState {}

class ProductInitial extends ProductState{}

class ProductLoading extends ProductState{}

class ProductLoaded extends ProductState{
  final ProductResponse product;

  ProductLoaded({required this.product});

}

class ProductError extends ProductState{
  final String message;
  ProductError({required this.message});
}

