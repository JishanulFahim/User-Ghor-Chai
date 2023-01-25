import 'package:demo/models/products_model.dart';
import 'package:demo/providers/products_provider.dart';
import 'package:demo/utils/dimensions.dart';
import 'package:demo/utils/size.dart';
import 'package:demo/widgets/appbar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';
import '../utils/custom_color.dart';
import '../widgets/empty_products_widget.dart';
import '../widgets/feed_items.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/CategoryScreenState";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> listProdcutSearch = [];
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final catName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productByCat = productsProvider.findByCategory(catName);
    return Scaffold(
      appBar: CustomAppBar(
        catName,
        centerTitle: true,
      ),
      body: productByCat.isEmpty
          ? const EmptyProdWidget(
              text: 'No houses belong to this category',
            )
          : SingleChildScrollView(
              child: Column(children: [
                addVerticalSpace(Dimensions.heightSize),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: TextField(
                      focusNode: _searchTextFocusNode,
                      controller: _searchTextController,
                      onChanged: (valuee) {
                        setState(() {
                          listProdcutSearch =
                              productsProvider.searchQuery(valuee);
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: CustomColor.primaryColor,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: CustomColor.primaryColor,
                            width: 1,
                          ),
                        ),
                        hintText: "Search by Location",
                        prefixIcon: const Icon(Icons.search),
                        suffix: IconButton(
                          onPressed: () {
                            _searchTextController!.clear();
                            _searchTextFocusNode.unfocus();
                          },
                          icon: Icon(
                            Icons.close,
                            color: _searchTextFocusNode.hasFocus
                                ? Colors.red
                                : color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _searchTextController!.text.isNotEmpty &&
                        listProdcutSearch.isEmpty
                    ? const EmptyProdWidget(
                        text: 'No houses found, please try another keyword')
                    : ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: List.generate(
                            _searchTextController!.text.isNotEmpty
                                ? listProdcutSearch.length
                                : productByCat.length, (index) {
                          return ChangeNotifierProvider.value(
                            value: _searchTextController!.text.isNotEmpty
                                ? listProdcutSearch[index]
                                : productByCat[index],
                            child: const FeedsWidget(),
                          );
                        }),
                      ),
              ]),
            ),
    );
  }
}
