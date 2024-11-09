import 'package:ekart/presentation/screens/Users/cart_screen.dart';
import 'package:ekart/presentation/screens/Users/home_screen.dart';
import 'package:ekart/presentation/screens/Users/order_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();


   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children:  [
          HomePage(),
          CartScreen(pageController: _pageController,),
          OrderScreen()
        ],
      ),
       bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        child: Stack(

          children:[ BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pages),
                label: 'Orders',
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: (_selectedIndex * (MediaQuery.of(context).size.width / 3)) +
      (MediaQuery.of(context).size.width / 6) -
      (MediaQuery.of(context).size.width / 7) / 2,
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))),
              width: MediaQuery.of(context).size.width / 7,
              // color: 
            ),
          ),
        ]),
        
      ),
      
      // bottomSheet: AnimatedContainer(
      //   duration: const Duration(milliseconds: 300),
      //   alignment: Alignment(_selectedIndex == 0 ? -1 : _selectedIndex == 1 ? 0 : 1, 1),
      //   child: Container(
      //     height: 4,
      //     width: MediaQuery.of(context).size.width / 3,
      //     color: Colors.blue,
      //   ),
      // ),
    
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }
}