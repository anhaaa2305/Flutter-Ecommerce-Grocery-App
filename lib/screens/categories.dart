import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/services/utils.dart';
import 'package:shopping_app_flutter/widgets/categories_widget.dart';
import 'package:shopping_app_flutter/widgets/text_widget.dart';
class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  final List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];
  final List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'images/cat/fruits.png',
      'catText': 'Fruits',
    },
    {
      'imgPath': 'images/cat/veg.png',
      'catText': 'Vegetables',
    },
    {
      'imgPath': 'images/cat/Spinach.png',
      'catText': 'Herbs',
    },
    {
      'imgPath': 'images/cat/nuts.png',
      'catText': 'Nuts',
    },
    {
      'imgPath': 'images/cat/spices.png',
      'catText': 'Spices',
    },
    {
      'imgPath': 'images/cat/grains.png',
      'catText': 'Grains',
    },
  ];
  @override
  Widget build(BuildContext context) {
    //final themeState = Provider.of<DarkThemeProvider>(context);
    final utils = Utils(context);
    Color color = utils.getColor;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: "Categories",
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 240 / 250,
        crossAxisSpacing: 5, // Vertical Spacing
        mainAxisSpacing: 5,  // Horizontal Spacing
        children: List.generate(6, (index){
          return CategoriesWidget(
            catText: catInfo[index]["catText"],
            imgPath: catInfo[index]["imgPath"],
            passedColor: gridColors[index],
          );
        }),
      ),
    );
  }
}
