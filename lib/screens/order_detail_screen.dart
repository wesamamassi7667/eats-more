// import 'package:eat_more_app/component/address_check_out.dart';
// import 'package:eat_more_app/component/cart_list.dart';
// import 'package:eat_more_app/component/check_out_tile.dart';
// import 'package:eat_more_app/component/container_component.dart';
// import 'package:eat_more_app/component/header_order_detail.dart';
// import 'package:eat_more_app/component/horozintal_divider.dart';
// import 'package:eat_more_app/component/last_item_cart.dart';
// import 'package:eat_more_app/component/second_header_component.dart';
// import 'package:eat_more_app/helper/app_localization.dart';
// import 'package:eat_more_app/model/order_response.dart';
// import 'package:flutter/material.dart';
//
// import '../color.dart';
//
// class OrderDetailsScreen extends StatelessWidget {
//   final Order order;
//   const OrderDetailsScreen({Key key, this.order}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SecondHeaderComponent(
//       title: AppLocalization.of(context).translate("order") + order.order_number,
//       child: Column(
//         children: [
//           SizedBox(
//             height: 22,
//           ),
//           HeaderOrderDetails(
//             order: order,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           AddressCheckOutWidget(
//             branch: order.branch,
//             isOrder: true,
//             address: order.order_address,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           TitleCheckOut(
//               title: AppLocalization.of(context).translate("list_orders")),
//           SecondContainerComponent(
//             child: ListView.separated(
//               shrinkWrap: true,
//               itemBuilder: (_, index) {
//                 if (index == order.products.length)
//                   return LastRowCart(total: order.total, order: order);
//                 return CartItem(
//                   index: index,
//                   order: order,
//                 );
//               },
//               itemCount: order.products.length + 1,
//               separatorBuilder: (_, index) {
//                 return HorizontalDivider();
//               },
//             ),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           TitleCheckOut(
//               title: AppLocalization.of(context).translate("payment_details"),
//               type: order.payment_type),
//           SecondContainerComponent(
//             radius: const BorderRadius.all(Radius.circular(5)),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//               child: Column(
//                 children: [
//                   SumTile(
//                     title: AppLocalization.of(context).translate("total_order"),
//                     price: '${order.total}' +
//                         " " +
//                         AppLocalization.of(context).translate("sr"),
//                     color: black3.withOpacity(0.93),
//                   ),
//                   SizedBox(
//                     height: 4,
//                   ),
//                   SumTile(
//                       title:
//                           AppLocalization.of(context).translate("delivery_fee"),
//                       price: '${order.delivery_cost}' +
//                           " " +
//                           AppLocalization.of(context).translate("sr"),
//                       color: black3.withOpacity(0.93)),
//                   SizedBox(
//                     height: 4,
//                   ),
//                   SumTile(
//                       title: AppLocalization.of(context)
//                           .translate("discount_value"),
//                       price:
//                           "0.0 " + AppLocalization.of(context).translate("sr")),
//                   // SumTile(
//                   //     title: 'خصم نقاط',
//                   //     price: '-25 SAR'),
//                   Divider(
//                     color: grey4.withOpacity(0.24),
//                   ),
//                   Row(
//                     children: [
//                       Text(AppLocalization.of(context).translate("total"),
//                           style: TextStyle(
//                             fontSize: 19,
//                             color: black5,
//                           )),
//                       Spacer(),
//                       Text(
//                         "${order.total + order.delivery_cost}" +
//                             " " +
//                             AppLocalization.of(context).translate("sr"),
//                         style: TextStyle(
//                           fontFamily: 'Cairo',
//                           fontSize: 16,
//                           color: green.withOpacity(0.93),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 29,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                   AppLocalization.of(context).translate("all_price_include") +
//                       '${0}' +
//                       AppLocalization.of(context).translate("vat"),
//                   style: TextStyle(
//                     fontSize: 17,
//                     color: black1.withOpacity(0.76),
//                     fontWeight: FontWeight.w300,
//                   )),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           )
//         ],
//       ),
//     );
//   }
// }
