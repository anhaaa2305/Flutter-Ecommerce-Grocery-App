import "dart:async";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_iconly/flutter_iconly.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:provider/provider.dart";
import "package:shopping_app_flutter/consts/firebase_constss.dart";
import "package:shopping_app_flutter/screens/auths/forget_pass.dart";
import "package:shopping_app_flutter/screens/auths/login_screen.dart";
import "package:shopping_app_flutter/screens/loading_manager.dart";
import "package:shopping_app_flutter/screens/order_screens/orders_screen.dart";
import "package:shopping_app_flutter/screens/viewed_recently/viewed_recently_screen.dart";
import "package:shopping_app_flutter/screens/wishlist_screens/wishlist_screen.dart";
import "package:shopping_app_flutter/services/global_method.dart";
import "package:shopping_app_flutter/widgets/text_widget.dart";
import "../provider/dark_theme_provider.dart";
import "../providers_impl/cart_provider.dart";

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressController =
      TextEditingController(text: "");
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  String? _email;
  String? _name;
  String? _address;

  // Defined Subtitle
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _addressController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData(context);
  }

  Future<void> getUserData(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String uid = user!.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      _email = userDoc.get("email");
      _name = userDoc.get("name");
       _address = userDoc.get("shipping-address");
      _addressController.text = userDoc.get("shipping-address");
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        GlobalMethods.errorDialog(subtitle: "$error", context: context);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color =
        themeState.getDarkTheme ? Colors.white.withOpacity(0.9) : Colors.black;
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Hi, ",
                          style: const TextStyle(
                            color: Colors.cyan,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                        TextSpan(
                            text: _name == null ? "user" : _name!,
                            style: TextStyle(
                              color: color,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ])),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: _email == null ? "Email@gmail.com" : _email!,
                    color: color,
                    textSize: 16,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTitle(
                      title: "Address",
                      subtitle: _addressController.text.toString(),
                      icon: IconlyLight.location,
                      onPressed: () async {
                        await _showAddressDialog();
                      },
                      color: color),
                  _listTitle(
                      title: "Orders",
                      subtitle: "Sản phẩm đã chọn",
                      icon: IconlyLight.bag,
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            context, OrderScreen.routeName);
                      },
                      color: color),
                  _listTitle(
                      title: "Wishlist",
                      subtitle: "Sản phẩm yêu thích",
                      icon: IconlyLight.heart,
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            context, WishlistScreen.routeName);
                      },
                      color: color),
                  _listTitle(
                      title: "Viewed",
                      subtitle: "Sản phẩm bạn đã xem",
                      icon: IconlyLight.show,
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            context, ViewedRecentlyScreen.routeName);
                      },
                      color: color),
                  _listTitle(
                      title: "Forget password",
                      subtitle: "Khôi phục sản phẩm tại đây",
                      icon: IconlyLight.unlock,
                      onPressed: () {
                        /*Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()));*/
                        GlobalMethods.navigateTo(
                            context, ForgetPasswordScreen.routeName);
                      },
                      color: color),
                  _listTitle(
                      title: user == null ? "Login" : "Logout",
                      subtitle: user == null
                          ? "Đăng nhập để sử dụng dịch vụ"
                          : "Đăng xuất khỏi tài khoản hiện tại",
                      icon:
                          user == null ? IconlyLight.login : IconlyLight.logout,
                      onPressed: () async {
                        user == null
                            ? GlobalMethods.navigateTo(
                                context, LoginScreen.routeName)
                            : GlobalMethods.warningDialog(
                                title: "Sign out",
                                subtitle: "Do you wanna sign out?",
                                fct: () {
                                  authInstance.signOut();
                                  cartProvider.clearCart();
                                  Fluttertoast.showToast(
                                      msg: "Logout successfully");
                                },
                                context: context);
                      },
                      color: color),
                  SwitchListTile(
                    title: Text(
                      "Theme",
                      style: TextStyle(
                          fontSize: 18,
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.black),
                    ),
                    secondary: Icon(
                      themeState.getDarkTheme
                          ? Icons.dark_mode
                          : Icons.light_mode_outlined,
                      color: themeState.getDarkTheme
                          ? Colors.white70
                          : Colors.black,
                      size: 33,
                    ),
                    value: themeState.getDarkTheme,
                    onChanged: (bool value) {
                      setState(() {
                        themeState.setDarkTheme = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update"),
            content: TextField(
              onChanged: (value) {},
              controller: _addressController,
              maxLines: 2,
              decoration: InputDecoration(
                  hintText: "Your address",
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  )),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  setState(() {});
                  String uid = user!.uid;
                  try {
                    if (_addressController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Address can not Empty");
                    } else {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(uid)
                          .update({
                        "shipping-address": _addressController.text,
                      });
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                      Fluttertoast.showToast(msg: "Update address Successful");
                    }
                  } catch (error) {
                    if (context.mounted) {
                      GlobalMethods.errorDialog(
                          subtitle: "$error", context: context);
                    }
                  }
                },
                child: const Text("Update"),
              ),
            ],
          );
        });
  }
  Widget _listTitle({
    required String title,
    required String subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool isDark = themeState.getDarkTheme;
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 18,
      ),
      subtitle: TextWidget(
        text: subtitle,
        color: color,
        textSize: 15,
      ),
      leading: Icon(
        icon,
        size: 33,
        color: isDark ? Colors.white70 : Colors.black,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
