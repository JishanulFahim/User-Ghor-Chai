import 'package:demo/widgets/appbar/custom_app_bar.dart';
import 'package:demo/widgets/on_sale_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../providers/products_provider.dart';
import '../widgets/empty_products_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;

    return Scaffold(
      appBar: CustomAppBar('Houses on sale'),
      body: productsOnSale.isEmpty
          ? const EmptyProdWidget(
              text: 'No houses on sale yet!,\nStay tuned',
            )
          : ListView(
              padding: EdgeInsets.zero,
              children: List.generate(productsOnSale.length, (index) {
                return ChangeNotifierProvider.value(
                  value: productsOnSale[index],
                  child: const OnSaleWidget(),
                );
              }),
            ),
    );
  }
}
