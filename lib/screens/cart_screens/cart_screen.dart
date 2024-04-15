import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/providers_impl/products_provider.dart';
import 'package:shopping_app_flutter/screens/bottom_bar_screen.dart';
import 'package:shopping_app_flutter/screens/cart_screens/cart_widget.dart';
import 'package:shopping_app_flutter/widgets/empty_screen.dart';
import 'package:shopping_app_flutter/services/global_method.dart';
import 'package:shopping_app_flutter/widgets/text_widget.dart';
import '../../provider/dark_theme_provider.dart';
import '../../providers_impl/cart_provider.dart';
import '../../services/utils.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = Utils(context).getColor;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    return cartItemList.isEmpty
        ? const EmptyScreen(
            imagePath: "images/cart.png",
            title: 'Whoops!',
            subtitle: "Your cart is Empty",
            buttonText: "Browser products",
          )
        : Scaffold(
            appBar: AppBar(
              leading: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () =>
                    Navigator.canPop(context) ? Navigator.pop(context) : null,
              ),
              backgroundColor:
                  themeState.getDarkTheme ? Colors.white12 : Colors.blueGrey,
              elevation: 5,
              title: TextWidget(
                text: "Cart (${cartItemList.length})",
                color: color,
                textSize: 25,
                isTitle: true,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                        title: "Empty your cart?",
                        subtitle: "Are you sure?",
                        fct: () {
                          cartProvider.clearCart();
                          Fluttertoast.showToast(msg: "Delete Successfully");
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomBarScreen()));
                        },
                        context: context);
                  },
                  icon: Icon(
                    IconlyBold.delete,
                    color: color,
                    size: 30,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                _checkOut(context: context),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItemList.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: cartItemList[index],
                          child: CartWidget(
                            q: cartItemList[index].quantity,
                          ));
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Widget _checkOut({
    required BuildContext context,
  }) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    var total = 0.0;
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrentProduct = productProvider.findProdById(value.productId);
      total += (getCurrentProduct.isOnSale
              ? getCurrentProduct.salePrice
              : getCurrentProduct.price) *
          value.quantity;
    });
    return Column(
      children: [
        Divider(
          thickness: 1,
          height: 2,
          color: color,
        ),
        Container(
          width: double.infinity,
          height: size.height * 0.1,
          color: themeState.getDarkTheme ? Colors.white12 : Colors.blueGrey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWidget(
                        text: "Order Now",
                        color: Colors.white,
                        textSize: 20,
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  child: TextWidget(
                    text: "Total: \$${total.toStringAsFixed(2)}",
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
