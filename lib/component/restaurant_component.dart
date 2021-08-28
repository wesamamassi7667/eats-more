
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:flutter/material.dart';

import '../color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestaurantComponent extends StatelessWidget {
  final int index;
  final List<Restaurant> vendors;
  const RestaurantComponent({Key key, this.index, this.vendors}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsetsDirectional.only(
            top: index == 0 ? 20 : 13,
            bottom: index==vendors.length-1?12:0,
            start: 16, end: 16),
        padding: EdgeInsetsDirectional.only(
            top: 7, start: 8, end: 8, bottom:9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: background,
          boxShadow: [
            BoxShadow(
              color: grey1.withOpacity(0.16),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.elliptical(9999.0, 9999.0)),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    vendors[index].vendor_image
                  ),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.16),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 12.3,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    vendors[index].vendor_name,
                    style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 16,
                        color: black2),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    vendors[index].vendor_desc,
                    // maxLines: 3,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'DIN Next LT Arabic',
                      fontSize: 11,
                      color: black3.withOpacity(0.88),
                      fontWeight: FontWeight.w300,
                    ),

                  ),
                  SizedBox(height: 4,),

                  Row(
                    children: [
                      SvgPicture.asset(
                          'assets/images/bicycle.svg',color: black,),
                      SizedBox(width: 7,),
                      Text(
                        "${vendors[index].delivery_cost} "+AppLocalization.of(context).translate('sr'),
                        style: TextStyle(
                          fontFamily: 'DIN Next LT Arabic',
                          fontSize: 12,
                          color: primaryIconColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        height: 10,
                        child: VerticalDivider(
                          color: grey4,
                          thickness: 0.2,
                        ),
                      ),
                      SizedBox(
                        width:9.5,
                      ),
                      SvgPicture.asset(
                          'assets/images/location.svg',color: black,),
                      SizedBox(width: 7,),
                      Text(
                        '1.5k',
                        style: TextStyle(
                          fontFamily: 'DIN Next LT Arabic',
                          fontSize: 12,
                          color: primaryIconColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}
