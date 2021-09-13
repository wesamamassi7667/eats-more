import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/component/ads_image.dart';
import 'package:eat_more_app/component/text_with_line.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:eat_more_app/screens/item_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
import '../helper/helper.dart';
class ListMealHeight extends StatelessWidget {
  final SpecSlider item;
  final AnimationController controller;
   final List<SliderImage> ads;
  const ListMealHeight({Key key, this.item, this.controller, this.ads}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsetsDirectional.only(start: 23),
          child: Text(
            item.sliderName,
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 22,
              color: Helper.convertColor(item.color),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 15,),
        Container(
          height: 354.5,
          child: ListView.builder(
              itemCount: item.product.length,
              scrollDirection: Axis.horizontal,
              itemBuilder:(context,index){
              return  GestureDetector(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>ItemDetailsScreen(id: item.product[index].product_id,logo:item.product[index].vendor.logo,vendorId:item.product[index].vendor.vendor_id
                  )));
                },
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                        margin: EdgeInsetsDirectional.only(
                          start: index == 0 ? 23 : 9.4,
                          end: index == item.product.length-1 ? 14 : 0,
                          bottom: 26.9,
                          top: 24.5
                        ),
                        width:  MediaQuery.of(context).size.width*0.39,
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
                                height: 233,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(item.product[index].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child:item.product[index].product_offer==null?SizedBox.shrink():  Banner(
                                  message: AppLocalization.of(context).translate('offer'),
                                  location: BannerLocation.topStart,
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              top:236, start: 15.6,
                              child: Text(
                                item.product[index].product_name??"",
                                style: TextStyle(
                                  fontFamily: 'DIN Next LT Arabic',
                                  fontSize: 18,
                                  color:black3,
                                ),),
                            ),
                            PositionedDirectional(
                              start: 15.6,end: 0,top:250,
                              child: Row(
                                children: [
                                  TextWithLine(
                                        fontSize: 12,
                                        price:item.product[index].meal_price ,
                                        isOffer: item.product[index].product_offer!=null,
                                        bottom: 16,
                                      ),
                                  Spacer(),
                                  CupertinoButton(
                                    onPressed: (){
                                      Helper.showProductSheet(context,item.product[index].product_id,controller,item.product[index].vendor_id,
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
                              bottom: 7,
                              start: 15.6,
                              child: item.product[index].product_offer==null?SizedBox.shrink(): Text(
                              item.product[index].product_offer.offer_new_price+" " + AppLocalization.of(context).translate('sr'),
                              style:TextStyle(
                                fontFamily: 'DIN Next LT Arabic',
                                fontSize: 12,
                                color: black,
                              ),
                            )
                            )
                          ],
                        ),
                    ),
                   Container(
                        width: 49,
                        height: 49,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                item.product[index].vendor.logo),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),


                  ],
                ),
              );
          }),
        ),
        ads.isEmpty?SizedBox.shrink():AdsImageComponent(
          ads: ads,
          item: item,
        )

      ],
    );
  }
}
