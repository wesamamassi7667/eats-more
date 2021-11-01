import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/second_header_component.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:eat_more_app/screens/track_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class OrderScreen extends StatefulWidget {
  final String title;

  const OrderScreen({Key key, this.title}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> orders;
  var _isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    orders = [];
    super.initState();
    _getAllOrder();
  }

  @override
  Widget build(BuildContext context) {
    return SecondHeaderComponent(
      title: widget.title,
      child: _isLoading?MyProgressIndicator():
       orders.isEmpty?Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SvgPicture.asset('assets/images/order.svg'),
           SizedBox(
             height: 20,
           ),
           Text(
             AppLocalization.of(context).translate("no_orders"),
             style: TextStyle(
               fontSize: 22,
               color: black2,
             ),
           ),
           TextButton(
               onPressed: () {
                 var _count = 0;
                 Navigator.popUntil(
                     context, (Route<dynamic> route) => _count++ == 2);
               },
               child: Text(
                 AppLocalization.of(context).translate("order_now"),
                 style: TextStyle(
                   fontFamily: 'DIN Next LT Arabic',
                   fontSize: 16,
                   color: green,
                   fontWeight: FontWeight.w300,
                 ),
               )),

         ],
       ):Padding(
         padding: EdgeInsetsDirectional.only(top: 18),
         child: ListView.separated(
             itemCount: orders.length,
             separatorBuilder: (context,index){
               return SizedBox(height: 10,);
             }
             ,
             itemBuilder: (context,index){
               return InkWell(
                 onTap: (){
                   Navigator.pushNamed(context, '/OrderDetails',arguments: orders[index]);
                 },
                 child: Container(
                   margin: EdgeInsetsDirectional.only(start: 16,end: 16),
                   padding: EdgeInsetsDirectional.only(top:18,end: 21,bottom: 17),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(4),
                     boxShadow:[
                       BoxShadow(
                         offset: Offset(0,5),
                         blurRadius: 15,
                         color: Color(0xff242424).withOpacity(0.05),
                       ),
                     ],
                     border: Border.all(
                         color: Color(0xffE1E1E1),
                         width: 0.5
                     ),
                   ),
                   child: Row(
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Padding(
                             padding: const EdgeInsetsDirectional.only(start: 10),
                             child: Text(
                               "#" +"${orders[index].order_id}",
                               style: TextStyle(fontWeight:FontWeight.w400,fontSize:16,color:black),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsetsDirectional.only(start: 15,top:5,bottom: 24),
                             child: Text(
                               '${orders[index].order_date} ' ,
                               style: TextStyle(fontWeight:FontWeight.bold,fontSize:14,color:red1),
                             ),
                           ),

                           InkWell(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>TrackOrderScreen(
                                   id:orders[index].order_id
                               )));
                             },
                             child: Container(
                               margin: EdgeInsetsDirectional.only(start: 26),
                               padding: EdgeInsetsDirectional.only(start: 18,end: 18,top: 6,bottom: 8),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 color: _getColor(index),
                               ),
                               child: Text(
                                 orders[index].order_status.name,
                                 style: TextStyle(fontWeight:FontWeight.w500,fontSize:12,color:background,fontFamily:'DIN Next LT Arabic'),
                               ),
                             ),
                           ),
                         ],
                       ),
                       Spacer(),
                       Expanded(
                         child:GridView.count(
                             shrinkWrap: true,
                             crossAxisCount: 2,
                             childAspectRatio: 0.9,
                             mainAxisSpacing: 5,
                             crossAxisSpacing: 5,
                             children:List<Widget>.generate(
                                 orders[index].products.length<=3?orders[index].products.length:4,(index1)=>Container(
                               height: 117,
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(4),
                                   border: Border.all(
                                       color:grey12,
                                       width: 0.5
                                   )
                               ),
                               child: Center(child:(orders[index].products.length>3&&index1==3)?
                               Text(
                                 '+' +'${orders[index].products.length-3}',
                                 style: TextStyle(fontWeight:FontWeight.w400,fontSize:14,color:Colors.black,fontFamily:'DIN Next LT Arabic'),
                               ):
                               ClipRRect(
                                 borderRadius: BorderRadius.circular(4),
                                 child: CachedNetworkImageComponent(
                                   url:orders[index].products[index1].image,
                                   height: 117,
                                 ),
                               ),
                               ),
                             )

                             )
                         ),
                       )
                     ],
                   ),
                 ),
               );
             }
         ),
       ),

    );
  }

  void _getAllOrder() async {
    setState(() => _isLoading = true);
    final response=await AppApi.orderClient.listOrders();
    orders.addAll(response);
    setState(() =>_isLoading=false);
  }

  Color _getColor(index) {
    if (orders[index].order_status.id == 3)
      return Color(0xffFFB900);
    else if (orders[index].order_status.id == 8)
      return Color(0xff00C569);
    else if (orders[index].order_status.id == 6)
      return Colors.orange;
    else if (orders[index].order_status.id == 4)
      return Colors.purple;
    else if (orders[index].order_status.id == 5)
      return Colors.black45;
    else if (orders[index].order_status.id == 9) return Colors.pinkAccent;
    return Colors.red;
  }
}
