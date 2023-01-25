import 'package:flutter/material.dart';

class Navigators {
  static goTo(BuildContext context, {required page}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
