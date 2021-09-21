
 import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/text_button_component.dart';
import 'package:eat_more_app/component/vendor_logo.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/screens/delivery_ways_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';
class TopSheet extends StatelessWidget {
  final Function pressContinuo;
  final Function pressPay;

  const TopSheet({Key key, this.pressContinuo, this.pressPay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RestaurantsApiModel>(
      builder:(context,child,model)=> Material(
          // clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            side: BorderSide(color: grey8, width: 1),
          ),

          child: Container(
            padding: EdgeInsetsDirectional.only(top: 45,start: 20,end: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VendorLogo(
                      url: model.logo,
                        border: Border.all(
                          color: black,
                          width: 0.4,
                        )
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.name??"",
                      style: TextStyle(
                          fontFamily:"DIN Next LT Arabic",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Icon(
                            Icons.check_circle,
                            color: Color(0xff11DC75),
                            size: 20,
                          ),

                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 6),
                          child: Text(
                              AppLocalization.of(context).translate("added_successfully"),
                            style: TextStyle(
                                fontWeight:FontWeight.w400, fontSize:14,color: black6, fontFamily:'DIN Next LT Arabic'
                            )
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 2),
                      child: Text(
                          AppLocalization.of(context).translate("cart_total"),
                        style: TextStyle(fontWeight:FontWeight.w500, fontSize:12,
                            color:grey7, fontFamily:"DIN Next LT Arabic")

                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 2),
                  child: Text(
                      model.total+ AppLocalization.of(context).translate("sr"),
                      style: TextStyle(fontWeight:FontWeight.bold, fontSize:12,
                         color: red1, fontFamily:"DIN Next LT Arabic")
                          ),
                ),
                SizedBox(height: 3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     TextButtonComponent(
                        press:() =>Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          DeliveryMethodsScreen(
                              id:model.id
                          ))
                        ),
                        text: AppLocalization.of(context).translate("payment"),
                       backgroundColor: primaryIconColor,
                       primary: background,
                      ),
                    TextButtonComponent(
                          press: pressContinuo,
                          text: AppLocalization.of(context).translate("continue_shopping"),
                          widthBorder: 1.0,
                          borderColor: grey8,

                      ),
                  ],
                )
              ],

            ),
          )

      ),
    );
  }
}


