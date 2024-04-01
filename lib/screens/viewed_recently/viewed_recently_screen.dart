import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/screens/viewed_recently/viewed_recently_widget.dart';
import 'package:shopping_app_flutter/widgets/empty_screen.dart';
import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  const ViewedRecentlyScreen({super.key});

  static const routeName = '/ViewedRecentlyScreen';

  @override
  State<ViewedRecentlyScreen> createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  @override
  Widget build(BuildContext context) {
    /*final themeState = Provider.of<DarkThemeProvider>(context);
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;*/
    final Color color = Utils(context).getColor;
    bool isEmpty = false;
    return isEmpty
        ? const EmptyScreen(
            imagePath: "images/history.png",
            title: "Whoops!",
            subtitle: "Your history is Empty!",
            buttonText: "Shop now")
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                        title: 'Empty your history?',
                        subtitle: 'Are you sure?',
                        fct: () {},
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                )
              ],
              leading: const BackWidget(),
              automaticallyImplyLeading: false,
              elevation: 0,
              centerTitle: true,
              title: TextWidget(
                text: 'History',
                color: color,
                textSize: 24.0,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: ChangeNotifierProvider.value(
                        value: null, child: const ViewedRecentlyWidget()),
                  );
                }),
          );
  }
}
