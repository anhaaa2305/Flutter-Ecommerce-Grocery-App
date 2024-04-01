import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../consts/contss.dart';
import '../../services/global_method.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/text_widget.dart';
import 'forget_pass.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String routeName = "/SignUpScreen";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  var _obscureText = true;
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _addressTextController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  //bool _isLoading = false;
  void _submitFormOnRegister() {}

  @override
  Widget build(BuildContext context) {
    //final theme = Utils(context).getTheme;
    //Color color = Utils(context).getColor;
    return Scaffold(
      body: Stack(
        children: [
          Swiper(
            duration: 800,
            autoplayDelay: 8000,
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                Constss.authImagesPaths[index],
                fit: BoxFit.cover,
              );
            },
            autoplay: true,
            itemCount: Constss.authImagesPaths.length,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 120,
                ),
                TextWidget(
                  text: "Welcome",
                  color: Colors.white,
                  textSize: 30,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextWidget(
                  text: "Sign up to continue",
                  color: Colors.white,
                  textSize: 18,
                  isTitle: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_emailFocusNode),
                          controller: _fullNameController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This Field is missing";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                            hintText: "Full name",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passFocusNode),
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains("@")) {
                              return "Please enter a valid email address";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        // Password
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            _submitFormOnRegister();
                          },
                          controller: _passTextController,
                          focusNode: _passFocusNode,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return "Please enter a valid password";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                Fluttertoast.showToast(msg: "Password showed");
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passFocusNode),
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return "Please enter a valid address";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                            hintText: "Shipping address",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding:const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(context, ForgetPasswordScreen.routeName);
                      },
                      child: const Text(
                        'Forget password?',
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthButton(
                    fct: () {}, buttonText: "Sign up", primary: Colors.grey),
                const SizedBox(
                  height: 20,
                ),
                /*Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextWidget(
                      text: "OR",
                      color: Colors.white,
                      textSize: 20,
                      isTitle: false,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),*/
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                      text: "Already a user?",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                            text: " Login",
                            style: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Fluttertoast.showToast(
                                    msg: "Go to login screen");
                                GlobalMethods.navigateTo(context, LoginScreen.routeName);
                              }),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
