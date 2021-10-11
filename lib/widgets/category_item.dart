

import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';
import '../component/cached_network_image_component.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key key, this.index, this.selectedIndex, this.restaurant, this.tap, this.type}) : super(key: key);
  final int index;
  final int  selectedIndex;
  final Restaurant restaurant;
  final String type;
  final Function tap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: EdgeInsetsDirectional.only(
          start: index == 0 ? 16 : 18,
          end: index == restaurant.menu_categories.length - 1 ? 16 : 0,
          bottom: 10
        ),
        padding: EdgeInsetsDirectional.only(
            top: 10, start: 5, end: 5),
        height: 94,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              index ==selectedIndex ? 5 : 0),
          color: index == selectedIndex
              ? primaryIconColor
              : Colors.transparent,
          boxShadow: [
            BoxShadow(
                color:index == selectedIndex
                    ? black.withOpacity(0.16)
                    : Colors.transparent,
                blurRadius: 6,
                offset: Offset(0, 3)),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.center,
          children: [
            type.contains('text')?SizedBox.shrink():CachedNetworkImageComponent(
              url: restaurant.menu_categories[index]
                  .category_image,
              fit: BoxFit.fitWidth,
              width: 60,height: 60,
            ),
            SizedBox(
              height: type.contains('text')?0:3,
            ),
            Text(
              restaurant.menu_categories[index].category_name,
              style: TextStyle(
                fontFamily: 'DIN Next LT Arabic',
                fontSize: 16,
                color: index == selectedIndex
                    ? background.withOpacity(0.98)
                    : black1.withOpacity(0.98),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}



