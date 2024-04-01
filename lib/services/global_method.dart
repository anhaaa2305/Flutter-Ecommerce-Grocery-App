import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/text_widget.dart';

class GlobalMethods {
  static navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }
  static Future<void> warningDialog(
      {required String title,
      required String subtitle,
      required Function fct,
      required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  "images/warning-sign.png",
                  width: 25,
                  height: 25,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(title),
              ],
            ),
            content: Text(
              subtitle,
              style:const TextStyle(
                fontSize: 20,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: "Cancel",
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {
                  fct();
                  Fluttertoast.showToast(msg: "$title Successfully");
                },
                child: TextWidget(
                  color: Colors.red,
                  text: "Ok",
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }
}
