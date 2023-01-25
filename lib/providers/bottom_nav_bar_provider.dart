import 'package:flutter/material.dart';

import '../screens/PostScreen/all_product_screen.dart';
import '../screens/categories.dart';
import '../screens/home_screen.dart';
import '../screens/user.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(var index) {
    _currentIndex = index;
    notifyListeners();
  }

  final List page = [
    const HomeScreen(),
    CategoriesScreen(),
    const AllProductList(),
    const UserScreen(),
  ];
}
