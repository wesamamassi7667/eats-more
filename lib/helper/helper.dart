

import 'dart:ui';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/model/cart_response.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/model/setting_response.dart';
import 'package:eat_more_app/screens/delivery_ways_screen.dart';
import 'package:eat_more_app/screens/item_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/product_sheet.dart';
import 'app_localization.dart';

class Helper {
  static Setting setting;
  static String fcmToken;

  static Color convertColor(String color) {
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      // print(Color(int.parse("0xFF"+color)));
      return Color(int.parse("0xFF" + color));
    } else if (color.length == 8) {
      // print(Color(int.parse("0x"+color)));
      return Color(int.parse("0x" + color));
    }
  }

  static Future<AddCart> showProductSheet(BuildContext context, int id,
      AnimationController controller1, int vendorId, String logo,
      String name) async {
    AddCart addCart = await showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        builder: (context) {
          return DraggableScrollableSheet(
              expand: false,
              minChildSize: 0.3,
              initialChildSize: 0.53,
              maxChildSize: 0.8,
              builder: (context, controller) {
                return SingleChildScrollView(
                    controller: controller,
                    child: Container(
                        child: ProductSheet(
                            id: id,
                            idVendor: vendorId,
                            controller: controller1,
                            logo: logo,
                            name: name
                        )));
              });
        });
    return addCart;
  }

  static void showAlertDialog(BuildContext context,String title,String title1, Function tap) {
    showDialog(
        context: context,
        builder: (context) =>
            CupertinoAlertDialog(
              // title: Text("Log out?"),
              content: Text(
                  title),
              actions: <Widget>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalization.of(context).translate("cancel"))
                ),
                CupertinoDialogAction(
                    textStyle: TextStyle(color: Colors.red),
                    isDefaultAction: true,
                    onPressed: tap,
                    child: Text(title1)
                ),
              ],
            ));
  }

  static void openApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  static void openTarget(SliderImage item,BuildContext context) {
    if(item.target=='link')
      openApp(item.link);
    else if(item.target=='product')
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>ItemDetailsScreen(id: int.parse(item.product_id),
          // logo:item.product.vendor.logo,
          vendorId:item.product.vendor_id
      )
      )
      );
    else if(item.target=='image_only')
      return;
    else
      Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryMethodsScreen(
        id:int.parse(item.vendor),
      )
      )
      );
  }

}


class AddCart{
  List<ProductCart> carts;
  double total;
  AddCart(this.carts, this.total);
}