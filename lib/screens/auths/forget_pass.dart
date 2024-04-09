import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app_flutter/consts/firebase_constss.dart';
import 'package:shopping_app_flutter/services/global_method.dart';
import '../../consts/contss.dart';
import '../../services/utils.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';
import '../loading_manager.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  void _forgetPassFCT(BuildContext context) async {
    if (_emailTextController.text.isEmpty ||
        !_emailTextController.text.contains("@")) {
      GlobalMethods.errorDialog(
          subtitle: "Please enter a correct email address", context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: _emailTextController.text.toLowerCase().trim());
        Fluttertoast.showToast(
            msg:
                "Check your email for instructions on how to reset your password.");
      } on FirebaseException catch (error) {
        setState(() {
          _isLoading = false;
        });
        if (context.mounted) {
          GlobalMethods.errorDialog(
              subtitle: "${error.message}", context: context);
        }
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Constss.authImagesPaths[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: false,
              itemCount: Constss.authImagesPaths.length,
              // control: const SwiperControl(),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  const BackWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: 'Forget password',
                    color: Colors.white,
                    textSize: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _emailTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Email address",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                    buttonText: 'Reset now',
                    fct: () {
                      _forgetPassFCT(context);
                    },
                    primary: Colors.white38,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
