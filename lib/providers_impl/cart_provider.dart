import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app_flutter/consts/firebase_constss.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  final userCollection = FirebaseFirestore.instance.collection("users");
  Future<void> fetchCart() async {
    final User? user = authInstance.currentUser;
    String uid = user!.uid;
    final DocumentSnapshot userDoc =
        await userCollection.doc(uid).get();
    final cartLength = userDoc.get("userCart").length;
    for (int i = 0; i < cartLength; i++) {
      _cartItems.putIfAbsent(
          userDoc.get("userCart")[i]["productId"],
          () => CartModel(
              id: userDoc.get("userCart")[i]["cartId"],
              productId: userDoc.get("userCart")[i]["productId"],
              quantity: userDoc.get("userCart")[i]["quantity"]));
    }
    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity - 1,
      ),
    );
    notifyListeners();
  }

  void increaseQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity + 1,
      ),
    );
    notifyListeners();
  }

  Future<void> removeOneItem({
    required String productId,
    required String cartId,
    required int quantity,
  }) async{
    final User? user = authInstance.currentUser;
    await userCollection.doc(user!.uid).update({
       "userCart": FieldValue.arrayRemove([
         {
           "cartId": cartId,
           "productId": productId,
           "quantity": quantity,
         }
       ]),
    });
    _cartItems.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  Future<void> clearCart() async{
    final User? user = authInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      "userCart": [],
    });
    _cartItems.clear();
    notifyListeners();
  }
}
