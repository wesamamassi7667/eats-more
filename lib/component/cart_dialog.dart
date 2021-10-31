import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/helper/app_localization.dart';

import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class CartDialog extends StatelessWidget {

  final List<Addons> addons;

  const CartDialog({Key key, this.addons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(width: 1.0, color: grey4),
      ),
      child:Container(
                padding: EdgeInsetsDirectional.only(bottom: 33,top: 28,start: 16,end: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalization.of(context).translate("addition_to_order"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: green,
                      ),
                    ),
                    SizedBox(height: 18,),
                    Flexible(
                      child: ListView.separated(
                          itemCount: addons.length,
                          shrinkWrap: true,
                          separatorBuilder: (context,index){
                            return SizedBox(height: 13,);
                          },
                          itemBuilder: (context,index){
                            Addons addon=addons[index];
                            return SecondContainerComponent(
                              startP: 14,bottomP:12,topP: 12,
                              child: Row(
                                children: [
                                  Container(
                                    width:55,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: AssetImage('assets/photos/slider.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(width: 1.0, color: const Color(0xfff5f6ff)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Flexible(
                                    child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${addon.addon_name}' ,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 1,),
                                        Text(
                                          '${addon.addon_price} '+AppLocalization.of(context).translate("sr"),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: green,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),


    );
  }


}


