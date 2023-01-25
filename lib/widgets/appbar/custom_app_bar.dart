import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dark_theme_provider.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';
import '../button/back_button.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
 
  @override
  final Size preferredSize;

  final String title;
  final bool centerTitle;
  final bool alwaysShowBackButton;
  final bool isWhiteBackButton;
  final double? elevation;
  final Color? bgClr;
  final Color? titleClr;
  final List<Widget>? actions;

  CustomAppBar(
    this.title, {
    Key? key,
    this.centerTitle = false,
    this.isWhiteBackButton = false,
    this.elevation = 1.8,
    this.bgClr = Colors.white,
    this.titleClr = CustomColor.primaryTextColor,
    this.alwaysShowBackButton = true,
    this.actions,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
       final themeState = Provider.of<DarkThemeProvider>(context);

    bool isDark = themeState.getDarkTheme;
    return AppBar(
      leading: Visibility(
        visible: alwaysShowBackButton == true ? true : false,
        child: BackButtonWidget(isWhiteBackButton: isWhiteBackButton),
      ),
      title: Text(
        title,
        style: TextStyle(
          color:isDark?CustomColor.whiteClr:  titleClr,
          fontSize: Dimensions.largeTextSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor:isDark?  Theme.of(context).scaffoldBackgroundColor:  bgClr,
      automaticallyImplyLeading: false,
      actions: actions,
    );
  }
}
