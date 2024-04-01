import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/screens/cart_screens/cart.dart';
import 'package:shopping_app_flutter/screens/categories.dart';
import 'package:shopping_app_flutter/screens/home.dart';
import 'package:shopping_app_flutter/screens/user.dart';
import '../provider/dark_theme_provider.dart';
import 'package:badges/badges.dart' as badges;
import '../providers_impl/cart_provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {
      'page': const HomeScreen(),
      'title': 'Home',
    },
    {
      'page': CategoriesScreen(),
      'title': 'Categories',
    },
    {
      'page': const CartScreen(),
      'title': 'Cart',
    },
    {
      'page': const UserScreen(),
      'title': 'Setting',
    },
  ];

  void _selectedPages(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    return Scaffold(
      /*appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title'],
        style:const TextStyle(
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: _isDark ? Colors.blueGrey : Colors.lightBlue.shade200,
      ),*/
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeState.getDarkTheme
            ? Theme.of(context).cardColor
            : Colors.white,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _selectedPages,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(
                IconlyBold.home,
                size: 30,
              ),
              label: "Home"),
          const BottomNavigationBarItem(
              /*icon: Icon(_selectedIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),*/
              icon: Icon(
                IconlyBold.category,
                size: 30,
              ),
              label: "Categories"),
          BottomNavigationBarItem(
              icon: badges.Badge(
                badgeAnimation: const badges.BadgeAnimation.fade(
                  animationDuration: Duration(milliseconds: 1500),
                  curve: Curves.easeInCubic,
                  loopAnimation: true,
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.red,
                ),
                badgeContent: Text(
                  cartItemList.length.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                child: const Icon(
                  IconlyBold.buy,
                  size: 30,
                ),
              ),
              label: "Cart"),
          const BottomNavigationBarItem(
            icon: Icon(
              IconlyBold.user2,
              size: 30,
            ),
            label: "User",
          ),
        ],
      ),
    );
  }
}
