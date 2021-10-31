
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/widgets/vendor_widget.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:eat_more_app/screens/delivery_ways_screen.dart';
import 'package:eat_more_app/screens/resturant_list_screen.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class RestaurantsList extends StatelessWidget {
  final List<Restaurant> list;

  const RestaurantsList({
    Key key, this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 23),
          child: Row(
            children: [
              Text(
                AppLocalization.of(context).translate("restaurants"),
                style: TextStyle(
                  fontSize: 21,
                  color: black1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantsListScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 14,start: 14),
                    child: Text(
                      AppLocalization.of(context).translate("more"),
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryIconColor,
                      ),
                    ),
                  ),

              ),
            ],
          ),
        ),
        Container(
          height: 155,
          child: list.length<=3?  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(list.length, (index) {
              return VendorWidget(list: list,index:index);
            }
            )
          ):ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return VendorWidget(list: list,index:index);
              }),
        ),
      ],
    );
  }
}



