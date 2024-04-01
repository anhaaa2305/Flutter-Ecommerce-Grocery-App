import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/providers_impl/wishlist_provider.dart';
import '../services/utils.dart';

class HeartButton extends StatelessWidget {
  const HeartButton(
      {super.key, required this.productId, this.isInWishList = false});

  final String productId;
  final bool isInWishList;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final wishListProvider = Provider.of<WishListProvider>(context);
    return GestureDetector(
      onTap: () {
       wishListProvider.addOrRemoveProductToWishList(productId: productId);
      },
      child: Icon(
        isInWishList ? IconlyBold.heart : IconlyLight.heart,
        size: 22,
        color: isInWishList ? Colors.red : color,
      ),
    );
  }
}
