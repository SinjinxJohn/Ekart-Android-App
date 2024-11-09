import 'package:ekart/logic/bloc/cart/cart_bloc.dart';
import 'package:ekart/logic/bloc/cart/cart_event.dart';
import 'package:ekart/logic/bloc/cart/cart_state.dart';
import 'package:ekart/logic/bloc/order/order_bloc.dart';
import 'package:ekart/logic/bloc/order/order_event.dart';
import 'package:ekart/logic/bloc/order/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
   final PageController pageController;
  const CartScreen({super.key,required this.pageController});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
 
  static const IconData keyboard_arrow_left_rounded =
      IconData(0xf05bc, fontFamily: 'MaterialIcons');
  static const IconData delete = IconData(0xe1b9, fontFamily: 'MaterialIcons');


  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CartBloc>(context).add(FetchCart());
  }

  void _createOrder(BuildContext context){
    BlocProvider.of<OrderBloc>(context).add(CreateOrder());
  }

  void _removeFromCart(BuildContext context,String productId){

      BlocProvider.of<CartBloc>(context).add(
      RemoveFromCart(productId: productId),
    );
   
    }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8),
              child: GestureDetector(
                  onTap: () {
                    widget.pageController.jumpToPage(0);
                  },
                  child: Icon(
                    keyboard_arrow_left_rounded,
                    size: 30,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left:14.0,top: 12),
              child: Text("Your Cart",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600)),
            ),
            BlocBuilder<CartBloc,CartState>(builder: (context,state){
              if(state is CartLoading){
                return Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Container(
                     height:450 ,
                      width: 500,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }else if (state is CartLoaded){
                final items = state.cart.data!.items;
                final totalPrice = state.cart.data!.totalPrice;
                final totalItems = state.cart.data!.totalItems;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height:450 ,
                      width: 500,
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context,index){
                          final item = items[index];
                          
                          return Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 13),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14,right: 14),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(item.productName,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(right:8.0),
                                          child: Text("Rs ${item.totalPrice}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    
                                    Padding(
                                      padding: const EdgeInsets.only(top:4.0),
                                      child: Text("Quantity:${item.quantity}",style: TextStyle(fontStyle: FontStyle.italic),),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top:4.0),
                                          child: Text("Total Price:${item.price}",style: TextStyle(fontStyle: FontStyle.italic)),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap:()=> _removeFromCart(context,item.productId),
                                          child: Icon(delete,color: Colors.red,))
                                      ],
                                    )
      
                                  ],
                                ),
                              ),
                            ),
                          );
                      
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Text("Total: Rs ${totalPrice}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Text("Total Items: ${totalItems}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                    )
                  ],
                );
              }else if (state is CartError){
              return Text('Error:${state.message}');
            }
            return  Text("No product");
              
            }),
             BlocListener<OrderBloc, OrderState>(listener: (context, state) {
              if (state is OrderLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order created successfully'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                });
              } else if (state is OrderError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${state.message}'),
                      duration: Duration(seconds: 10),
                    ),
                  );
                });
              }
            }, child: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
              if (state is OrderLoading) {
                return Center(
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                );
              }
              if (state is OrderLoaded) {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text('Product added to cart successfully!'),
                //     duration: Duration(seconds: 3),
                //   ),
                // );
              }
              return Center(
              child: Padding(
                padding: const EdgeInsets.only(top:16.0),
                child: GestureDetector(
                  onTap: ()=> _createOrder(context),
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.deepPurple,borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Text("Checkout",style: TextStyle(fontSize: 20,color: Colors.white),)),
                  ),
                ),
              ),
            );
            })),
      
            
          ],
        ),
      ),
    );
  }
}