import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/consts/theme_data.dart';
import 'package:shopping_app_flutter/inner_screens/cat_screen.dart';
import 'package:shopping_app_flutter/inner_screens/feeds_screen.dart';
import 'package:shopping_app_flutter/inner_screens/on_sale_screen.dart';
import 'package:shopping_app_flutter/inner_screens/product_details.dart';
import 'package:shopping_app_flutter/provider/dark_theme_provider.dart';
import 'package:shopping_app_flutter/providers_impl/cart_provider.dart';
import 'package:shopping_app_flutter/providers_impl/products_provider.dart';
import 'package:shopping_app_flutter/providers_impl/viewed_prod_provider.dart';
import 'package:shopping_app_flutter/providers_impl/wishlist_provider.dart';
import 'package:shopping_app_flutter/screens/auths/forget_pass.dart';
import 'package:shopping_app_flutter/screens/auths/login_screen.dart';
import 'package:shopping_app_flutter/screens/auths/sign_up_screen.dart';
import 'package:shopping_app_flutter/screens/bottom_bar_screen.dart';
import 'package:shopping_app_flutter/screens/home.dart';
import 'package:shopping_app_flutter/screens/order_screens/orders_screen.dart';
import 'package:shopping_app_flutter/screens/viewed_recently/viewed_recently_screen.dart';
import 'package:shopping_app_flutter/screens/wishlist_screens/wishlist_screen.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
    await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentAppTheme();
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) {
              return themeChangeProvider;
            }),
            ChangeNotifierProvider(create: (_) => ProductsProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => WishListProvider()),
            ChangeNotifierProvider(create: (_) => ViewedProdProvider()),
          ],
          child: Consumer<DarkThemeProvider>(
              builder: (context, themeChangeProvider, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: true,
                  title: 'Grocery shopping app',
                  theme: Styles.themeData(
                      themeChangeProvider.getDarkTheme, context),
                  home: const BottomBarScreen(),
                  routes: {
                    OnSaleScreen.routeName: (context) => const OnSaleScreen(),
                    ProductDetailsScreen.routeName: (context) =>
                    const ProductDetailsScreen(),
                    WishlistScreen.routeName: (
                        context) => const WishlistScreen(),
                    OrderScreen.routeName: (context) => const OrderScreen(),
                    ViewedRecentlyScreen.routeName: (context) =>
                    const ViewedRecentlyScreen(),
                    HomeScreen.routeName: (context) => const HomeScreen(),
                    SignUpScreen.routeName: (context) => const SignUpScreen(),
                    LoginScreen.routeName: (context) => const LoginScreen(),
                    ForgetPasswordScreen.routeName: (context) =>
                    const ForgetPasswordScreen(),
                    FeedsScreen.routeName: (context) => const FeedsScreen(),
                    CatsScreen.routeName: (context) => const CatsScreen(),
                  },
                );
              }),
        );
      },
    );
  }
}
