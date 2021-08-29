import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/app_bar.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/grid_restaurant_component.dart';
import 'package:eat_more_app/component/restaurant_component.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../color.dart';

class RestaurantsListScreen extends StatefulWidget {
  @override
  _RestaurantsListScreenState createState() => _RestaurantsListScreenState();
}
Color colorContainer(index){
  if((index+4)%4==0)
    return Color(0xff0068B0);
  else if((index+4)%4==1)
    return Color(0xffF55C3D);
  else if((index+4)%4==2)
    return Color(0xffE54B4B);
  return Color(0xff5CC2B4);
}
class _RestaurantsListScreenState extends State<RestaurantsListScreen> with TickerProviderStateMixin {
  bool _isGrid=false;
  bool _iSList=true;
  var _isLoading=false;
  var _isLoading1=false;
  var _selectedIndex=0;
  List<VendorCategory> _vendorCategory;
  List<Restaurant> _vendors;


  @override
  void initState() {
    _vendorCategory=[];
    _vendors=[];
    // TODO: implement initState
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryIconColor,
      appBar: AppBarWidget(
        title: '',
      ),
      body: Stack(
        children: [
        PositionedDirectional(
        start: 0,
        end: 0,
        bottom: 0,
        top: 10,
        child: ContainerComponent(
          child: ClipRRect(
           borderRadius:BorderRadius.only(
             topLeft: Radius.circular(44.0),
             topRight: Radius.circular(44.0),) ,
           child: ListView.builder(
               itemCount: _isLoading1||_isGrid?3:2+_vendors.length,
               itemBuilder: (context, index) {
                 if(index==0)
                   return Container(
                     height: 125,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(
                         color: background,
                         borderRadius:BorderRadius.only(
                           topLeft: Radius.circular(44.0),
                           topRight: Radius.circular(44.0),) ,
                         boxShadow: [
                           BoxShadow(
                               color: black.withOpacity(0.16),
                               blurRadius: 6,
                               offset: Offset(0,3)
                           )
                         ]

                     ),

                     // color: Colors.yellow,
                     child:_isLoading?Center(child: CupertinoActivityIndicator(),): Container(
                       height:90,
                       child: ListView.builder(
                           itemCount: _vendorCategory.length,
                           scrollDirection: Axis.horizontal,

                           itemBuilder:(context,index1){
                             return GestureDetector(
                               onTap: (){
                                 setState(() {
                                   _selectedIndex=index1;
                                 });
                                 _getVendors(_vendorCategory[_selectedIndex].vendor_category_id);

                               },
                               child: Container(
                                 margin: EdgeInsetsDirectional.only(
                                   start: index1==0?16:6.5,
                                   end: index1==5?16:0,
                                 ),
                                 width: 88,
                                 height: 90,
                                 decoration: BoxDecoration(
                                   color: colorContainer(index),
                                   border: Border.all(
                                     color:index1==_selectedIndex? black:Colors.transparent,
                                     width: 1.5
                                   ),

                                   borderRadius: BorderRadius.circular(5),
                                 ),
                                 child: Stack(
                                   children: [
                                     PositionedDirectional(
                                         top: 0,
                                         end: 0,
                                         child:ClipRRect(
                                             borderRadius: BorderRadius.circular(5),

                                             child: CachedNetworkImage(
                                               imageUrl: _vendorCategory[index1].resturant_category_image,
                                               progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                   CupertinoActivityIndicator(),
                                               errorWidget:
                                                   (BuildContext context, String url, Object error) {
                                                 print(error);
                                                 return const Icon(Icons.error);
                                               },
                                             ))
                                     ),
                                     PositionedDirectional(
                                       bottom: 4,
                                       start: 30,
                                       child: Text(
                                         _vendorCategory[index1].vendoor_category_name  ,
                                         style: TextStyle(
                                             fontFamily: 'DIN Next LT Arabic',
                                             fontSize: 15,
                                             color: white1
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             );
                           }),
                     ),
                   );
                 if(index==1)
                   return Padding(
                     padding:
                     EdgeInsetsDirectional.only(top: 17, start: 16, end: 16),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           AppLocalization.of(context).translate('restaurants_all'),
                           style: TextStyle(
                             fontFamily: 'DIN Next LT Arabic',
                             fontSize: 18,
                             color: black3,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                         Row(
                           children: [
                             InkWell(
                               onTap: (){
                                 setState(() {
                                   _iSList=true;
                                   _isGrid=false;
                                 });
                               },
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(
                                     color: _iSList?grey4:Colors.transparent,
                                     width: 1,
                                   ),
                                   borderRadius: BorderRadius.circular(5),
                                 ),
                                 child: Icon(
                                   Icons.view_list,
                                   color: primaryIconColor,
                                 ),
                               ),
                             ),
                             SizedBox(
                               width: 8,
                             ),
                             InkWell(
                               onTap: (){
                                 setState(() {
                                   _iSList=false;
                                   _isGrid=true;
                                   // animationController.forward();
                                   // animationController.stop();
                                 });
                               },
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(
                                     color: !_isGrid?Colors.transparent:grey4,
                                     width: 1,
                                   ),
                                   borderRadius: BorderRadius.circular(5),
                                 ),
                                 child: Icon(
                                   Icons.grid_view,
                                   color: primaryIconColor,
                                 ),
                               ),
                             ),
                           ],
                         )
                       ],
                     ),
                   );
             return  _isLoading1?Expanded(child: Center(child: CupertinoActivityIndicator(),)):_isGrid?
             Expanded(
                child: GridRestaurantComponent(
                   vendors:_vendors,
                 ),
              )
             :RestaurantComponent(index: index-2,vendors: _vendors);
               }),
         ),

         ),
        ),

        ],
      ),
    );
  }

  void _getCategory() async{
    setState(() {
      _isLoading=true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context).getVendorCategory().then((value) {
      if(value.status.status){
        _vendorCategory.addAll(value.data.vendoor_category);
        _getVendors(value.data.vendoor_category[0].vendor_category_id);
      }
      setState(() {
        _isLoading=false;
      });
    });
  }

  void _getVendors(int id) async{
    setState(() {
      _isLoading1=true;
    });
    _vendors.clear();
    await ScopedModel.of<RestaurantsApiModel>(context).getVendors(id).then((value) {
      if(value.status.status){
        _vendors.addAll(value.data.vendor);
      }
      setState(() {
        _isLoading1=false;
      });
    });
  }
}



