import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/widgets/empty_pro_widget.dart';
import 'package:shopping_app_flutter/widgets/feed_items_widget.dart';
import '../providers_impl/products_provider.dart';
import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/text_widget.dart';

class CatsScreen extends StatefulWidget {
  static const routeName = "/CatScreenState";

  const CatsScreen({super.key});

  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    Size size = Utils(context).getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    final productCategories =
        ModalRoute.of(context)!.settings.arguments as String;
    final productByCategories =
        productProviders.findByCategory(productCategories);
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: productCategories,
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body: productByCategories.isEmpty
          ? const EmptyProdWidget(
              title: "Whoops! No products belong to this Category \nStay tuned")
          : SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: TextField(
                      focusNode: _searchTextFocusNode,
                      controller: _searchTextController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.greenAccent, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.greenAccent, width: 1),
                        ),
                        hintText: "What's in your mind",
                        prefixIcon: const Icon(Icons.search),
                        suffix: IconButton(
                          onPressed: () {
                            _searchTextController.clear();
                            _searchTextFocusNode.unfocus();
                          },
                          icon: Icon(
                            Icons.close,
                            color: _searchTextFocusNode.hasFocus
                                ? Colors.red
                                : color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.zero,
                  // crossAxisSpacing: 10,
                  childAspectRatio: size.width / (size.height * 0.59),
                  children:
                      List.generate(productByCategories.length, (index) {
                    return ChangeNotifierProvider.value(
                        value: productByCategories[index],
                        child: const FeedsWidget());
                  }),
                ),
              ]),
            ),
    );
  }
}
