import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_svg/svg.dart';

import '../../utils/assets.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';
import '../providers/dark_theme_provider.dart';

buildBottomNavigationMenu(context, bottomNavBarController) {
  final themeState = Provider.of<DarkThemeProvider>(context);

  bool isDark = themeState.getDarkTheme;
  return Container(
    height: 63,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: CustomColor.transparent,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensions.radius * 2.5),
        topRight: Radius.circular(Dimensions.radius * 2.5),
      ),
      // boxShadow: const [  //todo you want to add 'Box Shadow?
      //   BoxShadow(
      //     color: Color.fromARGB(26, 53, 52, 52),
      //     blurRadius: 1.0,
      //     spreadRadius: 1.0,
      //   )
      // ],
    ),
    child: BottomAppBar(
      elevation: 0,
      shape: const CircularNotchedRectangle(),
      notchMargin: 7,
      color: isDark ? const Color(0xFF0a0d2c) : CustomColor.primaryColor,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            bottomItemWidget(
                Assets.home, 'Home', bottomNavBarController, 0, isDark),
            bottomItemWidget(
                Assets.search, 'Search', bottomNavBarController, 1, isDark),
            addHorizontalSpace(Dimensions.widthSize),
            bottomItemWidget(
                Assets.myAds, 'My Ads', bottomNavBarController, 2, isDark),
            bottomItemWidget(
                Assets.profile, 'PROFILE', bottomNavBarController, 3, isDark),
          ],
        ),
      ),
    ),
  );
}

bottomItemWidget(var icon, label, bottomNavBarController, page, isDark) {
  return InkWell(
    onTap: () {
      bottomNavBarController.currentIndex = page;
    },
    child: Column(
      children: [
        Image.asset(
          icon,
          scale: bottomNavBarController.currentIndex == page ? 22 : 23,
          color: isDark
              ? bottomNavBarController.currentIndex == page
                  ? CustomColor.whiteClr
                  : CustomColor.whiteClr.withOpacity(0.30)
              : bottomNavBarController.currentIndex == page
                  ? CustomColor.whiteClr
                  : CustomColor.blackClr.withOpacity(0.8),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.smallestTextSize * 1.1,
            color: isDark
              ? bottomNavBarController.currentIndex == page
                  ? CustomColor.whiteClr
                  : CustomColor.whiteClr.withOpacity(0.30)
              : bottomNavBarController.currentIndex == page
                  ? CustomColor.whiteClr
                  : CustomColor.blackClr.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}
