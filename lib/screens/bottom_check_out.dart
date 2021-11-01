import 'package:eat_more_app/component/common/common.dart';
import 'package:eat_more_app/component/horozintal_divider.dart';
import 'package:eat_more_app/component/row_check_out.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:eat_more_app/model/cart_response.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class CheckOutBottom extends StatelessWidget {
  const CheckOutBottom(
      {Key key,
      this.press,
      this.discountAmount,
      this.length,
      this.vat,
      this.vatNo,
      this.carts,
      this.totalPrice,
      this.totalPriceWithCoupon})
      : super(key: key);

  final Function press;
  final String discountAmount;
  final int length;
  final int vat;
  final String vatNo;
  final List<ProductCart> carts;
  final double totalPrice, totalPriceWithCoupon;

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
          minHeight: 100, maxHeight: size.height * 0.5),
      decoration: BoxDecoration(
        color: primaryIconColor,
        borderRadius: Common.borderRadiusRightLeft(),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ListTileTheme(
                // contentPadding: EdgeInsets.all(0), //remove padding horizontally
                dense: true, //remove padding vertically
                child: ExpansionTile(
                  title: Text(''),
                  trailing: Container(
                    constraints: BoxConstraints(
                        minWidth: 0.0,
                        maxWidth: size.width * 0.9),
                    // height: double.infinity,
                    child: Center(
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                    ),
                  ),
                  children: [
                    ListView.separated(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (_, index) {
                          if (index == length + 1 &&
                              discountAmount.trim().isNotEmpty) {
                            return CheckOutRow(
                              title: AppLocalization.of(context)
                                  .translate('discount'),
                              text: " $discountAmount",
                            );
                          }
                          if (index == length) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CheckOutRow(
                                  title: AppLocalization.of(context)
                                      .translate('vat'),
                                  isPrice: false,
                                  text: " $vat%",
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 40),
                                  child: Text(
                                    AppLocalization.of(context)
                                            .translate('vat_no') +
                                        ": " +
                                        "$vatNo",
                                    style: TextStyle(
                                        fontSize: 11, color: background),
                                  ),
                                )
                              ],
                            );
                          }

                          ProductCart _productCart = carts[index];
                          return CheckOutRow(
                            title:
                                "${_productCart.quantity}x ${_productCart.product_name}",
                            text: "${_productCart.final_price}",
                          );
                        },
                        separatorBuilder: (_, index) {
                          return HorizontalDivider(
                            color: Color(0xff7B53AA),
                          );
                        },
                        itemCount: discountAmount.trim().isNotEmpty
                            ? length + 2
                            : length + 1),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  bottom: 19, start: 30, end: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: AppLocalization.of(context).translate('total') +
                              '\n',
                          style: TextStyle(
                            fontSize: 13,
                            color: const Color(0xffbea5db),
                          )),
                      TextSpan(
                          text: discountAmount.isEmpty
                              ? '$totalPrice ' +
                                  AppLocalization.of(context).translate('sr')
                              : "$totalPriceWithCoupon " +
                                  AppLocalization.of(context).translate('sr'),
                          style: TextStyle(
                              color: background,
                              fontWeight: FontWeight.w500,
                              fontSize: 20))
                    ]),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: press,
                    child: Text(
                        AppLocalization.of(context).translate('execute_order')),
                    style: AppThemeData.textButtonStyle(
                        backgroundColor: background,
                        primary: black,
                        borderRadius: 10),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
