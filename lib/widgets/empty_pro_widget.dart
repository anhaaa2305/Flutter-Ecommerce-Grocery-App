import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/services/utils.dart';

class EmptyProdWidget extends StatelessWidget {
  const EmptyProdWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset("images/box.png"),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w700, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
