import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/widgets/back_widget.dart';
import 'package:shopping_app_flutter/widgets/empty_pro_widget.dart';
import 'package:shopping_app_flutter/widgets/on_sales_widget.dart';
import 'package:shopping_app_flutter/widgets/text_widget.dart';
import '../models/products_model.dart';
import '../provider/dark_theme_provider.dart';
import '../providers_impl/products_provider.dart';
import '../services/utils.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    return Scaffold(
      appBar: AppBar(
        leading:const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          textSize: 25,
          text: "Products on Sale",
          color: color,
          isTitle: true,
        ),
      ),
      body: productsOnSale.isEmpty
          ? const EmptyProdWidget(title: "No products on Sale yet!, \nStay tuned",)
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              //crossAxisSpacing: 2,
              childAspectRatio: size.width / (size.height * 0.45),
              children: List.generate(
                productsOnSale.length,
                (index) {
                  return ChangeNotifierProvider.value(
                      value: productsOnSale[index],
                      child: const OnSaleWidget(),);
                },
              ),
            ),
    );
  }
}
