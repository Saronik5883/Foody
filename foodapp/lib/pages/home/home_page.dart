import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/pages/account/account_page.dart';
import 'package:foodapp/pages/auth/sign_in_page.dart';
import 'package:foodapp/pages/auth/sign_up_page.dart';
import 'package:foodapp/pages/cart/cart_history.dart';
import 'package:foodapp/pages/home/main_food_page.dart';
import 'package:foodapp/pages/menu/menu_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../utils/AppColors.dart';
import '../address_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  late PersistentTabController _controller;

  List pages=[
    MainFoodPage(),
    MenuPage(),
    CartHistory(),
    AccountPage(),

  ];


  void onTapNav(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  void initState(){
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }
  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      MenuPage(),
      CartHistory(),
      AccountPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens()[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            _selectedIndex=index;
          });
        },
        labelBehavior: labelBehavior,
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined,),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book,),
            label: "Menu",
          ),
          NavigationDestination(
            icon: Icon(Icons.history,),
            label: "History",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline,),
            label: "Profile",
          ),
        ],
      ),
    );
  }



}
