import 'package:ekart/data/repositories/cart_repository.dart';
import 'package:ekart/data/repositories/product_repository.dart';
import 'package:ekart/data/repositories/user_repository.dart';
import 'package:ekart/logic/bloc/cart/cart_bloc.dart';
import 'package:ekart/logic/bloc/product/product_bloc.dart';
import 'package:ekart/logic/bloc/user/user_bloc.dart';
import 'package:ekart/presentation/screens/Users/cart_screen.dart';
import 'package:ekart/presentation/screens/Users/product_screen.dart';
import 'package:ekart/presentation/screens/login_screen.dart';
import 'package:ekart/presentation/screens/signup_screen.dart';
import 'package:ekart/presentation/screens/signup_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      
      BlocProvider<UserBloc>(create:(context) => UserBloc(userRepository: UserRepository())),
      BlocProvider<ProductBloc>(create:(context) => ProductBloc(productRepository: ProductRepository())),
      BlocProvider<CartBloc>(create:(context) => CartBloc(cartRepository: CartRepository())),
      ],
      child: MaterialApp(
      
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          // fontFamily: GoogleFonts.latoText(),
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/signup': (context) => const SignUp(),
          '/cart':(context)=> const CartScreen(),
          // '/productDetails':(context)=> const ProductScreen()
          // '/signup2':(context)=> SignUpTwo(email: "email", password: "password", confirmPassword: "confirmPassword")
        },
      ),
    );
  }
}
