import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/providers_impl/cart_provider.dart';
import 'package:shopping_app_flutter/providers_impl/viewed_prod_provider.dart';
import 'package:shopping_app_flutter/providers_impl/wishlist_provider.dart';
import 'package:shopping_app_flutter/screens/cart_screens/cart_screen.dart';
import 'package:shopping_app_flutter/widgets/heart_btn.dart';
import 'package:shopping_app_flutter/widgets/text_widget.dart';
import '../consts/firebase_constss.dart';
import '../provider/dark_theme_provider.dart';
import '../providers_impl/products_provider.dart';
import '../services/global_method.dart';
import '../services/utils.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = "/ProductDetailsScreen";

  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _quantityTextController = TextEditingController(text: "1");
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _quantityTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final productProviders = Provider.of<ProductsProvider>(context);
    final productId = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    final getCurrentProduct = productProviders.findProdById(productId);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart =
    cartProvider.getCartItems.containsKey(getCurrentProduct.id);
    final cartItemList =
    cartProvider.getCartItems.values
        .toList()
        .reversed
        .toList();
    final wishListProvider = Provider.of<WishListProvider>(context);
    bool? isInWishList = wishListProvider.getWishListItem.containsKey(productId);
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (){
            viewedProdProvider.addProductToHistory(productId: productId);
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            size: 30,
            color: color,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const CartScreen()));
              },
              borderRadius: BorderRadius.circular(12),
              child: badges.Badge(
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
                  style: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                child: Icon(
                  themeState.getDarkTheme ? IconlyBold.buy : IconlyLight.buy,
                  color: color,
                  size: 30,),
              ),
            ),
          ),
        ],
        elevation: 2,
        backgroundColor:
        themeState.getDarkTheme ? Colors.white12 : Colors.blueGrey,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: FancyShimmerImage(
              imageUrl: getCurrentProduct.imageUrl,
              width: size.width,
              boxFit: BoxFit.scaleDown,
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  color: themeState.getDarkTheme
                      ? Colors.blueGrey
                      : Colors.lightBlue.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextWidget(
                            text: getCurrentProduct.title,
                            color: color,
                            textSize: 25,
                            isTitle: true,
                          ),
                        ),
                        HeartButton(
                          productId: getCurrentProduct.id,
                          isInWishList: isInWishList,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 20, left: 20, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getCurrentProduct.isOnSale
                            ? Row(
                          children: [
                            TextWidget(
                              text:
                              getCurrentProduct.salePrice.toString(),
                              color: Colors.green,
                              textSize: 22,
                              isTitle: true,
                            ),
                            TextWidget(
                              text: " /Kg",
                              color: color,
                              textSize: 18,
                              isTitle: false,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Visibility(
                              visible: true,
                              child: Text(
                                "\$ ${getCurrentProduct.price.toString()}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: color,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                          ],
                        )
                            : Row(
                          children: [
                            TextWidget(
                              text: getCurrentProduct.price.toString(),
                              color: Colors.green,
                              textSize: 22,
                              isTitle: true,
                            ),
                            TextWidget(
                              text: " /Kg",
                              color: color,
                              textSize: 18,
                              isTitle: false,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextWidget(
                            text: "Free delivery",
                            color: Colors.white.withOpacity(1),
                            textSize: 20,
                            isTitle: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: SizedBox(
                      width: size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _quantityController(
                              fct: () {
                                if (_quantityTextController.text == "1") {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityTextController.text = (int.parse(
                                        _quantityTextController.text) -
                                        1)
                                        .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.red),
                          Flexible(
                            flex: 1,
                            child: TextField(
                              controller: _quantityTextController,
                              key: const ValueKey("quantity"),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                              textAlign: TextAlign.center,
                              cursorColor: Colors.green,
                              enabled: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]")),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    _quantityTextController.text = "1";
                                  } else {
                                    return;
                                  }
                                });
                              },
                            ),
                          ),
                          _quantityController(
                              fct: () {
                                setState(() {
                                  _quantityTextController.text =
                                      (int.parse(_quantityTextController.text) +
                                          1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.add,
                              color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                      color: themeState.getDarkTheme
                          ? Colors.lightBlue
                          : Colors.lightBlue,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: "Total",
                                color: Colors.red,
                                textSize: 22,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    TextWidget(
                                      text:
                                      "\$ ${(usedPrice * int.parse(
                                          _quantityTextController.text))
                                          .toStringAsFixed(2)}",
                                      color: color,
                                      textSize: 20,
                                      isTitle: true,
                                    ),
                                    TextWidget(
                                      text: " /kg",
                                      color: color,
                                      textSize: 16,
                                      isTitle: false,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          flex: 1,
                          child: Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: isInCart
                                  ? null
                                  : () {

                                final User? user = authInstance.currentUser;
                                if (user == null) {
                                  GlobalMethods.errorDialog(subtitle: "Please log in to continue using the service. Thank you!", context: context);
                                  return;
                                }
                                Fluttertoast.showToast(
                                    msg: "Add to Cart Successful");
                                cartProvider.addProductsToCart(
                                  productId: getCurrentProduct.id,
                                  quantity: int.parse(
                                      _quantityTextController.text),
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextWidget(
                                  textSize: 20,
                                  text: isInCart ? "In cart" : "Add to cart",
                                  color: Colors.white,
                                  isTitle: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            fct();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
