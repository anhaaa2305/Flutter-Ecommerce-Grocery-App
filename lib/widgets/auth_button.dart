import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/widgets/text_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.fct,
      required this.buttonText,
      required this.primary});

  final Function fct;
  final String buttonText;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: Material(
        color: primary,
        child: InkWell(
          onTap: (){
            fct();
          },
          child: Center(
            child: TextWidget(
              text: buttonText,
              color: Colors.white,
              textSize: 18,
              isTitle: true,
            ),
          ),
        ),
      ),
    );
  }
}
