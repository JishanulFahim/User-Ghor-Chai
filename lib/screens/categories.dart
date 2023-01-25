// ignore_for_file: must_be_immutable

import 'package:demo/utils/dimensions.dart';
import 'package:demo/widgets/categories_widget.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({Key? key}) : super(key: key);

 final List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/AppIcon/Search/Categories/To-Let.png',
      'catText': 'To-Let',
    },
    {
      'imgPath': 'assets/AppIcon/Search/Categories/Flat.png',
      'catText': 'Flat',
    },
    {
      'imgPath': 'assets/AppIcon/Search/Categories/Plot.png',
      'catText': 'Plot',
    },
    {
      'imgPath': 'assets/AppIcon/Search/Categories/Duplex.png',
      'catText': 'Duplex',
    },
    {
      'imgPath': 'assets/AppIcon/Search/Categories/Hostel.png',
      'catText': 'Hostel',
    },
     {
      'imgPath': 'assets/AppIcon/Search/Categories/Hotel.png',
      'catText': 'Hotel',
    },
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     
        body: Container(
          margin: EdgeInsets.only(top: Dimensions.heightSize),
          child: Padding(
            padding:  EdgeInsets.all(Dimensions.marginSize*0.4),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 500 / 200,
              crossAxisSpacing: 15, // Vertical spacing
              mainAxisSpacing: 15, // Horizontal spacing 
              children: List.generate(6, (index) {
                return CategoriesWidget(
                  catText: catInfo[index]['catText'],
                  imgPath: catInfo[index]['imgPath'],
                  passedColor: gridColors[index],
                );
              }),
            ),
          ),
        ));
  }
}
