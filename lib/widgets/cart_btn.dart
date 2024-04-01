import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../models/products_model.dart';
import '../providers_impl/cart_provider.dart';
import '../services/utils.dart';
class CartButton extends StatelessWidget {
  const CartButton({super.key});
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final cartProvider = Provider.of<CartProvider>(context);
    final productsModel = Provider.of<ProductModel>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productsModel.id);
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print("Add to Cart Successful");
        }
        cartProvider.addProductsToCart(
          productId: productsModel.id,
          quantity: 1,
        );
      },
      child: Icon(
        isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
        size: 22,
        color: isInCart ? Colors.green : color,
      ),
    );
  }
}
