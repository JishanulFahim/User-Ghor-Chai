import 'package:demo/services/utils.dart';
import 'package:demo/utils/dimensions.dart';
import 'package:demo/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details.dart';
import '../models/products_model.dart';
import '../utils/custom_color.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final productModel = Provider.of<ProductModel>(context);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: productModel.id);
        // GlobalMethods.navigateTo(
        //     ctx: context, routeName: ProductDetails.routeName);
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
                      productModel.imageUrl,
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
                        productModel.productCategoryName,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        productModel.title,
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
                          productModel.description,
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
                        "৳ ${productModel.price} / Monthly",
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
      ),
    );
  }
}
