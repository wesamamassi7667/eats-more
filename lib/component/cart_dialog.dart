import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/cart_button.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/branch_response.dart';
import 'package:eat_more_app/model/cart_response.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/screens/check_out_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';
class CartDialog extends StatelessWidget {

  final int id;
  final Branch branch;
  final int idWay;
  final double deliveryCost;
  final int vat;
  final String time;
  final double total;
  final List<ProductCart> carts;
  final String address;
  final double minimum;
  final String lat,lng;

  const CartDialog({Key key, this.id, this.branch, this.idWay, this.deliveryCost, this.vat, this.time, this.total, this.carts, this.address, this.minimum, this.lat, this.lng}) : super(key: key);


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
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 18,
                        color: green,
                      ),
                    ),
                    SizedBox(height: 18,),
                    Flexible(
                      child: ListView.separated(
                          itemCount: 2,
                          shrinkWrap: true,
                          separatorBuilder: (context,index){
                            return SizedBox(height: 13,);
                          },
                          itemBuilder: (context,index){
                            return Container(
                              padding: EdgeInsetsDirectional.only(start: 14,bottom: 12,top: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: background,
                                boxShadow: [
                                  BoxShadow(
                                    color: grey5.withOpacity(0.16),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'vvvff' ,
                                          style: TextStyle(
                                            fontFamily: 'DIN Next LT Arabic',
                                            fontSize: 18,
                                            color:black2,
                                          ),
                                        ),
                                        SizedBox(height: 1,),
                                        Text(
                                          '20'+AppLocalization.of(context).translate("sr"),
                                          style: TextStyle(
                                            fontFamily: 'DIN Next LT Arabic',
                                            fontSize: 14,
                                            color: green,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  CupertinoButton(
                                    onPressed: (){},
                                    child: Icon(
                                      Icons.add_box_rounded,
                                      size: 20,
                                      color: primaryIconColor,
                                    ),
                                  ),

                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: CartButton(
                        tap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutScreen()));
                        },
                        text: AppLocalization.of(context).translate("add_cart"),
                        color: primaryIconColor,
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutScreen(id:id,branch:branch,
                          idWay:idWay,deliveryCost:deliveryCost,vat:vat,time:time,carts:carts,
                          total:total,address:address,minimum:minimum,lat:lat,lng:lng)));

                      },
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text:AppLocalization.of(context).translate("no_like_addition"),
                                  style: TextStyle(
                                    fontFamily: 'DIN Next LT Arabic',
                                    fontSize: 14,
                                    color: grey4,
                                  )
                              ),
                              TextSpan(
                                  text:AppLocalization.of(context).translate("complete_order"),
                                  style: TextStyle(
                                    color: green,
                                    fontWeight: FontWeight.w600,
                                  )
                              )
                            ]
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),


                  ],
                ),
              ),


    );
  }


}


