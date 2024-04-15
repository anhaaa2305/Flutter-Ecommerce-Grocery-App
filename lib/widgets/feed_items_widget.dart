import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/inner_screens/product_details.dart';
import 'package:shopping_app_flutter/models/products_model.dart';
import 'package:shopping_app_flutter/providers_impl/cart_provider.dart';
import 'package:shopping_app_flutter/providers_impl/wishlist_provider.dart';
import 'package:shopping_app_flutter/widgets/heart_btn.dart';
import 'package:shopping_app_flutter/widgets/price_widget.dart';
import 'package:shopping_app_flutter/widgets/text_widget.dart';
import '../consts/firebase_constss.dart';
import '../provider/dark_theme_provider.dart';
import '../services/global_method.dart';
import '../services/utils.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({super.key});

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quantityTextController.text = "1";
  }

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
    final productsModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productsModel.id);
    final wishListProvider = Provider.of<WishListProvider>(context);
    bool? isInWishList =
        wishListProvider.getWishListItem.containsKey(productsModel.id);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                arguments: productsModel.id);
          },
          borderRadius: BorderRadius.circular(22),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: productsModel.imageUrl,
                height:
                    size.height < 850 ? size.width * 0.15 : size.width * 0.18,
                width: size.width * 0.22,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextWidget(
                        text: productsModel.title,
                        color: color,
                        textSize: 16,
                        isTitle: true,
                        maxLines: 1,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: HeartButton(
                        productId: productsModel.id,
                        isInWishList: isInWishList,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: PriceWidget(
                        salePrice: productsModel.salePrice,
                        price: productsModel.price,
                        textPrice: _quantityTextController.text,
                        isOnSale: productsModel.isOnSale,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 6,
                            child: FittedBox(
                              child: TextWidget(
                                  text: "kg",
                                  color: color,
                                  textSize: 18,
                                  isTitle: true),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Flexible(
                              flex: 2,
                              child: TextFormField(
                                controller: _quantityTextController,
                                key: const ValueKey("10"),
                                style: TextStyle(
                                  color: color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                                maxLines: 1,
                                enabled: true,
                                onChanged: (value) {
                                  setState(() {
                                    if (_quantityTextController.text.isEmpty) {
                                      _quantityTextController.text = "0";
                                    } else {
                                      _quantityTextController.text =
                                          int.parse(value).toString();
                                    }
                                  });
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp("[0-9.]"),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: isInCart
                      ? null
                      : () async {
                          final User? user = authInstance.currentUser;
                          if (user == null) {
                            GlobalMethods.errorDialog(
                                subtitle:
                                    "Please log in to continue using the service. Thank you!",
                                context: context);
                            return;
                          }
                         await GlobalMethods.addToCart(
                              productId: productsModel.id,
                              quantity: int.parse(_quantityTextController.text),
                              context: context);
                          await cartProvider.fetchCart();
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        themeState.getDarkTheme
                            ? Colors.lightBlueAccent
                            : Colors.amberAccent),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                  ),
                  child: Text(
                    isInCart ? "In cart" : "Add to cart",
                    style: TextStyle(
                      color: themeState.getDarkTheme
                          ? Colors.red
                          : Colors.purpleAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
