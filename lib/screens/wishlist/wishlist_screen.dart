import 'package:demo/providers/wishlist_provider.dart';
import 'package:demo/widgets/empty_screen.dart';
import 'package:demo/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/button/back_button.dart';
import 'wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return wishlistItemsList.isEmpty
        ? const EmptyScreen(
            title: 'Your Wishlist Is Empty',
            subtitle: 'Explore more and shortlist some items',
            imagePath: 'assets/images/wishlist.png',
            buttonText: 'Add a wish',
          )
        : Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: const BackButtonWidget(),
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: TextWidget(
                  text: 'Wishlist (${wishlistItemsList.length})',
                  color: color,
                  isTitle: true,
                  textSize: 22,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      GlobalMethods.warningDialog(
                          title: 'Empty your wishlist?',
                          subtitle: 'Are you sure?',
                          fct: () async {
                            await wishlistProvider.clearOnlineWishlist();
                            wishlistProvider.clearLocalWishlist();
                          },
                          context: context);
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ),
                  ),
                ]),
            body: ListView.builder(
              itemCount: wishlistItemsList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: wishlistItemsList[index],
                  child: const WishlistWidget(),
                );
              },
            ),
          );
  }
}
