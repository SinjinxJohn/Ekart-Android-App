import 'package:ekart/data/repositories/product_repository.dart';
import 'package:ekart/logic/bloc/product/product_event.dart';
import 'package:ekart/logic/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent,ProductState>{
  final ProductRepository productRepository;


  ProductBloc({required this.productRepository}):super(ProductInitial()){
    on<GetAllProducts>((event,emit)async{
      emit(ProductLoading());
      try {

        final products = await productRepository.getAllProducts();
        emit(ProductLoaded(product: products));
        
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });
  }
}