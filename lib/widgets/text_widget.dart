import 'package:flutter/cupertino.dart';

class TextWidget extends StatelessWidget {
  TextWidget(
      {super.key,
      required this.text,
      required this.color,
      required this.textSize,
      this.isTitle = false,
      this.maxLines = 10});
  final String text;
  final Color color;
  final double textSize;
  final bool isTitle;
  int maxLines = 10;
  @override
  Widget build(BuildContext context) {
    //final themeState = Provider.of<DarkThemeProvider>(context);
    return Text(
      text,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: color,
        fontSize: textSize,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
