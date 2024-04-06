import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/inner_screens/product_details.dart';
import 'package:shopping_app_flutter/models/wishlist_model.dart';
import 'package:shopping_app_flutter/providers_impl/products_provider.dart';
import 'package:shopping_app_flutter/providers_impl/wishlist_provider.dart';
import 'package:shopping_app_flutter/widgets/heart_btn.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';
class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    Size size = Utils(context).getScreenSize;
    final wishListProvider = Provider.of<WishListProvider>(context);
    final wishListModel = Provider.of<WishListModel>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProductInWishList = productProvider.findProdById(wishListModel.productId);
    final isInWishList = wishListProvider.getWishListItem.containsKey(getCurrentProductInWishList.id);
    final usedPrice = getCurrentProductInWishList.isOnSale ? getCurrentProductInWishList.salePrice : getCurrentProductInWishList.price;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
         Navigator.pushNamed(context, ProductDetailsScreen.routeName,
              arguments: getCurrentProductInWishList.id);
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
                    imageUrl: getCurrentProductInWishList.imageUrl,
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
                          HeartButton(
                            productId: getCurrentProductInWishList.id,
                            isInWishList: isInWishList,
                          ),
                        ],
                      ),
                    ),
                    TextWidget(
                      text: getCurrentProductInWishList.title,
                      color: color,
                      textSize: 20.0,
                      maxLines: 2,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: "\$ ${usedPrice.toStringAsFixed(2)}",
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
