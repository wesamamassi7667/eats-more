
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/color.dart';
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
            CachedNetworkImage(
              imageUrl: paymentMethods[index].image,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CupertinoActivityIndicator(),
              errorWidget: (BuildContext context, String url, Object error) {
                print(error);
                return const Icon(Icons.error);
              },
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
