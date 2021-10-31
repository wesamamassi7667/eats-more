
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/material.dart';

class CheckOutRow extends StatelessWidget {
  final String title;
  final String text;
  final bool isPrice;
  const CheckOutRow({
    Key key, this.title, this.text, this.isPrice=true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: background
            ),
          ),
          Spacer(),
          Text(
            isPrice?text + AppLocalization.of(context).translate('sr'):text,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: background
            ),
          )
        ],
      ),
    );
  }
}
