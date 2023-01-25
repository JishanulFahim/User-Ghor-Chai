import 'package:card_swiper/card_swiper.dart';
import 'package:demo/inner_screens/feeds_screen.dart';
import 'package:demo/inner_screens/on_sale_screen.dart';
import 'package:demo/services/utils.dart';
import 'package:demo/utils/custom_color.dart';
import 'package:demo/utils/dimensions.dart';
import 'package:demo/utils/size.dart';
import 'package:demo/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../consts/contss.dart';
import '../models/products_model.dart';
import '../providers/products_provider.dart';
import '../services/global_methods.dart';
import '../widgets/feed_items.dart';
import '../widgets/on_sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = Utils(context).color;
    Size size = utils.getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: mainMin,
          children: [
            /// slider
            SizedBox(
              height: size.height * 0.25,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Constss.offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: Constss.offerImages.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: CustomColor.primaryColor,
                  ),
                ),
                // control: const SwiperControl(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 12,
            ),

            const Divider(
              thickness: 2,
            ),

            ///view all button
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextWidget(
                        text: 'top WANTED'.toUpperCase(),
                        color: Colors.red,
                        textSize: 22,
                        isTitle: true,
                      ),
                      addHorizontalSpace(Dimensions.widthSize),
                      const Icon(
                        IconlyLight.image,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context, routeName: OnSaleScreen.routeName);
                      },
                      child: TextWidget(
                        text: 'View all',
                        maxLines: 1,
                        color: CustomColor.primaryColor,
                        textSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),

            /// first row .. home view
            Flexible(
              child: SizedBox(
                height: null,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        productsOnSale.length < 10 ? productsOnSale.length : 10,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                        value: productsOnSale[index],
                        child: const OnSaleWidget(),
                      );
                    }),
              ),
            ),

            const Divider(
              thickness: 2,
            ),

            ///browse all button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Homes and Hotels',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  // const Spacer(),
                  TextButton(
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: FeedsScreen.routeName);
                    },
                    child: TextWidget(
                      text: 'Browse all',
                      maxLines: 1,
                      color: CustomColor.primaryColor,
                      textSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            ///grid view product view
            ListView(
              shrinkWrap: true,
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: List.generate(
                  allProducts.length < 10
                      ? allProducts.length // length 3
                      : 10, (index) {
                return ChangeNotifierProvider.value(
                  value: allProducts[index],
                  child: const FeedsWidget(),
                );
              }),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
