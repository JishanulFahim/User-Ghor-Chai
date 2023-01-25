// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/utils/custom_color.dart';
import 'package:demo/utils/dimensions.dart';
import 'package:demo/utils/size.dart';
import 'package:demo/widgets/appbar/custom_app_bar.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../consts/firebase_consts.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../providers/viewed_prod_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import '../widgets/heart_btn.dart';
import '../widgets/text_widget.dart';
import 'check_out.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  const ProductDetails({Key? key}) : super(key: key);

  //final String map;
  /*final String id, title, price, productCat, imageUrl, description,map,mapUrl;
  final bool isPiece, isOnSale;
  final double salePrice;*/

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _quantityTextController = TextEditingController(text: '1');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(productId);

    double usedPrice = getCurrProduct.price;

    //new added part
    String mapUrl = getCurrProduct.map;
    //new added part
    Future _mapurlLancher() async {
      if (!await (launch(mapUrl))) throw 'Could not find $mapUrl';
    }
//new added part

    String call = getCurrProduct.call;
    //new added

    double totalPrice = usedPrice * int.parse(_quantityTextController.text);

    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);

    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        viewedProdProvider.addProductToHistory(productId: productId);
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          '${getCurrProduct.productCategoryName} Details',
          bgClr: Theme.of(context).scaffoldBackgroundColor,
        ),
        bottomNavigationBar: Container(
          height: 80,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          decoration: BoxDecoration(
            color: CustomColor.primaryColor.withOpacity(0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          TextWidget(
                            text: 'TK${totalPrice.toStringAsFixed(2)}',
                            color: color,
                            textSize: 20,
                            isTitle: true,
                          ),
                          TextWidget(
                            text: getCurrProduct.isPiece
                                ? ""
                                : '/${_quantityTextController.text}Months',
                            color: color,
                            textSize: 16,
                            isTitle: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Material(
                color: CustomColor.orangeClr,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () async {
                    final User? user = authInstance.currentUser;
                    if (user == null) {
                      GlobalMethods.errorDialog(
                          subtitle: 'No user found, Please login first',
                          context: context);
                      return;
                    }

                    ///
                    //User? user = authInstance.currentUser;
                    final orderId = const Uuid().v4();

                    await FirebaseFirestore.instance
                        .collection('orders')
                        .doc(orderId)
                        .set({
                      'orderId': orderId,
                      'userId': user.uid,
                      'productId': "${user.uid}$orderId",
                      'price': 1971,
                      'totalPrice': 1971,
                      'quantity': int.parse(_quantityTextController.text),
                      'imageUrl': getCurrProduct.imageUrl,
                      'userName': user.displayName,
                      'orderDate': Timestamp.now(),
                    });
                    await cartProvider.clearOnlineCart();
                    cartProvider.clearLocalCart();

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CheckOutScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    //getCurrProduct.isPiece?Container():
                    child: TextWidget(
                      text: getCurrProduct.isPiece ? 'BUY' : 'GET RENT',
                      color: Colors.white,
                      textSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: mainMin,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  launch('tel:$call');
                });
              },
              child: Container(
                height: 37,
                width: 37,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
                child: const Icon(
                  Icons.call,
                  color: Colors.white,
                ),
              ),
            ),
            addVerticalSpace(Dimensions.heightSize),
            IconButton(
              padding: const EdgeInsets.all(5),
              icon: Image.asset(
                'assets/AppIcon/HomePage/map.png',
              ),
              onPressed: () {
                setState(() {
                  _mapurlLancher();
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.marginSize * 0.5,
            vertical: Dimensions.marginSize * 0.5,
          ),
          child: Column(
            mainAxisSize: mainMin,
            children: [
              Row(
                children: [
                  TextWidget(
                    text: getCurrProduct.productCategoryName,
                    color: color,
                    textSize: 18,
                    isTitle: true,
                  ),
                ],
              ),
              Flexible(
                child:
                    ListView(physics: const BouncingScrollPhysics(), children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextWidget(
                          text: getCurrProduct.title,
                          color: color.withOpacity(0.5),
                          textSize: 15,
                        ),
                      ),
                      addHorizontalSpace(Dimensions.widthSize * 5)
                    ],
                  ),
                  addVerticalSpace(Dimensions.heightSize),
                  Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius * 1.5),
                              child: FancyShimmerImage(
                                imageUrl: getCurrProduct.imageUrl,
                                boxFit: BoxFit.cover,
                                width: double.infinity,
                                height: 180,
                              ),
                            ),
                          ),
                          addHorizontalSpace(Dimensions.widthSize * 5)
                        ],
                      ),
                      Positioned(
                        bottom: 10,
                        right: 70,
                        child: Container(
                          padding: EdgeInsets.all(
                              Dimensions.defaultPaddingSize * 0.2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColor.whiteClr.withOpacity(0.2),
                          ),
                          child: HeartBTN(
                            productId: getCurrProduct.id,
                            isInWishlist: _isInWishlist,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: 'House Description',
                    color: color,
                    textSize: 18,
                    isTitle: true,
                  ),
                  Text(
                    getCurrProduct.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: color,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget quantityControl(
      {required Function fct, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: color,
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            )),
      ),
    );
  }
}
