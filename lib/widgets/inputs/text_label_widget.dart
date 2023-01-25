import 'package:flutter/material.dart';

import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';

class CustomLabelWidget extends StatelessWidget {
  final String text;
  const CustomLabelWidget(
      {Key? key, required this.text, this.color = Colors.white})
      : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.heightSize*0.7),
      child: SizedBox(
        width: double.infinity,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: CustomColor.midGrayColor,
              fontSize: Dimensions.defaultTextSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}