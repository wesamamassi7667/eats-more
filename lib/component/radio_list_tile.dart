
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/model/check_out_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RadioListTilePayment extends StatelessWidget {
  final Function onChanged;
  final int index;
  final int selectedIndex;
 final List<Payment> paymentMethods;

  const RadioListTilePayment({Key key, this.onChanged, this.index, this.selectedIndex, this.paymentMethods}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return RadioListTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImageComponent(
              url: paymentMethods[index].image,
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(paymentMethods[index].key??""),
          ],
        ),
        value: selectedIndex,
        groupValue: index,
        onChanged: onChanged) ;
  }
}
