import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:eat_more_app/screens/delivery_ways_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class VendorWidget extends StatelessWidget {
  const VendorWidget({
    Key key,
    @required this.list, this.index,
  }) : super(key: key);

  final List<Restaurant> list;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print(list[index].vendor_id);
        if(UtilSharedPreferences.getDouble('total')!=null)
          UtilSharedPreferences.getDouble('total');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryMethodsScreen(
            id:list[index].vendor_id
        )));
      },
      child: Container(
        height: 122,
        width: list.length==2?MediaQuery.of(context).size.width*0.4:90,
        padding: EdgeInsetsDirectional.only(
          top: 16,
          bottom: 17,
        ),
        margin: EdgeInsetsDirectional.only(
          start: index == 0 ? 23 : 8,
          end: index == list.length-1 ? 14 : 0,
          bottom: 23,
          top: 11,
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: grey1.withOpacity(0.16),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(list[index].vendor_image),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
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
              height: 3,
            ),
            Text(
              list[index].vendor_name,
              style: TextStyle(
                fontFamily: 'DIN Next LT Arabic',
                fontSize: 16,
                color: black2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}