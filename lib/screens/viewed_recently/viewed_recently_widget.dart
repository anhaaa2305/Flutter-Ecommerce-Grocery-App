import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/inner_screens/product_details.dart';
import 'package:shopping_app_flutter/services/global_method.dart';
import '../../provider/dark_theme_provider.dart';
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
    /*final themeState = Provider.of<DarkThemeProvider>(context);
    final theme = Utils(context).getTheme;*/
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
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
                      "https://tancang-catering.com.vn/wp-content/uploads/2020/10/Jackfruit_Flesh-1721x1200.jpg",
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
                      text: "Product Title",
                      color: color,
                      textSize: 24,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextWidget(
                      text: '\$2.59',
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
                    child: icon(
                      fct: () {},
                      icon: CupertinoIcons.add,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(thickness: 0.5,height: 0.5,color: color,),
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
