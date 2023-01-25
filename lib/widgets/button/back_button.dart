
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/assets.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';

class BackButtonWidget extends StatelessWidget {
  final bool isWhiteBackButton;
  const BackButtonWidget({Key? key, this.isWhiteBackButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.marginSize),
      child: GestureDetector(
          onTap: () {
           Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: SvgPicture.asset(
              Assets.backward,
              color: isWhiteBackButton == true ? CustomColor.whiteClr : CustomColor.primaryColor,
            ),
          )),
    );
  }
}
