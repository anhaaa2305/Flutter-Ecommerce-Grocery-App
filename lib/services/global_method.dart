import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../consts/firebase_constss.dart';
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
            style: const TextStyle(
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
                Navigator.pop(context);
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
      },
    );
  }

  static Future<void> errorDialog(
      {required String subtitle, required BuildContext context}) async {
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
              const Text("Error"),
            ],
          ),
          content: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextWidget(
                color: Colors.red,
                text: "Ok",
                textSize: 18,
              ),
            ),
          ],
        );
      },
    );
  }
  // Store cart with user into Firestore firebase
  static Future<void> addToCart({
    required String productId,
    required int quantity,
    required BuildContext context,
  }) async {
    final User? user = authInstance.currentUser;
    final uid = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection("users").doc(uid).update({
        "userCart": FieldValue.arrayUnion([
          {
            "cartId": cartId,
            "productId": productId,
            "quantity": quantity,
          }
        ]),
      });
      Fluttertoast.showToast(msg: "Item has been added to your cart",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER);
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }
}
