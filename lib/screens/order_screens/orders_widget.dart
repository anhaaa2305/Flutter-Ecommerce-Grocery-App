import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/inner_screens/product_details.dart';
import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';
class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});
  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}
class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    Size size = Utils(context).getScreenSize;
    return ListTile(
      subtitle: const Text('Paid: \$2.59', style: TextStyle(
        fontSize: 20,

      ),),
      onTap: () {
        GlobalMethods.navigateTo(context, ProductDetailsScreen.routeName);
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        height: size.height * 0.3,
        imageUrl:
            "https://img5.thuthuatphanmem.vn/uploads/2021/12/29/anh-nen-trai-sau-rieng-ngon-nhat_042722109.jpg",
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(text: 'Sầu riêng x 3', color: color, textSize: 18,isTitle: true,),
      trailing: TextWidget(text: "25/03/2024", color: color, textSize: 18),
    );
  }
}
