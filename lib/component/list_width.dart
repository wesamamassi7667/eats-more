import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/component/vendor_logo.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
import 'ads_image.dart';

class ListMealWidth extends StatelessWidget {
  final SpecSlider item;
  final AnimationController controller;
  final int index;


  const ListMealWidth({Key key, this.item, this.controller, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Stack(
       alignment: Alignment.topCenter,

       children: [
         Container(
           margin: EdgeInsetsDirectional.only(
             start: index == 0 ? 23 : 9.4,
             end: index == item.product.length - 1 ? 14 : 0,
             bottom: 23,
             top: 20,
           ),
           width: MediaQuery.of(context).size.width * 0.80888,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(12.0),
             color: background,
             boxShadow: [
               BoxShadow(
                 color: blue.withOpacity(0.08),
                 offset: Offset(0, 4),
                 blurRadius: 16,
               ),
             ],
           ),
           child: Stack(
             children: [
               Positioned(
                 top: 0.0,
                 left: 0.0,
                 right: 0.0,
                 child: Container(
                   height: 142,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15.0),
                     image: DecorationImage(
                       image: Helper.buildCachedNetworkImageProvider(item.product[index].image),
                       fit: BoxFit.fitWidth,
                     ),
                   ),
                 ),
               ),
               PositionedDirectional(
                 end: 0,
                 top: 100,
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadiusDirectional.only(
                       topStart: Radius.circular(8.0),
                       bottomStart: Radius.circular(8.0),
                     ),
                     color: background,
                   ),
                   child: Padding(
                     padding: const EdgeInsetsDirectional.only(
                         bottom: 7, start: 4, end: 3, top: 2),
                     child: Text(
                       item.product[index].meal_price + 'SAR',
                       style: TextStyle(
                         fontFamily: 'DIN Next LT Arabic',
                         fontSize: 12,
                         color: orange,
                       ),
                     ),
                   ),
                 ),
               ),
               PositionedDirectional(
                 start: 15.6,
                 end: 0,
                 top: 130,
                 child: Row(
                   children: [
                     Text(
                       item.product[index].product_name,
                       style: TextStyle(
                         fontFamily: 'DIN Next LT Arabic',
                         fontSize: 18,
                         color: black3,
                       ),
                     ),
                     Spacer(),
                     CupertinoButton(
                       onPressed: () {
                         Helper.showProductSheet(
                             context,
                             item.product[index].product_id,
                             controller,
                             item.product[index].vendor_id,
                             item.product[index].vendor.logo,
                             item.product[index].vendor.rest_name);
                       },
                       child: Icon(
                         Icons.add_box_rounded,
                         size: 30,
                         color: primaryIconColor,
                       ),
                     ),
                   ],
                 ),
               ),
               PositionedDirectional(
                 top: 185,
                 start: 15.6,
                 end: 12.3,
                 bottom: 10,
                 child: Text(
                   item.product[index].description,
                   style: TextStyle(
                     fontFamily: 'DIN Next LT Arabic',
                     fontSize: 12,
                     color: black1,
                     fontWeight: FontWeight.w300,
                   ),
                   overflow: TextOverflow.ellipsis,
                 ),
               )
             ],
           ),
         ),
         VendorLogo(url: item.product[index].vendor.logo,)
       ],
     );
  }
}
