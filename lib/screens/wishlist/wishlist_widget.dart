import 'package:demo/inner_screens/product_details.dart';
import 'package:demo/models/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../services/utils.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';
import '../../widgets/heart_btn.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final getCurrProduct =
        productProvider.findProdById(wishlistModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: wishlistModel.productId);
          },
          child: Card(
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
                          getCurrProduct.imageUrl,
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
                            getCurrProduct.productCategoryName,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            getCurrProduct.title,
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
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    getCurrProduct.description,
                                    textAlign: TextAlign.left,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                addHorizontalSpace(Dimensions.widthSize * 0.4),
                                Expanded(
                                  flex: 0,
                                  child: HeartBTN(
                                    productId: getCurrProduct.id,
                                    isInWishlist: _isInWishlist,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "৳ ${getCurrProduct.price} / Monthly",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: CustomColor.primaryColor,
                              fontSize: Dimensions.mediumTextSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
