import 'dart:async';

import 'package:demo/providers/cart_provider.dart';
import 'package:demo/providers/wishlist_provider.dart';
import 'package:demo/screens/navigation/btm_bar.dart';
import 'package:demo/utils/custom_color.dart';
import 'package:demo/utils/dimensions.dart';
import 'package:demo/utils/size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'consts/contss.dart';
import 'consts/firebase_consts.dart';
import 'providers/products_provider.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  List<String> images = Constss.offerImages;
//////
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  //////
  @override
  void initState() {
    ////
    //getConnectivity();/////
    images.shuffle();
    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final wishlistProvider =
          Provider.of<WishlistProvider>(context, listen: false);
      final User? user = authInstance.currentUser;
      if (user == null) {
        await productsProvider.fetchProducts();
        cartProvider.clearLocalCart();
        wishlistProvider.clearLocalWishlist();
      } else {
        await productsProvider.fetchProducts();
        await cartProvider.fetchCart();
        await wishlistProvider.fetchWishlist();
      }

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => const BottomBarScreen(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: mainCenter,
        children: [
          Image.asset(
            'assets/AppIcon/luncher_icon.png',
            fit: BoxFit.cover,
            height: 100,
          ),
          addVerticalSpace(Dimensions.heightSize*5),
          const SpinKitFadingFour(
            color: CustomColor.primaryColor,
          )
        ],
      ),
    );
  }
}
