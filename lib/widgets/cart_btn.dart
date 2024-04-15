import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../consts/firebase_constss.dart';
import '../models/products_model.dart';
import '../providers_impl/cart_provider.dart';
import '../services/global_method.dart';
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
      onTap: () async{
        final User? user = authInstance.currentUser;
        if (user == null) {
          GlobalMethods.errorDialog(
              subtitle:
                  "Please log in to continue using the service. Thank you!",
              context: context);
          return;
        } else {
         await GlobalMethods.addToCart(
              productId: productsModel.id, quantity: 1, context: context);
         await cartProvider.fetchCart();
        }
      },
      child: Icon(
        isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
        size: 22,
        color: isInCart ? Colors.green : color,
      ),
    );
  }
}
