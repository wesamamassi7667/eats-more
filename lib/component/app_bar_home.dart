
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final GlobalKey<ScaffoldState> key1;
  const AppBarWidget({
    this.key1,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RestaurantsApiModel>(
      builder:(context,child,model) =>AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform(
              transform:model.language==0||UtilSharedPreferences.getInt('lang')==0? Matrix4.rotationY(math.pi): Matrix4.rotationY(0),
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                    key1.currentState.openDrawer();
                  },
                  icon: SvgPicture.asset('assets/images/drawer.svg'),),
            ),
            IconButton(
              onPressed: () {},
              color: primaryIconColor,
              icon: Icon(
                  Icons.search,
                  size: 20
              ),
            ),
            Spacer(),
            Text(
                'المدينة',
                style: TextStyle(
                  fontFamily: 'DIN Next LT Arabic',
                  fontSize: 16,
                  color: primaryIconColor,
                  fontWeight: FontWeight.w300,
                ),
              ),

          ],
        ),
        actions: [
          Container(
            width: 30,
            height: 30,
            child: Stack(
              alignment: AlignmentDirectional(0.0,0.1),
              children: [
                Icon(
                  Icons.notifications_none,
                  color: primaryIconColor,
                ),
                Container(
                  width: 30,
                  height: 30,
                  alignment: AlignmentDirectional.topStart,
                  margin: EdgeInsetsDirectional.only(top: 5,start: 2),
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffE7487D),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Center(
                        child: Text(
                          '0',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15,),

        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}