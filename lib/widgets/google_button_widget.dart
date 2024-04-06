import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app_flutter/consts/firebase_constss.dart';
import 'package:shopping_app_flutter/screens/bottom_bar_screen.dart';
import 'package:shopping_app_flutter/services/global_method.dart';
import 'package:shopping_app_flutter/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});
  Future<void> _googleSignIn(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await authInstance.signInWithCredential(GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken));
          if (context.mounted) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const BottomBarScreen()));
          }
        } on FirebaseException catch (error) {
          if (context.mounted) {
            GlobalMethods.errorDialog(
                subtitle: "${error.message}", context: context);
          }
        } catch (error) {
          if (context.mounted) {
            GlobalMethods.errorDialog(subtitle: "$error", context: context);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                "images/google.png",
                width: 45,
              ),
            ),
            const SizedBox(
              width: 68,
            ),
            Center(
                child: TextWidget(
              text: "Sign in with google",
              color: Colors.white,
              textSize: 18,
              isTitle: true,
            )),
          ],
        ),
      ),
    );
  }
}
