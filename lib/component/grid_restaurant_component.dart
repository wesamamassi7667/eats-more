
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:flutter/material.dart';

import '../color.dart';
import 'package:flutter_svg/flutter_svg.dart';
class GridRestaurantComponent extends StatelessWidget {
 final List<Restaurant> vendors;

  const GridRestaurantComponent({
    Key key, this.vendors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsetsDirectional.only(top:20,),
      child: Expanded(
        child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 183/87,
                physics: ClampingScrollPhysics(),
                crossAxisSpacing: 10,
                shrinkWrap: true,
                children: List<Widget>.generate(
                    vendors.length,(index){
                  return  Container(
                    margin: EdgeInsetsDirectional.only(
                      start: index.isEven?16:0,
                      end: index.isOdd?16:0,
                      bottom: 12
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: background,
                      boxShadow: [
                        BoxShadow(
                          color:black.withOpacity(0.16),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child:Stack(
                      children: [
                        PositionedDirectional(
                          top: 10,
                          bottom: 10,
                          start: 2,
                          child: Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                              image: DecorationImage(
                                image: Helper.buildCachedNetworkImageProvider(vendors[index].vendor_image),
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
                        ),
                        PositionedDirectional(
                          start: 64,
                          top: 6,
                          end: 5,
                          child: Text(
                            vendors[index].vendor_name,
                            style: TextStyle(
                              fontFamily: 'DIN Next LT Arabic',
                              fontSize: 16,
                              color: black2,
                            ),
                          ),
                        ),
                         PositionedDirectional(
                            start: 64,
                            end: 5,
                            top: 30,
                            child:  Text(
                                '${vendors[index].vendor_desc}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:TextStyle(
                                  fontFamily: 'DIN Next LT Arabic',
                                  fontSize: 9,
                                  height: 0.9,
                                  color: black3.withOpacity(0.88),
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                        PositionedDirectional(
                          start: 64,
                          bottom:5,
                          end: 5,
                          child:Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/bicycle.svg',width: 10,height: 10,),
                              SizedBox(width: 2,),
                              Text(
                                '${vendors[index].delivery_cost} '+AppLocalization.of(context).translate('sr'),
                                style: TextStyle(
                                  fontFamily: 'DIN Next LT Arabic',
                                  fontSize: 10,
                                  color: primaryIconColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),

                              Container(
                                height: 10,
                                child: VerticalDivider(
                                  color: grey4,
                                  thickness: 0.2,
                                ),
                              ),
                              // SizedBox(
                              //   width:9.5,
                              // ),
                              SvgPicture.asset(
                                'assets/images/location.svg',width: 12,height: 12,color: black),
                              SizedBox(width: 2,),
                              Text(
                                '1.5k',
                                style: TextStyle(
                                  fontFamily: 'DIN Next LT Arabic',
                                  fontSize: 10,
                                  color: const Color(0xff0068b0),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ) ,
                        )
                      ],
                    ),
                  );
                }
                ),


        ),
      ),
    );
  }

}

