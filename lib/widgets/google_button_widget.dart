import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.asset("images/google.png",
              width: 45,),
            ),
            const SizedBox(width: 68,),
            Center(child: TextWidget(text: "Sign in with google", color: Colors.white, textSize: 18, isTitle: true,)),
          ],
        ),
      ),
    );
  }
}
