/*
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping_app_flutter/widgets/empty_screen.dart';
import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';
import 'wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    //Size size = Utils(context).getScreenSize;
    bool isEmpty = false;
    return isEmpty ? const EmptyScreen(imagePath: "images/wishlist.png", title: "Whoops!", subtitle: "Your wishlist is Empty", buttonText: "Add a wish") : Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackWidget(),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Theme
                .of(context)
                .scaffoldBackgroundColor,
            title: TextWidget(
              text: 'Wishlist (2)',
              color: color,
              isTitle: true,
              textSize: 22,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(title: "Empty your wishlist?",
                      subtitle: "Are you sure?",
                      fct: () {},
                      context: context);
                },
                icon: Icon(
                  IconlyBroken.delete,
                  color: color,
                ),
              ),
            ]),
        body: MasonryGridView.count(
          itemCount: 10,
          crossAxisCount: 2,
*/
/*          mainAxisSpacing: 4,
          crossAxisSpacing: 4,*//*

          itemBuilder: (context, index) {
            return const WishlistWidget();
          },
        ),
      // mainAxisSpacing: 16,
      // crossAxisSpacing: 20,
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/screens/wishlist_screens/wishlist_widget.dart';

import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    Size size = Utils(context).getScreenSize;
   //final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: const BackWidget(),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: 'Wishlist',
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
                    fct: () {},
                    context: context);
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            ),
          ]),
      body: MasonryGridView.count(
        itemCount: 10,
        crossAxisCount: 2,
/*          mainAxisSpacing: 4,
          crossAxisSpacing: 4,*/
        itemBuilder: (context, index) {
          return const WishlistWidget();
        },
      ),);
  }
}

