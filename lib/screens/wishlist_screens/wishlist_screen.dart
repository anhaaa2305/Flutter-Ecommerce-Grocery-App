import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/providers_impl/wishlist_provider.dart';
import 'package:shopping_app_flutter/screens/wishlist_screens/wishlist_widget.dart';
import '../../provider/dark_theme_provider.dart';
import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/text_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = Utils(context).getColor;
    final wishListProvider = Provider.of<WishListProvider>(context);
    final wishListItemsList =
        wishListProvider.getWishListItem.values.toList().reversed.toList();
    return wishListItemsList.isEmpty
        ? const EmptyScreen(
            imagePath: "images/cart.png",
            title: 'Whoops!',
            subtitle: "Your cart is Empty",
            buttonText: "Browser products",
          )
        : Scaffold(
            appBar: AppBar(
                backgroundColor:
                    themeState.getDarkTheme ? Colors.white12 : Colors.blueGrey,
                elevation: 5,
                centerTitle: true,
                leading: const BackWidget(),
                automaticallyImplyLeading: false,
                title: TextWidget(
                  text: 'Wishlist(${wishListItemsList.length})',
                  color: color,
                  isTitle: true,
                  textSize: 22,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      GlobalMethods.warningDialog(
                          title: 'Empty your wishlist?',
                          subtitle: 'Are you sure?',
                          fct: () {
                            wishListProvider.clearWishList();
                            Navigator.pop(context);
                          },
                          context: context);
                    },
                    icon: Icon(
                      IconlyBold.delete,
                      size: 30,
                      color: color,
                    ),
                  ),
                ]),
            body: MasonryGridView.count(
              itemCount: wishListItemsList.length,
              crossAxisCount: 2,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishListItemsList[index],
                    child: const WishlistWidget());
              },
            ),
          );
  }
}
