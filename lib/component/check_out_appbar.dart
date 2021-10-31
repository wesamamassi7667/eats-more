import 'dart:ui';

import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/image_card.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CheckOutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CheckOutAppBar({Key key, this.tapClose}) : super(key: key);
   final double height=104;
   final Function tapClose;
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RestaurantsApiModel>(
      builder:(context,child,model)=>  Container(
          padding: EdgeInsetsDirectional.only(top: 53,start: 16,end: 16,bottom: 22),
          decoration: BoxDecoration(
            color: primaryIconColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: tapClose,
                child: Container(
                  height: 34,
                  width: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: const Color(0x33ffffff),
                  ),
                  child: Icon(
                    Icons.close,
                    color: background ,
                  ),
                ),
              ),
              Text(
                AppLocalization.of(context).translate('payment'),
                style: TextStyle(
                  fontSize: 20,
                  color: background,
                  fontWeight: FontWeight.w500
                ),
              ),
              ImageCard(
                url: model.loggedUser.avatar??"",
                width: 30,
                height: 30,
              ),
            ],
          ),
        ),

    );
  }
}
