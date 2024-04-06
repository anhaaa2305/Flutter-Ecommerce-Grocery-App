import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';
import 'orders_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const routeName = '/OrderScreen';
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          elevation: 0,
          centerTitle: false,
          title: TextWidget(
            text: 'Your orders (10)',
            color: color,
            textSize: 24.0,
            isTitle: true,
          ),
          backgroundColor: Theme.of(context)
              .scaffoldBackgroundColor
              .withOpacity(0.9),
        ),
        body: ListView.separated(
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: 10),
              child: ChangeNotifierProvider(
                create: (BuildContext context) {  },
                child: const OrderWidget(),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: color,
              thickness: 1,
            );
          },
        ));
  }
}
