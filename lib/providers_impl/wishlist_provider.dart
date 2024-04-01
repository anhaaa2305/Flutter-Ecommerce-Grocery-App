import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/models/wishlist_model.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListModel> _wishListItem = {};
  Map<String, WishListModel> get getWishListItem {
    return _wishListItem;
  }
  // add product to wish list
  void addOrRemoveProductToWishList({required String productId}) {
    if (_wishListItem.containsKey(productId)) {
      removeOneItem(productId);
    } else {
      _wishListItem.putIfAbsent(
          productId,
          () => WishListModel(
              id: DateTime.now().toString(), productId: productId));
    }
    notifyListeners();
  }
  // Remove one item
  void removeOneItem(String productId) {
    _wishListItem.remove(productId);
    notifyListeners();
  }
  // Clear wish list
  void clearWishList() {
    _wishListItem.clear();
    notifyListeners();
  }
}
