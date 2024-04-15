import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/consts/contss.dart';
import 'package:shopping_app_flutter/inner_screens/feeds_screen.dart';
import 'package:shopping_app_flutter/inner_screens/on_sale_screen.dart';
import 'package:shopping_app_flutter/models/products_model.dart';
import 'package:shopping_app_flutter/providers_impl/products_provider.dart';
import 'package:shopping_app_flutter/services/global_method.dart';
import 'package:shopping_app_flutter/services/utils.dart';
import 'package:shopping_app_flutter/widgets/feed_items_widget.dart';
import 'package:shopping_app_flutter/widgets/text_widget.dart';
import '../widgets/on_sales_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "/HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    "images/offers/Offer1.jpg",
    "images/offers/Offer2.jpg",
    "images/offers/Offer3.jpg",
    "images/offers/Offer4.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    Color color = utils.getColor;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;

    // Samsung Galaxy A10: 820.
    if (kDebugMode) {
      print("Width: ${size.width}, Height: ${size.height}");
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.27,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Constss.offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: false,
                itemCount: _offerImages.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white, activeColor: Colors.red),
                ),
                control: const SwiperControl(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            TextButton(
              onPressed: () {
                GlobalMethods.navigateTo(context, OnSaleScreen.routeName);
              },
              child: TextWidget(
                text: "View all",
                color: Colors.blue,
                textSize: 20,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextWidget(
                              text: "ON SALE",
                              color: Colors.red,
                              textSize: 20,
                              isTitle: true),
                          const Icon(
                            IconlyLight.discount,
                            color: Colors.red,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.18,
                    child: ListView.builder(
                        itemCount: productsOnSale.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: productsOnSale[index],
                            child: const OnSaleWidget(),
                          );
                        }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Our products",
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  TextButton(
                    onPressed: () {
                      GlobalMethods.navigateTo(context, FeedsScreen.routeName);
                    },
                    child: TextWidget(
                      text: "Browse all",
                      color: Colors.blue,
                      textSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              crossAxisSpacing: 8,
              childAspectRatio: size.width / (size.height * 0.55),
              children: List.generate(
                allProducts.length < 4 ? allProducts.length : 5,
                (index) {
                  return ChangeNotifierProvider.value(
                      value: allProducts[index], child: const FeedsWidget());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
