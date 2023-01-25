import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/utils.dart';
import 'package:demo/utils/custom_color.dart';
import 'package:demo/utils/dimensions.dart';
import 'package:demo/utils/size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../consts/firebase_consts.dart';
import '../../models/products_model.dart';
import '../../providers/products_provider.dart';
import '../../services/global_methods.dart';
import '../../widgets/button/primary_button.dart';

class AllProductList extends StatelessWidget {
  const AllProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authEmail = FirebaseAuth.instance.currentUser?.email;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsByUser =
        productProviders.getUserProducts(authEmail ?? '');

    return Scaffold(
      body: productsByUser.isEmpty
          ? Center(
              child: Text(
              'There is no Ads ${authInstance.currentUser != null ? '.' : "in Guest Mode."}',
              style: TextStyle(
                fontSize: Dimensions.mediumTextSize,
                fontWeight: FontWeight.w500,
              ),
            ))
          : ListView.builder(
              itemCount: productsByUser.length,
              itemBuilder: (_, index) {
                var data = productsByUser[index];
                return _myAdsCardWidget(context, data);
              }),
    );
  }

  Widget _myAdsCardWidget(BuildContext context, data) {
    final Color color = Utils(context).color;
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSize * 0.4,
        vertical: Dimensions.marginSize * 0.4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
      ),
      child: Theme(
        data: ThemeData(dividerColor: CustomColor.transparent),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            vertical: Dimensions.marginSize * 0.4,
            horizontal: 0,
          ),
          title: Row(
            crossAxisAlignment: crossStart,
            children: [
              addHorizontalSpace(Dimensions.widthSize),
              Expanded(
                flex: 0,
                child: ClipRRect(
                  child: Image.network(
                    data.imageUrl,
                    fit: BoxFit.cover,
                    height: 140,
                    width: 115,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                ),
              ),
              addHorizontalSpace(Dimensions.widthSize * 1.2),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    Text(
                      data.productCategoryName,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      data.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: color.withOpacity(0.6),
                        fontSize: Dimensions.mediumTextSize * 0.9,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(right: 60),
                      child: Text(
                        data.description,
                        textAlign: TextAlign.left,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "৳ ${data.price} / Monthly",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: CustomColor.primaryColor,
                        fontSize: Dimensions.mediumTextSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                      Padding(
                      padding: EdgeInsets.only(
                        right: Dimensions.marginSize * 3.5,
                        top: 5,
                      ),
                      child: PrimaryButton(
                          buttonColor: CustomColor.redClr,
                          height: 25,
                          title: 'Remove',
                          onPressed: () {
                            GlobalMethods.warningDialog(
                                title: 'Delete?',
                                subtitle: 'Press okay to confirm',
                                fct: () async {
                                  await FirebaseFirestore.instance
                                      .collection('products')
                                      .doc(data.id)
                                      .delete();
                                  final productsProvider =
                                      Provider.of<ProductsProvider>(context,
                                          listen: false);
                                  productsProvider.fetchProducts();
                                  await Fluttertoast.showToast(
                                    msg: "Product has been deleted",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                  );
                                  while (Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                  }
                                },
                                context: context);
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
