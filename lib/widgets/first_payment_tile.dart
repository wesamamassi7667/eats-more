
import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/model/check_out_response.dart';
import 'package:eat_more_app/widgets/coupon_payment_list.dart';
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import '../color.dart';
class FirstPaymentTile extends StatefulWidget {
  const FirstPaymentTile({Key key, this.paymentType, this.methods, this.tap, this.selectedIndex, this.onExpansionChange, this.onchange, this.isExpanded=false, this.index, this.callBack}) : super(key: key);
  final Payment paymentType;
  final int selectedIndex;
  final int index;

  final bool isExpanded;
  final List<PaymentMethods> methods;
  final Function tap,onExpansionChange,onchange,callBack;

  @override
  _FirstPaymentTileState createState() => _FirstPaymentTileState();
}

class _FirstPaymentTileState extends State<FirstPaymentTile> {
  Payment _paymentType;
  @override
  void initState() {
    _paymentType=widget.paymentType;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          CachedNetworkImageComponent(
            url: _paymentType.image,
            width: 30,
            height: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Text(_paymentType.value),
        ],
      ),
      children: [
        Column(
          children: [
            SizedBox(
              height: 5,
            ),
           CouponPaymentList(methods: widget.methods,callBack: widget.callBack,)
          ],
        ),
      ],
      key: UniqueKey(),
      initiallyExpanded: widget.isExpanded,
      onExpansionChanged: widget.onExpansionChange,
      leading: Radio(
          value: widget.index,
          groupValue: widget.selectedIndex,
          onChanged: widget.onchange
      ),
    );
  }
}

