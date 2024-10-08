// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:eat_more_app/api/restaurants_api_model.dart';
// import 'package:eat_more_app/color.dart';
// import 'package:eat_more_app/component/address_check_out.dart';
// import 'package:eat_more_app/component/app_bar.dart';
// import 'package:eat_more_app/component/app_dialog.dart';
// import 'package:eat_more_app/component/cached_network_image_component.dart';
// import 'package:eat_more_app/component/cart_button.dart';
// import 'package:eat_more_app/component/cart_list.dart';
// import 'package:eat_more_app/component/check_out_tile.dart';
// import 'package:eat_more_app/component/container_component.dart';
// import 'package:eat_more_app/component/coupon_sheet.dart';
// import 'package:eat_more_app/component/horozintal_divider.dart';
// import 'package:eat_more_app/component/last_item_cart.dart';
// import 'package:eat_more_app/component/my_progress_indicator.dart';
// import 'package:eat_more_app/component/order_dialog.dart';
// import 'package:eat_more_app/component/otp_code_sheet.dart';
// import 'package:eat_more_app/component/radio_list_tile.dart';
// import 'package:eat_more_app/helper/app_localization.dart';
// import 'package:eat_more_app/helper/shared_preference.dart';
// import 'package:eat_more_app/model/arguments/check_out_argument.dart';
// import 'package:eat_more_app/model/check_out_response.dart';
//
// import 'package:eat_more_app/widgets/empty_widget_column.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:myfatoorah_flutter/model/initpayment/MFInitiatePaymentRequest.dart';
// import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
// import 'package:myfatoorah_flutter/utils/MFCurrencyISO.dart';
// import 'package:scoped_model/scoped_model.dart';
//
// import '../helper/helper.dart';
//
// class CheckOutScreen extends StatefulWidget {
//   final CheckOutArgument argument;
//
//   CheckOutScreen(this.argument);
//
//   @override
//   _CheckOutScreenState createState() => _CheckOutScreenState();
// }
//
// class _CheckOutScreenState extends State<CheckOutScreen> {
//   List<Payment> _paymentMethods;
//   List<Payment> _typeCoupon;
//   String mAPIUrl = "";
//   String mAPIKey = "";
//   List<PaymentMethods> _methods;
//   var _isDelete = false;
//   var _isLoading = false;
//   var _isLoading1 = false;
//   var _selectedIndex;
//   var _selectedCartIndex;
//   var _selectedPaymentIndex = 0;
//   var _isExpanded = false;
//   var _isChecked = false;
//   String couponDiscountAmount = "";
//   String finalPrice = "";
//   String couponCode = "";
//   String _otpToken = "";
//   String _token = "";
//   int _transactionId;
//   var _isPlus = false;
//   var _isMines = false;
//   CheckOutArgument _arguments;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryIconColor,
//       appBar: AppBarWidget(
//         title: AppLocalization.of(context).translate("your_basket")
//
//       ),
//       body: IgnorePointer(
//         ignoring: _isDelete || _isPlus || _isMines ? true : false,
//         child: Stack(
//           children: [
//             PositionedDirectional(
//               start: 0,
//               end: 0,
//               bottom: 0,
//               top: 10,
//               child: _isLoading
//                   ? ContainerComponent(
//                       child: MyProgressIndicator()
//                     )
//                   : _arguments.carts?.isEmpty ?? true
//                       ? ContainerComponent(
//                           child: EmptyWidgetColumn(
//                             message: 'no_items_added_cart',
//                             icon: CupertinoIcons.cart,
//                           )
//                         )
//                       : ClipRRect(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(44.0),
//                             topRight: Radius.circular(44.0),
//                           ),
//                           child: ContainerComponent(
//                             child: Column(
//                               children: [
//                                 Flexible(
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           height: 22,
//                                         ),
//
//                                         TitleCheckOut(
//                                             title: AppLocalization.of(context)
//                                                 .translate("list_orders")),
//                                         SecondContainerComponent(
//                                           radius: const BorderRadius.all(Radius.circular(5)),
//                                           child: ListView.separated(
//                                               shrinkWrap: true,
//                                               physics: ClampingScrollPhysics(),
//                                               itemBuilder: (context, index) {
//                                                  if (index == _arguments.carts.length)
//                                                   return LastRowCart(
//                                                     total: _arguments.total,
//                                                     minimum:_arguments.minimum,
//                                                   );
//
//                                                 // return CartItem(
//                                                 //   index: index,
//                                                 //   selectedIndex: _selectedCartIndex,
//                                                 //   pressPlus:  () {
//                                                 //               _updateQuantity(index, true);
//                                                 //             },
//                                                 //   loading: _isPlus,
//                                                 //   mines: _isMines,
//                                                 //   pressMines: _arguments.carts[index].quantity == 1
//                                                 //           ? null
//                                                 //           : () {
//                                                 //               _updateQuantity(
//                                                 //                   index, false);
//                                                 //             },
//                                                 //   press: () {
//                                                 //     Helper.showAlertDialog(
//                                                 //         context,
//                                                 //         AppLocalization.of(context).translate("sure_delete_item"),
//                                                 //         AppLocalization.of(context).translate("remove"), () {
//                                                 //       _removeCart(
//                                                 //         _arguments.carts[index].basket_product_id,
//                                                 //         index,
//                                                 //       );
//                                                 //       Navigator.pop(context);
//                                                 //     });
//                                                 //   },
//                                                 //   carts: _arguments.carts,
//                                                 // );
//                                               },
//                                               separatorBuilder:
//                                                   (context, index) {
//                                                 return HorizontalDivider();
//                                               },
//                                               itemCount: _arguments.carts.length + 1),
//                                         ),
//                                              Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   SizedBox(
//                                                     height: 15,
//                                                   ),
//                                                   TitleCheckOut(
//                                                     title: AppLocalization.of(context).translate("payment_method"),
//                                                   ),
//                                                   SecondContainerComponent(
//                                                       radius: const BorderRadius.all(Radius.circular(5)),
//                                                       child: ListView.separated(
//                                                           shrinkWrap: true,
//                                                           physics: ClampingScrollPhysics(),
//                                                           itemBuilder: (context, index) {
//                                                             if (index == 0)
//                                                               return _buildFirstTile(
//                                                                   index);
//                                                             return _otherTiles(index);
//                                                           },
//                                                           separatorBuilder: (context, index) {
//                                                             return Divider(
//                                                               color: grey4.withOpacity(0.24),
//                                                               thickness: 1,
//                                                             );
//                                                           },
//                                                           itemCount: _paymentMethods.length)
//                                                   ),
//                                                   SizedBox(
//                                                     height: 15,
//                                                   ),
//                                                 ],
//                                               ),
//                                       AddressCheckOutWidget(
//                                                 branch: _arguments.branch,
//                                                 address: _arguments.address),
//                                          SizedBox(
//                                                 height: 31,
//                                               ),
//
//                                       SecondContainerComponent(
//                                                 radius: const BorderRadius.all(Radius.circular(5)),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.only(bottom: 8.0),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Text(
//                                                         AppLocalization.of(context).translate("delivery_instructions"),
//                                                         style: TextStyle(
//                                                           fontSize: 20,
//                                                           color: black1,
//                                                         ),
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Checkbox(
//                                                               value: _isChecked,
//                                                               onChanged: (v) {
//                                                                 setState(() {
//                                                                   _isChecked = v;
//                                                                 });
//                                                               }),
//                                                           Text(
//                                                             AppLocalization.of(context).translate("leave_order_door"),
//                                                             style: TextStyle(
//                                                               fontSize: 17,
//                                                               color: black1.withOpacity(0.76),
//                                                               fontWeight:
//                                                                   FontWeight.w300,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsetsDirectional
//                                                                     .only(
//                                                                 start: 18),
//                                                         child: Text(
//                                                           AppLocalization.of(
//                                                                   context)
//                                                               .translate(
//                                                                   "leave_your_order_described"),
//                                                           style: TextStyle(
//
//                                                             fontSize: 15,
//                                                             color: black1
//                                                                 .withOpacity(
//                                                                     0.74),
//                                                             fontWeight:
//                                                                 FontWeight.w300,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                         SizedBox(
//                                           height: 23,
//                                         ),
//                                         TitleCheckOut(
//                                             title: AppLocalization.of(context)
//                                                 .translate("payment_details"),
//                                          ),
//
//                                         _typeCoupon.isEmpty
//                                                 ? SizedBox.shrink()
//                                                 : SecondContainerComponent(
//                                                     radius:
//                                                         const BorderRadius.all(
//                                                             Radius.circular(5)),
//                                                     child: Padding(
//                                                       padding:
//                                                           EdgeInsets.symmetric(
//                                                               horizontal: 20,
//                                                               vertical: 16),
//                                                       child: Row(
//                                                         children: [
//                                                           Text(
//                                                             AppLocalization.of(
//                                                                     context)
//                                                                 .translate(
//                                                                     "coupon_code"),
//                                                             style: TextStyle(
//
//                                                               fontSize: 19,
//                                                               color: black1,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w300,
//                                                             ),
//                                                           ),
//                                                           Spacer(),
//                                                           TextButton.icon(
//                                                             onPressed: couponCode.isNotEmpty || _arguments.total <_arguments.minimum
//                                                                 ? null
//                                                                 : () {
//                                                                   Helper.showModalBottom(context, CouponSheet(
//                                                                     total: _arguments.total,
//                                                                     types: _typeCoupon,
//                                                                     id: _arguments.id,
//                                                                     type: _arguments.idWay == 1
//                                                                         ? "pickup"
//                                                                         : "delivery",
//                                                                   )).then((value) {
//                                                                     if(value!=null)
//                                                                       setState(() {
//                                                                         couponDiscountAmount = value[0];
//                                                                         finalPrice = value[1];
//                                                                         couponCode = value[2];
//                                                                         _otpToken = value[3];
//                                                                         _token = value[4];
//                                                                       });
//                                                                   });
//                                                                   },
//                                                             icon: finalPrice.isEmpty
//                                                                 ? Icon(
//                                                                     CupertinoIcons
//                                                                         .creditcard_fill,
//                                                                     color: _arguments.total < _arguments.minimum ? grey2 : primaryIconColor,
//                                                                   )
//                                                                 : Icon(
//                                                                     Icons.check_circle_rounded,
//                                                                     color: primaryIconColor,
//                                                                   ),
//                                                             label: Text(
//                                                               couponCode.isEmpty ? AppLocalization.of(context).translate("add_code") : couponCode,
//                                                               style: TextStyle(
//                                                                 fontFamily: 'Cairo',
//                                                                 fontSize: 14,
//                                                                 color: _arguments.total < _arguments.minimum ? grey2 : green,
//                                                               ),
//                                                             ),
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                           SizedBox(
//                                                 height: 8,
//                                               ),
//                                         SecondContainerComponent(
//                                           radius: const BorderRadius.all(
//                                               Radius.circular(5)),
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 20, vertical: 16),
//                                             child: Column(
//                                               children: [
//                                                 SumTile(
//                                                   title: AppLocalization.of(
//                                                           context)
//                                                       .translate("total_order"),
//                                                   price:'${_arguments.total}' +
//                                                           " " +
//                                                           AppLocalization.of(
//                                                                   context)
//                                                               .translate("sr"),
//                                                   color:
//                                                       black3.withOpacity(0.93),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 4,
//                                                 ),
//                                                 SumTile(
//                                                     title: AppLocalization.of(
//                                                             context)
//                                                         .translate(
//                                                             "delivery_fee"),
//                                                     price: '${_arguments.deliveryCost}' +
//                                                             " " +
//                                                             AppLocalization.of(
//                                                                     context)
//                                                                 .translate(
//                                                                     "sr"),
//                                                     color: black3
//                                                         .withOpacity(0.93)),
//                                                 SizedBox(
//                                                   height: 4,
//                                                 ),
//                                                 SumTile(
//                                                   title: AppLocalization.of(
//                                                           context)
//                                                       .translate(
//                                                           "discount_value"),
//                                                   price: couponDiscountAmount
//                                                           .isEmpty
//                                                       ? "0.0" +
//                                                           " " +
//                                                           AppLocalization.of(
//                                                                   context)
//                                                               .translate("sr")
//                                                       : "-" +
//                                                           couponDiscountAmount +
//                                                           " " +
//                                                           AppLocalization.of(
//                                                                   context)
//                                                               .translate("sr"),
//                                                   color: red,
//                                                 ),
//                                                 // SumTile(
//                                                 //     title: 'خصم نقاط',
//                                                 //     price: '-25 SAR'),
//                                                 Divider(
//                                                   color:
//                                                       grey4.withOpacity(0.24),
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Text(
//                                                         AppLocalization.of(
//                                                                 context)
//                                                             .translate("total"),
//                                                         style: TextStyle(
//                                                           fontFamily:
//                                                               'DIN Next LT Arabic',
//                                                           fontSize: 19,
//                                                           color: black5,
//                                                         )),
//                                                     Spacer(),
//                                                     Text(
//                                                       couponCode.isNotEmpty
//                                                               ? "${double.parse(finalPrice) + _arguments.deliveryCost}" +
//                                                                   " " +
//                                                                   AppLocalization.of(context).translate("sr")
//                                                               : "${_arguments.total + _arguments.deliveryCost}" +
//                                                                   " " +
//                                                                   AppLocalization.of(context).translate("sr"),
//                                                       style: TextStyle(
//                                                         fontFamily: 'Cairo',
//                                                         fontSize: 16,
//                                                         color: green
//                                                             .withOpacity(0.93),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 29,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                                 AppLocalization.of(context)
//                                                             .translate("all_price_include") + '${_arguments.vat}%' +
//                                                         AppLocalization.of(context).translate("vat"),
//                                                 style: TextStyle(
//                                                   fontSize: 17,
//                                                   color: black1.withOpacity(0.76),
//                                                   fontWeight: FontWeight.w300,
//                                                 )
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 20,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                IgnorePointer(
//                                         ignoring: (_arguments.total < _arguments.minimum) && couponCode.isEmpty
//                                                 ? true : false,
//                                         child: SafeArea(
//                                           top: false,
//                                           child: Container(
//                                             margin: EdgeInsetsDirectional.only(
//                                                 bottom: 15, start: 30, end: 30),
//                                             width: double.infinity,
//                                             child: CartButton(
//                                               isLoading: _isLoading1,
//                                               total: _arguments.total,
//                                               color: primaryIconColor,
//                                               text: AppLocalization.of(context)
//                                                   .translate("execute_order"),
//                                               textColor: (_arguments.total <
//                                                           _arguments.minimum) &&
//                                                       couponCode.isEmpty
//                                                   ? grey2
//                                                   : background,
//                                               tap: () {
//                                                 if (_selectedIndex == null) {
//                                                   AppDialog.showMe(context, 'يجب اختيار طريقة الدفع');
//                                                 } else if (_otpToken.trim().isNotEmpty) {
//                                                   Helper.showModalBottom(context, OTPCodeSheet(
//                                                     token: _token,
//                                                     otpToken: _otpToken,
//                                                     total: _arguments.total,
//                                                   )).then((value){
//                                                     if (value != null) {
//                                                       _transactionId = value;
//                                                        _tapCart();
//                                                     }
//                                                   });
//                                                 } else
//                                                   _tapCart();
//                                                 },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                               ],
//                             ),
//                           ),
//                         ),
//             ),
//
//             // Visibility(
//             //   visible: _isDelete,
//             //   child: Center(
//             //     child: CupertinoActivityIndicator(),
//             //   ),
//             // )
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _paymentMethods = [];
//     _methods = [];
//     _typeCoupon = [];
//     _arguments=widget.argument;
//       _getPaymentMethod();
//
//     super.initState();
//   }
//
//   void _getCart() async {
//     await ScopedModel.of<RestaurantsApiModel>(context)
//         .getCart(_arguments.id)
//         .then((value) {
//       if (value.status.status) {
//         setState(() {
//           _arguments.total = value.data.products_price;
//           _arguments.carts = value.data.products;
//         });
//       }
//       setState(() {
//         _isDelete = false;
//       });
//     });
//   }
//
//   void _getCreditMethod() async {
//     await ScopedModel.of<RestaurantsApiModel>(context).getMyFatoorah(101)
//         .then((value) async {
//       if (value.status.status) {
//         mAPIUrl = value.data.base_url;
//         mAPIKey = value.data.token;
//         if (mAPIKey.isEmpty) {
//           print('isEmpty');
//           return;
//         }
//
//         // TODO, don't forget to init the MyFatoorah Plugin with the following line
//         MFSDK.init(mAPIUrl, mAPIKey);
//         var request = await MFInitiatePaymentRequest(
//             _arguments.total + _arguments.deliveryCost, MFCurrencyISO.SAUDI_ARABIA_SAR);
//         MFSDK.initiatePayment(
//             request,
//             MFAPILanguage.AR,
//             (MFResult<MFInitiatePaymentResponse> result) => {
//                   if (result.isSuccess())
//                     {
//                       print(result.response.toJson().toString()),
//                       _methods.addAll(result.response.paymentMethods),
//                     }
//                   else
//                     {print('soma'), print(result.error.message)}
//                 });
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     });
//   }
//
//   void _getPaymentMethod() async {
//     var body = {"type": _arguments.idWay == 1 ? "pickup" : "delivery"};
//     setState(() {
//       _isLoading = true;
//     });
//     await ScopedModel.of<RestaurantsApiModel>(context).listPayment(_arguments.id, body)
//         .then((value) {
//       if (value.status.status) {
//         _paymentMethods.addAll(value.data.payment_type);
//         if (value.data.coupon_type != null)
//           _typeCoupon.addAll(value.data.coupon_type);
//         _getCreditMethod();
//       }
//     });
//   }
//
//   void _removeCart(int id, int index) async {
//     print(id);
//     setState(() {
//       _isDelete = true;
//     });
//     await ScopedModel.of<RestaurantsApiModel>(context)
//         .deleteCart(id)
//         .then((value) {
//       if (value.status.status) _getCart();
//     });
//   }
//
//   Widget _buildFirstTile(int index) {
//     return Theme(
//       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//       child: ExpansionTile(
//         title: Row(
//           children: [
//             CachedNetworkImageComponent(
//               url: _paymentMethods[index].image,
//               width: 30,
//               height: 30,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Text(_paymentMethods[index].key),
//           ],
//         ),
//         children: [
//           Column(
//             children: [
//               SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: List.generate(_methods.length, (index1) {
//                   return Padding(
//                       padding: EdgeInsetsDirectional.only(
//                           start: index1 == 0 ? 20 : 8),
//                       child: Stack(
//                         alignment: const AlignmentDirectional(-0.9, -1.1),
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _selectedPaymentIndex = index1;
//                               });
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 5),
//                               // height: 90,
//                               width: 77,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(4),
//                                   border: Border.all(
//                                       color: index1 == _selectedPaymentIndex
//                                           ? primaryIconColor
//                                           : grey10,
//                                       width: 1.0)),
//                               child: Column(
//                                 children: [
//                                   CachedNetworkImageComponent(
//                                     url: _methods[index1].imageUrl,
//                                   ),
//                                   Padding(padding: EdgeInsets.only(top: 8),
//                                     child: Text(_methods[index1].paymentMethodAr,
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 10,
//                                             color: black4,
//                                             fontFamily: '')),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Visibility(
//                             visible: index1 == _selectedPaymentIndex ? true : false,
//                             child: Container(
//                               width: 10,
//                               height: 10,
//                               decoration: BoxDecoration(
//                                 color: primaryIconColor,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.check,
//                                 color: Colors.white,
//                                 size: 10,
//                               ),
//                             ),
//                           )
//                         ],
//                       ));
//                 }),
//               ),
//             ],
//           ),
//         ],
//         key: UniqueKey(),
//         initiallyExpanded:
//             _selectedIndex == index && _isExpanded ? true : false,
//         onExpansionChanged: (v) {
//           setState(() {
//             _selectedIndex = index;
//             _isExpanded = v;
//           });
//         },
//         leading: Radio(
//           value: _selectedIndex,
//           groupValue: 0,
//           onChanged: (v) {
//             setState(() {
//               _selectedIndex = index;
//               _isExpanded = true;
//             });
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _otherTiles(int index) {
//     return RadioListTilePayment(
//       onChanged: (v) {
//         setState(() {
//           _selectedIndex = index;
//           _isExpanded = false;
//         });
//       },
//       index: index,
//       selectedIndex: _selectedIndex,
//       // paymentMethods: _paymentMethods,
//     );
//   }
//
//   void _executePayment() async {
//     // if (!_validate()) return;
//     // try{
//     setState(() {
//       _isLoading1 = true;
//     });
//     var body = {
//       "type": _arguments.idWay == 1 ? "pickup" : "delivery",
//       "is_rajhi": _otpToken.trim().isNotEmpty ? "1" : "0",
//       "invoicevalue": '$finalPrice',
//       "is_qitaf": false.toString(),
//       "couponCode": couponCode
//     };
//     print(body);
//     int paymentMethod = _methods[_selectedPaymentIndex].paymentMethodId;
//     await ScopedModel.of<RestaurantsApiModel>(context)
//         .paymentByMyFatoorah(_arguments.id, body)
//         .then((value) {
//       if (value.status.status) {
//         var request = new MFExecutePaymentRequest(
//             paymentMethod,
//             couponCode.isNotEmpty
//                 ? double.parse(finalPrice) + _arguments.deliveryCost
//                 : _arguments.total + _arguments.deliveryCost);
//         request.paymentMethodId =
//             _methods[_selectedPaymentIndex].paymentMethodId;
//         request.customerEmail = value.data.CustomerEmail;
//         request.customerMobile = value.data.CustomerMobile;
//         request.customerName = value.data.CustomerName;
//         request.customerReference = value.data.CustomerReference.toString();
//         request.invoiceItems = value.data.InvoiceItems;
//         print(request.invoiceItems);
//         request.suppliers = value.data.Suppliers;
//         request.invoiceValue = value.data.InvoiceValue;
//         request.userDefinedField = value.data.UserDefinedField;
//         request.mobileCountryCode = value.data.MobileCountryCode;
//         request.language =
//             UtilSharedPreferences.getInt('lang') == 0 ? 'en' : "ar";
//         MFSDK.executePayment(
//             context,
//             request,
//             MFAPILanguage.EN,
//             (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
//                   if (result.isSuccess())
//                     {print(result.response.toJson().toString()), _makeOrder()}
//                   else
//                     {
//                       print(result.error.message),
//                       setState(() {
//                         _isLoading1 = false;
//                       }),
//                     }
//                 });
//       } else {
//         AppDialog.showMe(context, value.status.HTTP_response);
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     });
//     // }
//     // catch(err){
//     //   AppDialog.showMe(context, err.toString());
//     //   setState(() {
//     //     _isLoading1 = false;
//     //
//     //   });
//     // }
//   }
//
//   _makeOrder() async {
//     // if (!_validate()) return;
//
//     if (_selectedIndex != 0)
//       setState(() {
//         _isLoading1 = true;
//       });
//
//     var _body = {
//       "type": _arguments.idWay == 1 ? "pickup" : "delivery",
//       "branchID": _arguments.branch.branch_id.toString(),
//       "vendor_id": _arguments.id.toString(),
//       "is_schedule": _arguments.time == null || _arguments.time.trim().isEmpty
//           ? false.toString()
//           : true.toString(),
//       "schedule_date": _arguments.time == null ? "" : _arguments.time,
//       "note": !_isChecked ? "" : 'اترك الطلب عند الباب',
//       "long": _arguments.lng?? "",
//       "lat": _arguments.lat ?? '',
//       "paymentType":
//           _selectedIndex != null ? _paymentMethods[_selectedIndex].key : "",
//       "order_address": _arguments.address?.trim() ?? '',
//       "transactionid": _transactionId != null ? '$_transactionId' : "",
//       "addressID": "",
//       "is_rajhi": _otpToken.trim().isNotEmpty ? "1" : "0",
//       "invoicevalue": '$finalPrice',
//     };
//
//     print(_body);
//     await ScopedModel.of<RestaurantsApiModel>(context)
//         .makeOrder(_body)
//         .then((value) {
//       if (value.status.status) {
//         setState(() {
//           _arguments.carts.clear();
//           _arguments.total = 0.0;
//         });
//         showDialog(
//             context: context,
//             barrierDismissible: true,
//             // barrierColor:Colors.black,  // لون الشاشة خلف الديلوج
//             builder: (context) {
//               return OrderDialog(
//                 orderId: value.data.order_id,
//               );
//             });
//       } else
//         AppDialog.showMe(context, value.status.HTTP_response);
//
//       setState(() {
//         _isLoading1 = false;
//       });
//     });
//   }
//
//   void _updateQuantity(int index, isPlus) async {
//     setState(() {
//       _selectedCartIndex = index;
//       if (isPlus)
//         _isPlus = true;
//       else
//         _isMines = true;
//     });
//     var _body = {
//       "new_quantity": isPlus
//           ? '${_arguments.carts[index].quantity + 1}'
//           : '${_arguments.carts[index].quantity - 1}',
//       "vendor_id": '${_arguments.id}'
//     };
//     print(_body);
//     await ScopedModel.of<RestaurantsApiModel>(context)
//         .updateCart(_arguments.carts[index].basket_product_id, _body)
//         .then((value) {
//       if (value.status.status) {
//         setState(() {
//           _isPlus
//               ? _arguments.carts[index].quantity++
//               : _arguments.carts[index].quantity--;
//           _isPlus
//               ? _arguments.total =
//                   _arguments.total + _arguments.carts[index].one_product_price
//               : _arguments.total =
//                   _arguments.total - _arguments.carts[index].one_product_price;
//         });
//       }
//       setState(() {
//         if (isPlus)
//           _isPlus = false;
//         else
//           _isMines = false;
//       });
//     });
//   }
//
//   // bool _validate() {
//   //   User user = ScopedModel.of<RestaurantsApiModel>(context).loggedUser;
//   //   if (user.fname == null ||
//   //       user.lname == null ||
//   //       user.email == null ||
//   //       user.birthday == null ||
//   //       user.lname.trim().isEmpty == null ||
//   //       user.gender == null) {
//   //     AppDialog.showMe(context,
//   //         AppLocalization.of(context).translate('You_must_fill_all_data'),
//   //         onClickOk: () {
//   //       Navigator.push(context,
//   //           MaterialPageRoute(builder: (context) => EditProfileScreen()));
//   //     });
//   //     return false;
//   //   }
//   //   return true;
//   // }
//
//   void _tapCart() {
//     if (_selectedIndex == 0)
//       _executePayment();
//     else
//       _makeOrder();
//   }
//
//   // void _back() {
//   //   var _count=0;
//   //   Navigator.popUntil(context,
//   //           (Route<dynamic> route) => _count++==2,
//   //
//   //   );
//   // }
// }
//
