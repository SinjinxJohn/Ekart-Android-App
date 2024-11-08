import 'package:ekart/logic/bloc/product/product_bloc.dart';
import 'package:ekart/logic/bloc/product/product_event.dart';
import 'package:ekart/logic/bloc/product/product_state.dart';
import 'package:ekart/presentation/screens/Users/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const IconData menu = IconData(0xe3dc, fontFamily: 'MaterialIcons');
  static const IconData shopping_cart = IconData(0xe59c, fontFamily: 'MaterialIcons');
  static const IconData person = IconData(0xe491, fontFamily: 'MaterialIcons');
  // String? token = "";


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(GetAllProducts());
    // _loadToken();
  }

//   Future<void> _loadToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       token = prefs.getString('auth_token'); // Retrieve and set the token
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(content: Text(token ?? 'No token available')),
// );

  // }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: const EdgeInsets.only(top:40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      
          Padding(
            padding: const EdgeInsets.only(top:10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Icon(menu),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: Icon(shopping_cart)),
                Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15),
                  child: Icon(person),
                )
      
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top:12.0,left: 14),
          child: Text("Discover Products",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
        ),

        BlocBuilder<ProductBloc,ProductState>(builder: (context,state){
          if(state is ProductLoading){
            return const Center(child: CircularProgressIndicator());
          }else if(state is ProductLoaded){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 500,
                height: 500,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,mainAxisSpacing: 8),
                  itemCount: state.product.message.length,
                  itemBuilder: (context,index){
                    final product = state.product.message[index];
                  
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  ProductScreen(productName:product.productName, productDetails: product.productDetails, productId: product.id, productPrice: product.productPrice, productImage: product.productImage,
                        reviews: product.reviews,)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 173, 211, 241),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(product.productName),
                            Text("Rs ${product.productPrice}")
                        ],),
                      ),
                    );
                
                }
                ),
              ),
            );
          }else if (state is ProductError){
            return Text('Error:${state.message}');
          }
          return  Text("No product");
        }
        
        )
        
        
      ],),
    ),);
  }
}