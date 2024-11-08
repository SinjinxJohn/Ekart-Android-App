import 'package:ekart/data/models/product_model.dart';
import 'package:ekart/logic/bloc/cart/cart_bloc.dart';
import 'package:ekart/logic/bloc/cart/cart_event.dart';
import 'package:ekart/logic/bloc/cart/cart_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// final String id;
// final String productName;
// final int productPrice;
//final ProductDetails productDetails;
class ProductScreen extends StatefulWidget {
  final String productName;
  final int productPrice;
  final List<String> reviews;
  final ProductDetails productDetails;
  final String productId;
  final String productImage;
  const ProductScreen(
      {super.key,
      required this.productName,
      required this.productDetails,
      required this.productId,
      required this.productPrice,
      required this.productImage,
      required this.reviews});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int count = 1;
  static const IconData keyboard_arrow_left_rounded =
      IconData(0xf05bc, fontFamily: 'MaterialIcons');
  void _addToCart(BuildContext context, int quantity) async {
    try {
      BlocProvider.of<CartBloc>(context).add(
        AddToCart(productId: widget.productId, quantity: quantity),
      );
      // Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 44.0, left: 8),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  keyboard_arrow_left_rounded,
                  size: 30,
                )),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 15, top: 10),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 45),
            child: Text(
              "${widget.reviews.length.toString()} reviews",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10),
            child: Text(
              widget.productName,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 16),
            child: Text(
              "Brand:${widget.productDetails.brand}",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 16),
            child: Text(
              "Color:${widget.productDetails.colour}",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 16),
            child: Text(
              "Material:${widget.productDetails.material}",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
                child: Text(
              "Rs ${widget.productPrice}.00",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            )),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      count++;
                    });
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: Text(
                      "+",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )),
                  ),
                ),
              ),
              Container(
                  child: Text(
                count.toString(),
                style: TextStyle(fontSize: 30),
              )),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: GestureDetector(
                  onTap: () {
                    if (count > 0) {
                      setState(() {
                        count--;
                      });
                    }
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: .0),
                      child: Text(
                        "-",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),

          BlocListener<CartBloc, CartState>(listener: (context, state) {
            if (state is CartLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product added to cart successfully!'),
                    duration: Duration(seconds: 3),
                  ),
                );
              });
            } else if (state is CartError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.message}'),
                    duration: Duration(seconds: 3),
                  ),
                );
              });
            }
          }, child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartLoading) {
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
            if (state is CartLoaded) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text('Product added to cart successfully!'),
              //     duration: Duration(seconds: 3),
              //   ),
              // );
            }
            return Center(
              child: GestureDetector(
                onTap: () => _addToCart(context, count),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    child: const Center(
                        child: Text(
                      "Add to cart",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ),
            );
          })),

          // Text()
        ],
      ),
    );
  }
}
