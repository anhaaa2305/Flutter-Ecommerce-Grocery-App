/*
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopping_app_flutter/inner_screens/product_details.dart';
import 'package:shopping_app_flutter/services/global_method.dart';
import 'package:shopping_app_flutter/widgets/heart_btn.dart';
import 'package:shopping_app_flutter/widgets/price_widget.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.navigateTo(context, ProductDetailsScreen.routeName);
        },
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  height: size.width * 0.2,
                  width: size.width * 0.4,
                  child: FancyShimmerImage(
                    imageUrl: "https://media.istockphoto.com/photos/ripe-red-grape-with-leaves-isolated-on-white-picture-id469799290?k=6&m=469799290&s=612x612&w=0&h=XL5WwRCnmvtUzArOCiw7L1SJfzQM5XBXjwwPmHyIAaU=",
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                IconlyLight.bag2,
                                color: color,
                              ),
                            ),
                            const HeartButton(),
                          ],
                        ),
                      ),
                      TextWidget(
                        text: "Product Title",
                        color: color,
                        textSize: 18.0,
                        maxLines: 2,
                        isTitle: true,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const PriceWidget(
                        salePrice: 2.99,
                        price: 5.9,
                        textPrice: "1",
                        isOnSale: true,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopping_app_flutter/inner_screens/product_details.dart';
import 'package:shopping_app_flutter/services/global_method.dart';
import 'package:shopping_app_flutter/widgets/heart_btn.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';
class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});
  @override
  Widget build(BuildContext context) {
    /*final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final getCurrProduct =
    productProvider.findProdById(wishlistModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;*/
/*    bool? _isInWishlist =
    wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);*/
    final Color color = Utils(context).getColor;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
         /* Navigator.pushNamed(context, ProductDetailsScreen.routeName,
              arguments: wishlistModel.productId);*/
          GlobalMethods.navigateTo(context, ProductDetailsScreen.routeName);
        },
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: size.width * 0.25,
                  height: size.width * 0.2,
                  child: FancyShimmerImage(
                    imageUrl: "https://www.hdwallpapers.in/download/strawberries_in_white_background_hd_strawberry-HD.jpg",
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconlyLight.bag2,
                              color: color,
                            ),
                          ),
                          //HeartButton(),
                        ],
                      ),
                    ),
                    TextWidget(
                      text: "Title",
                      color: color,
                      textSize: 20.0,
                      maxLines: 2,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: "\$ 0.39",
                      color: color,
                      textSize: 18.0,
                      maxLines: 1,
                      isTitle: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
