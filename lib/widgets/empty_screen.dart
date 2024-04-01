import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/widgets/text_widget.dart';
import '../services/utils.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {super.key, required this.imagePath, required this.title, required this.subtitle, required this.buttonText});

  final String imagePath, title, subtitle, buttonText;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: double.infinity,
                height: size.height * 0.4,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 40,
                    color: Colors.red,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                  text: subtitle,
                  color: Colors.orange,
                  isTitle: true,
                  maxLines: 2,
                  textSize: 30),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: color,
                      ),
                    ),
                    backgroundColor: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                    // onPrimary: color,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  ),
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: TextWidget(
                      text: buttonText,
                      color: color,
                      isTitle: true,
                      textSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
