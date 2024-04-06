/*
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/inner_screens/product_details.dart';
import 'package:shopping_app_flutter/models/viewed_model.dart';
import 'package:shopping_app_flutter/providers_impl/cart_provider.dart';
import 'package:shopping_app_flutter/providers_impl/products_provider.dart';
import 'package:shopping_app_flutter/services/global_method.dart';
import '../../providers_impl/viewed_prod_provider.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';
class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({super.key});

  @override
  State<ViewedRecentlyWidget> createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final productProvider = Provider.of<ProductsProvider>(context);
    final viewedModel = Provider.of<ViewedProdModel>(context);
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    final viewedProItemsList = viewedProdProvider.getViewedProdlistItems.values
        .toList()
        .reversed
        .toList();
    final getCurrentProductInViewed =
        productProvider.findProdById(viewedModel.productId);
    final usedPrice = getCurrentProductInViewed.isOnSale
        ? getCurrentProductInViewed.salePrice
        : getCurrentProductInViewed.price;
    final cartProvider = Provider.of<CartProvider>(context);
    final isInCart = cartProvider.getCartItems.containsKey(getCurrentProductInViewed.id);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              GlobalMethods.navigateTo(context, ProductDetailsScreen.routeName);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FancyShimmerImage(
                  imageUrl:
                      getCurrentProductInViewed.imageUrl,
                  boxFit: BoxFit.fill,
                  height: size.width * 0.27,
                  width: size.width * 0.25,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  children: [
                    TextWidget(
                      text: getCurrentProductInViewed.title,
                      color: color,
                      textSize: 24,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextWidget(
                      text: '\$ ${usedPrice.toStringAsFixed(2)}',
                      color: color,
                      textSize: 20,
                      isTitle: false,
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                    onTap: isInCart ? null : () {
                      Fluttertoast.showToast(msg: "Add to Cart Successful");
                      cartProvider.addProductsToCart(
                        productId: getCurrentProductInViewed.id,
                        quantity: 1,
                      );
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green,
                      child: icon(
                        fct: () {},
                        icon: isInCart ? Icons.check : IconlyBold.plus,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 0.5,
          height: 0.5,
          color: color,
        ),
      ],
    );
  }

  Widget icon({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
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
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/inner_screens/product_details.dart';
import '../../consts/firebase_constss.dart';
import '../../models/viewed_model.dart';
import '../../providers_impl/cart_provider.dart';
import '../../providers_impl/products_provider.dart';
import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({super.key});

  @override
  State<ViewedRecentlyWidget> createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);

    final viewedProdModel = Provider.of<ViewedProdModel>(context);

    final getCurrProduct =
        productProvider.findProdById(viewedProdModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    Color color = Utils(context).getColor;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.navigateTo(context, ProductDetailsScreen.routeName);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FancyShimmerImage(
              imageUrl: getCurrProduct.imageUrl,
              boxFit: BoxFit.fill,
              height: size.width * 0.27,
              width: size.width * 0.25,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                TextWidget(
                  text: getCurrProduct.title,
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextWidget(
                  text: '\$${usedPrice.toStringAsFixed(2)}',
                  color: color,
                  textSize: 20,
                  isTitle: false,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green,
                child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: isInCart
                        ? null
                        : () {
                            final User? user = authInstance.currentUser;
                            if (user == null) {
                              GlobalMethods.errorDialog(
                                  subtitle:
                                      "Please log in to continue using the service. Thank you!",
                                  context: context);
                              return;
                            }
                            cartProvider.addProductsToCart(
                              productId: getCurrProduct.id,
                              quantity: 1,
                            );
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isInCart ? Icons.check : IconlyBold.plus,
                        color: Colors.white,
                        size: 20,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
