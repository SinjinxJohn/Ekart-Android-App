import 'package:ekart/logic/bloc/order/order_bloc.dart';
import 'package:ekart/logic/bloc/order/order_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
            padding: const EdgeInsets.only(top:12.0,left: 14),
            child: Text("Your Orders",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
          ),
          SizedBox(height: 20,),
          
          BlocBuilder<OrderBloc,OrderState>(builder: (context,state){
              if(state is OrderLoading){
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
              }else if (state is OrderLoaded){
                final items = state.order.data!.items;
                final status = state.order.data!.status;
                final to = state.order.data!.to;
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
                                    Padding(
                                      padding: const EdgeInsets.only(top:4.0),
                                      child: Text("From:${item.address}",style: TextStyle(fontStyle: FontStyle.italic),),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top:4.0),
                                          child: Text("Total Price:${item.price}",style: TextStyle(fontStyle: FontStyle.italic)),
                                        ),
                                      
                                    
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
                      child: Text("Order Status: ${status}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Text("Delivery Address: ${to}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    )
                  ],
                );
              }else if (state is OrderError){
              return Text('Error:${state.message}');
            }
            return  Text("No Order");
              
            }),
            Padding(
              padding: const EdgeInsets.only(top:35.0),
              child: Center(
                child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(color: Colors.deepPurple,borderRadius: BorderRadius.circular(12)),
                        child: Center(child: Text("Proceed to pay",style: TextStyle(fontSize: 20,color: Colors.white),)),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}