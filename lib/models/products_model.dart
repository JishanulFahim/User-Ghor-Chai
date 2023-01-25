import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier{
  final String id, title, description,map,call, imageUrl, productCategoryName, authEmail;
  final dynamic price, salePrice;
  final bool isOnSale, isPiece;

  ProductModel(
      {required this.id,
      required this.title,
      required this.authEmail,
      required this.description,
        required this.map,
        required this.call,
      required this.imageUrl,
      required this.productCategoryName,
      required this.price,
      required this.salePrice,
      required this.isOnSale,
      required this.isPiece});
}
